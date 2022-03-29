import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../data/bloc/courseBloc.dart';
import '../../data/bloc/subjectBloc.dart';
import '../../data/utils/Utils.dart';
import '../../data/utils/data/course.dart';
import '../../data/utils/data/subject.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';
import '../course/courseList.dart';

class SubjectList extends StatefulWidget {
  final bool isSelect;

  const SubjectList({Key? key, this.isSelect = false}) : super(key: key);

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  SubjectData? _selectedSubject;

  bool _isLoading = true;

  void fetchSubjects() async {
    await context.read<SubjectBloc>().get();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerBody:
          _DetailsDrawer(initialSubjectData: _selectedSubject ?? SubjectData()),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _DataList(
              isSelect: widget.isSelect,
              subjects: context.watch<SubjectBloc>().subjects,
              onAddNew: () {
                setState(() {
                  _selectedSubject = SubjectData();
                });
              },
              onDetailClick: (subject) {
                setState(() {
                  _selectedSubject = subject;
                });
              },
            ),
    );
  }
}

class _DataList extends StatelessWidget {
  final bool isSelect;
  final List<SubjectData> subjects;
  final void Function() onAddNew;
  final void Function(SubjectData) onDetailClick;

  const _DataList({
    Key? key,
    required this.isSelect,
    required this.subjects,
    required this.onAddNew,
    required this.onDetailClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDataTable(
        onAddNew: () {
          onAddNew();
          Scaffold.of(context).openEndDrawer();
        },
        headersLabel: const [
          "#",
          "BASIC INFO",
          "CREATED ON",
          "UPDATED ON",
          "STATUS",
          "VISIBILITY",
          "ACTION",
        ],
        dataRows: [
          for (final s in subjects)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  s.id,
                  onTap: () {
                    onDetailClick(s);
                    Scaffold.of(context).openEndDrawer();
                  },
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: s.name,
                  subtitle: CourseBloc.getById(s.courseId)?.name ?? 'No Course',
                ),

                /// Created On
                CustomDataTable.getTextCell(getShortFormattedTime(s.createdAt)),

                /// Updated On
                CustomDataTable.getTextCell(getShortFormattedTime(s.updatedAt)),

                /// Status
                CustomDataTable.getChipCell(
                  s.isActive ? 'Active' : 'InActive',
                  s.isActive ? const Color(0xff28c76f) : Colors.red,
                ),

                /// Visibility
                CustomDataTable.getChipCell(
                  s.visibility,
                  s.visibility == 'None' ? Colors.red : const Color(0xff28c76f),
                ),

                /// Action
                CustomDataTable.getActionCell(),
              ],
            ),
        ],
      ),
    );
  }
}

class _DetailsDrawer extends StatefulWidget {
  final SubjectData initialSubjectData;

  const _DetailsDrawer({Key? key, required this.initialSubjectData})
      : super(key: key);

  @override
  State<_DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<_DetailsDrawer> {
  static final _formKey = GlobalKey<FormState>();

  late final TextEditingController _courseController =
      TextEditingController(text: CourseBloc.getById(_subject.courseId)?.name);

  late final _subject =
      SubjectData.fromJson(widget.initialSubjectData.toJson());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// drawer header

          DetailDrawerHeader(
            hasDoneButton: widget.initialSubjectData.name != _subject.name ||
                widget.initialSubjectData.img != _subject.img ||
                widget.initialSubjectData.courseId != _subject.courseId ||
                widget.initialSubjectData.notes != _subject.notes ||
                widget.initialSubjectData.visibility != _subject.visibility ||
                widget.initialSubjectData.isActive != _subject.isActive,
            onDone: () {
              if (_formKey.currentState!.validate()) {
                print('Hello Su Mit call api here and update the database');
                context.read<SubjectBloc>().add(_subject);
                Navigator.maybePop(context);
              }
            },
          ),

          /// info
          Expanded(
            child: ListView(
              children: [
                /// profile pic
                Center(
                  child: ProfileCircle(
                    noImageText: _subject.name.length > 2
                        ? _subject.name.substring(0, 2)
                        : _subject.name,
                    radius: 56,
                  ),
                ),

                SizedBox(height: 32),

                /// course
                IconTextField(
                  controller: _courseController,
                  labelText: 'Course',
                  icon: FeatherIcons.book,
                  readOnly: true,
                  onTap: () async {
                    final CourseData? c = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CourseList(isSelect: true)));

                    print('Selected course = $c');

                    if (c != null) {
                      setState(() {
                        _subject.courseId = c.id;
                        _courseController.text =
                            CourseBloc.getById(_subject.courseId)?.name ?? '';
                      });
                    }
                  },
                ),

                /// name
                IconTextField(
                  validator: (s) {
                    if (s == null) return 'Name is required';
                    if (s.trim().isEmpty) return 'Name is required';
                    return null;
                  },
                  labelText: 'Name',
                  icon: FeatherIcons.type,
                  initialText: widget.initialSubjectData.name,
                  onChanged: (name) => setState(() {
                    _subject.name = name;
                  }),
                ),

                /// status
                DropdownTextField(
                  options: ['Active', 'InActive'],
                  labelText: 'Status',
                  icon: FeatherIcons.toggleRight,
                  initialValue: widget.initialSubjectData.isActive
                      ? 'Active'
                      : 'InActive',
                  onChanged: (isActive) => setState(() {
                    _subject.isActive = isActive == 'Active';
                  }),
                ),

                /// visibility
                DropdownTextField(
                  options: ['Student', 'Teacher', 'Both', 'None'],
                  labelText: 'Visibility',
                  icon: FeatherIcons.users,
                  initialValue: widget.initialSubjectData.visibility,
                  onChanged: (v) => setState(() {
                    _subject.visibility = v!;
                  }),
                ),

                /// Notes or Comments
                IconTextField(
                  isMultipleLine: true,
                  labelText: 'Notes',
                  hintText: 'Add Some notes here...',
                  icon: FeatherIcons.edit,
                  initialText: widget.initialSubjectData.notes,
                  onChanged: (n) => setState(() {
                    _subject.notes = n;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
