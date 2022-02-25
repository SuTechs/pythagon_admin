import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../screens/work/workDetails.dart';
import 'CustomDataTable.dart';

class WorkDataTable extends StatelessWidget {
  const WorkDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDataTable(
        headersLabel: const [
          "#",
          "TYPE",
          "BASIC INFO",
          "ISSUE DATE",
          "DUE DATE",
          "BALANCE",
          "STATUS",
          "COMMENT",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 20; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => WorkDetails(),
                      ),
                    );
                  },
                ),

                /// Type
                CustomDataTable.getTypeCell(
                  Colors.green,
                  FontAwesome5.book_reader,
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Tammy Sanchez',
                  subtitle: 'Python',
                  noImageText: 'Py',
                ),

                /// Issue Date
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Due Date
                CustomDataTable.getTextCell('23 Apr 2022'),

                /// Balance
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell('Paid', const Color(0xff28c76f)),

                /// Comment
                CustomDataTable.getCommentCell(
                  'New Teacher Assigned For The Assignment',
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
