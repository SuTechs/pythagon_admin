import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/customScaffold.dart';

import '../../widgets/CustomDataTable.dart';

class CollegeList extends StatelessWidget {
  const CollegeList({Key? key}) : super(key: key);

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
          "College",
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

                /// College Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'HKBK College of Eng',
                  subtitle: 'Planet Earth, Milky Way Galaxy, Universe 7',
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
