import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/collegeBloc.dart';
import 'package:pythagon_admin/data/data.dart';

import '../../data/utils/Utils.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  CourseData? _selectedCourse;

  bool _isLoading = true;

  void fetchCourse() async {
    await context.read<CourseBloc>().getCourses();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerBody:
          _DetailsDrawer(initialCourseData: _selectedCourse ?? CourseData()),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _DataList(
              courses: context.watch<CourseBloc>().courses,
              onAddNew: () {
                setState(() {
                  _selectedCourse = CourseData();
                });
              },
              onDetailClick: (course) {
                setState(() {
                  _selectedCourse = course;
                });
              },
            ),
    );
  }
}

class _DataList extends StatelessWidget {
  final List<CourseData> courses;
  final void Function() onAddNew;
  final void Function(CourseData) onDetailClick;

  const _DataList({
    Key? key,
    required this.courses,
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
          "COURSE",
          "CREATED ON",
          "UPDATED ON",
          "STATUS",
          "VISIBILITY",
          "ACTION",
        ],
        dataRows: [
          for (final c in courses)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  c.id,
                  onTap: () {
                    onDetailClick(c);
                    Scaffold.of(context).openEndDrawer();
                  },
                ),

                /// Course Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: c.name,
                ),

                /// Created On
                CustomDataTable.getTextCell(getShortFormattedTime(c.createdAt)),

                /// Updated On
                CustomDataTable.getTextCell(getShortFormattedTime(c.updatedAt)),

                /// Status
                CustomDataTable.getChipCell(
                  c.isActive ? 'Active' : 'InActive',
                  c.isActive ? const Color(0xff28c76f) : Colors.red,
                ),

                /// Visibility
                CustomDataTable.getChipCell(
                  c.visibility,
                  c.visibility == 'None' ? Colors.red : const Color(0xff28c76f),
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
  final CourseData initialCourseData;

  const _DetailsDrawer({Key? key, required this.initialCourseData})
      : super(key: key);

  @override
  State<_DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<_DetailsDrawer> {
  static final _formKey = GlobalKey<FormState>();

  late final _course = CourseData.fromJson(widget.initialCourseData.toJson());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// drawer header

          DetailDrawerHeader(
            hasDoneButton: widget.initialCourseData.name != _course.name ||
                widget.initialCourseData.img != _course.img ||
                widget.initialCourseData.notes != _course.notes ||
                widget.initialCourseData.visibility != _course.visibility ||
                widget.initialCourseData.isActive != _course.isActive,
            onDone: () {
              if (_formKey.currentState!.validate()) {
                print('Hello Su Mit call api here and update the database');

                context.read<CourseBloc>().addCourse(_course);
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
                    noImageText: _course.name.length > 2
                        ? _course.name.substring(0, 2)
                        : _course.name,
                    radius: 56,
                  ),
                ),

                SizedBox(height: 32),

                /// name
                IconTextField(
                  validator: (s) {
                    if (s == null) return 'Name is required';
                    if (s.trim().isEmpty) return 'Name is required';
                    return null;
                  },
                  labelText: 'Name',
                  icon: FeatherIcons.type,
                  initialText: widget.initialCourseData.name,
                  onChanged: (name) => setState(() {
                    _course.name = name;
                  }),
                ),

                /// status
                DropdownTextField(
                  options: ['Active', 'InActive'],
                  labelText: 'Status',
                  icon: FeatherIcons.toggleRight,
                  initialValue:
                      widget.initialCourseData.isActive ? 'Active' : 'InActive',
                  onChanged: (isActive) => setState(() {
                    _course.isActive = isActive == 'Active';
                  }),
                ),

                /// visibility
                DropdownTextField(
                  options: ['Student', 'Teacher', 'Both', 'None'],
                  labelText: 'Visibility',
                  icon: FeatherIcons.users,
                  initialValue: widget.initialCourseData.visibility,
                  onChanged: (v) => setState(() {
                    _course.visibility = v!;
                  }),
                ),

                /// Notes or Comments
                IconTextField(
                  isMultipleLine: true,
                  labelText: 'Notes',
                  hintText: 'Add Some notes here...',
                  icon: FeatherIcons.edit,
                  initialText: widget.initialCourseData.notes,
                  onChanged: (n) => setState(() {
                    _course.notes = n;
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
