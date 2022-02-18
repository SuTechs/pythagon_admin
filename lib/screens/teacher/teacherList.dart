import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/customScaffold.dart';

import '../../widgets/CustomDataTable.dart';

class TeacherList extends StatelessWidget {
  TeacherList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
          "BASIC INFO",
          "DATE",
          "RATING",
          "PAYMENT",
          "DUE",
          "STATUS",
          "SUBJECT",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 10; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell('6262'),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  noImageText: 'Ta',
                  title: 'Tammy Sanchez',
                  subtitle: '+91 7667323338',
                ),

                /// Date
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Rating
                CustomDataTable.getTextCell('4.1(23)'),

                /// Payment
                CustomDataTable.getTextCell('\$762'),

                /// Due
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell(
                  'Verified',
                  const Color(0xff28c76f),
                ),

                /// Subject
                CustomDataTable.getCommentCell(
                  'Py, C++, Physics, Maths, ML, MATLAB',
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
