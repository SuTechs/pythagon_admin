import 'package:flutter/material.dart';

import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({Key? key}) : super(key: key);

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
                CustomDataTable.getIdCell('6262'),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Python',
                ),

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
