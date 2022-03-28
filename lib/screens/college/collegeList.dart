import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/collegeBloc.dart';

import '../../data/data.dart';
import '../../data/utils/Utils.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';

class CollegeList extends StatefulWidget {
  final bool isSelect;

  const CollegeList({Key? key, this.isSelect = false}) : super(key: key);

  @override
  State<CollegeList> createState() => _CollegeListState();
}

class _CollegeListState extends State<CollegeList> {
  CollegeData? _selectedCollege;

  bool _isLoading = true;

  void fetchCollege() async {
    await context.read<CollegeBloc>().getCollege();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchCollege();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerBody:
          _DetailsDrawer(initialCollegeData: _selectedCollege ?? CollegeData()),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _DataList(
              isSelect: widget.isSelect,
              colleges: context.watch<CollegeBloc>().colleges,
              onAddNew: () {
                setState(() {
                  _selectedCollege = CollegeData();
                });
              },
              onDetailClick: (college) {
                setState(() {
                  // _selectedCollege = CollegeData.fromJson(college.toJson());
                  _selectedCollege = college;
                });
              },
            ),
    );
  }
}

class _DataList extends StatelessWidget {
  final bool isSelect;
  final List<CollegeData> colleges;
  final void Function() onAddNew;
  final void Function(CollegeData) onDetailClick;

  const _DataList({
    Key? key,
    required this.colleges,
    required this.onAddNew,
    required this.onDetailClick,
    required this.isSelect,
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
          "College",
          "CREATED ON",
          "UPDATED ON",
          "STATUS",
          "VISIBILITY",
          "ACTION",
        ],
        dataRows: [
          for (final c in colleges)
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

                /// College Basic Info
                CustomDataTable.getBasicInfoCell(
                  onTap: isSelect
                      ? () {
                          Navigator.pop(context, c);
                        }
                      : null,
                  title: c.name,
                  subtitle: c.address,
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
  final CollegeData initialCollegeData;

  const _DetailsDrawer({Key? key, required this.initialCollegeData})
      : super(key: key);

  @override
  State<_DetailsDrawer> createState() => _DetailsDrawerState();
}

class _DetailsDrawerState extends State<_DetailsDrawer> {
  static final _formKey = GlobalKey<FormState>();

  late final _college =
      CollegeData.fromJson(widget.initialCollegeData.toJson());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// drawer header

          DetailDrawerHeader(
            hasDoneButton: widget.initialCollegeData.name != _college.name ||
                widget.initialCollegeData.img != _college.img ||
                widget.initialCollegeData.address != _college.address ||
                widget.initialCollegeData.notes != _college.notes ||
                widget.initialCollegeData.visibility != _college.visibility ||
                widget.initialCollegeData.isActive != _college.isActive,
            onDone: () {
              if (_formKey.currentState!.validate()) {
                print('Hello Su Mit call api here and update the database');
                context.read<CollegeBloc>().addCollege(_college);
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
                    noImageText: _college.name.length > 2
                        ? _college.name.substring(0, 2)
                        : _college.name,
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
                  initialText: widget.initialCollegeData.name,
                  onChanged: (name) => setState(() {
                    _college.name = name;
                  }),
                ),

                /// address
                IconTextField(
                  validator: (s) {
                    if (s == null) return 'Address is required';
                    if (s.trim().isEmpty) return 'Address is required';
                    return null;
                  },
                  labelText: 'Address',
                  hintText: 'Bangalore, India',
                  icon: FeatherIcons.mapPin,
                  initialText: widget.initialCollegeData.address,
                  onChanged: (address) => setState(() {
                    _college.address = address;
                  }),
                ),

                /// status
                DropdownTextField(
                  options: ['Active', 'InActive'],
                  labelText: 'Status',
                  icon: FeatherIcons.toggleRight,
                  initialValue: widget.initialCollegeData.isActive
                      ? 'Active'
                      : 'InActive',
                  onChanged: (isActive) => setState(() {
                    _college.isActive = isActive == 'Active';
                  }),
                ),

                /// visibility
                DropdownTextField(
                  options: ['Student', 'Teacher', 'Both', 'None'],
                  labelText: 'Visibility',
                  icon: FeatherIcons.users,
                  initialValue: widget.initialCollegeData.visibility,
                  onChanged: (v) => setState(() {
                    _college.visibility = v!;
                  }),
                ),

                /// Notes or Comments
                IconTextField(
                  isMultipleLine: true,
                  labelText: 'Notes',
                  hintText: 'Add Some notes here...',
                  icon: FeatherIcons.edit,
                  initialText: widget.initialCollegeData.notes,
                  onChanged: (n) => setState(() {
                    _college.notes = n;
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
