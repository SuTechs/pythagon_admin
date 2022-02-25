import 'package:flutter/material.dart';

import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';

class AdminList extends StatelessWidget {
  const AdminList({Key? key}) : super(key: key);

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
          "ADMIN INFO",
          "CREATED ON",
          "UPDATED ON",
          "STATUS",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 10; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell('6262'),

                /// Admin Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Su Mit',
                  subtitle: 'A Fucking God',
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

                /// Action
                CustomDataTable.getActionCell(),
              ],
            ),
        ],
      ),
    );
  }
}
