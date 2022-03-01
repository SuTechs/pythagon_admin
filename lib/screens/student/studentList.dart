import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import 'studentDetails.dart';

class StudentList extends StatelessWidget {
  StudentList({Key? key}) : super(key: key);

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
          "CREATED ON",
          "WORK",
          "PAYMENT",
          "DUE",
          "STATUS",
          "ACTION"
        ],
        dataRows: [
          for (int i = 0; i < 10; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => StudentDetails(),
                      ),
                    );
                  },
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  noImageText: 'Ta',
                  title: 'Tammy Sanchez',
                  subtitle: '+91 7667323338',
                ),

                /// Date Added
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Total Work
                CustomDataTable.getTextCell('16/19'),

                /// Payment
                CustomDataTable.getTextCell('\$762'),

                /// Due
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell(
                  'Verified',
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
