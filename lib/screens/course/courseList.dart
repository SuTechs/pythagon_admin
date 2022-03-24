import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';

class CourseList extends StatelessWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerBody: _DetailsDrawer(),
      body: _DataList(),
    );
  }
}

class _DataList extends StatelessWidget {
  const _DataList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDataTable(
        headersLabel: const [
          "#",
          "COURSE",
          // "SUBJECTS",
          "CREATED ON",
          "UPDATED ON",
          "STATUS",
          "VISIBILITY",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 10; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                ),

                /// Course Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'CSE',
                ),

                // /// Subject
                // CustomDataTable.getCommentCell(
                //   'Py, C++, Physics, Maths, ML, MATLAB',
                // ),

                /// Created On
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Updated On
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Status
                CustomDataTable.getChipCell(
                  'Active',
                  const Color(0xff28c76f),
                ),

                /// Visibility
                CustomDataTable.getChipCell(
                  'Both',
                  const Color(0xff28c76f),
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

class _DetailsDrawer extends StatelessWidget {
  const _DetailsDrawer({Key? key}) : super(key: key);

  // final TextEditingController _name = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// drawer header

          DetailDrawerHeader(
            onDone: () {
              if (_formKey.currentState!.validate()) {
                print('Hello Su Mit call api here and update the database');
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
                    noImageText: 'Su',
                    radius: 56,
                  ),
                ),

                SizedBox(height: 32),

                /// name
                IconTextField(
                  labelText: 'Name',
                  icon: FeatherIcons.type,
                  initialText: 'CSE',
                ),

                // /// subjects
                // IconTextField(
                //   labelText: 'Subjects',
                //   hintText: 'C++, Math',
                //   icon: FeatherIcons.mapPin,
                // ),

                /// status
                DropdownTextField(
                  options: ['Active', 'InActive'],
                  labelText: 'Status',
                  icon: FeatherIcons.toggleRight,
                  initialValue: 'Active',
                ),

                /// visibility
                DropdownTextField(
                  options: ['Student', 'Teacher', 'Both', 'None'],
                  labelText: 'Visibility',
                  icon: FeatherIcons.users,
                  initialValue: 'None',
                ),

                /// notes or comments
                IconTextField(
                  isMultipleLine: true,
                  labelText: 'Notes',
                  hintText: 'Add Some notes here...',
                  icon: FeatherIcons.edit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
