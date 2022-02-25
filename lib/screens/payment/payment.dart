import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../constants.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        children: [
          SizedBox(height: 16),

          /// payment overview
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PaymentOverview(
                total: 600,
                pending: 86,
              ),
              SizedBox(width: 16),
              _PaymentOverview(
                total: 600,
                pending: 86,
                isExpenses: true,
              ),
            ],
          ),

          SizedBox(height: 16),

          /// payment list
          _DataList()
        ],
      ),
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
          "STATUS",
          "PAYMENT INFO",
          "DATE",
          "AMOUNT",
          "COMMENT",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 10; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell('6262'),

                /// Status
                CustomDataTable.getTypeCell(
                  Colors.green,
                  FontAwesome5.book_reader,
                ),

                /// Payment Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Tammy Sanchez',
                  subtitle: 'Python',
                  iconData: i % 2 == 0
                      ? FeatherIcons.arrowDownLeft
                      : FeatherIcons.arrowUpRight,
                  color: i % 2 == 0 ? Colors.green : Colors.red,
                ),

                /// Date
                CustomDataTable.getTextCell('19 Apr 2022'),

                /// Amount
                CustomDataTable.getTextCell('\$762'),

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

class _PaymentOverview extends StatefulWidget {
  final bool isExpenses;
  final double total;
  final double pending;

  const _PaymentOverview({
    Key? key,
    this.isExpenses = false,
    required this.total,
    required this.pending,
  }) : super(key: key);

  @override
  State<_PaymentOverview> createState() => _PaymentOverviewState();
}

class _PaymentOverviewState extends State<_PaymentOverview> {
  late final _dropdownValues = const [
    'Last 28 days',
    'Last 3 months',
    'Last 6 months',
    'Last 1 year',
  ];

  late String value = _dropdownValues[0];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isExpenses
              ? Colors.red.withOpacity(0.12)
              : Colors.green.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton<String>(
              underline: SizedBox(),
              value: value,
              isDense: true,
              iconEnabledColor: kTextDarkGrey,
              iconSize: 18,
              items: [
                for (final v in _dropdownValues)
                  DropdownMenuItem<String>(
                    value: v,
                    child: Text(
                      v,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: kTextDarkGrey,
                      ),
                    ),
                  )
              ],
              onChanged: (v) {
                if (v != null)
                  setState(() {
                    value = v;
                  });
              },
            ),

            /// total received / expenses
            Row(
              children: [
                /// total
                Expanded(
                  child: ListTile(
                    visualDensity: VisualDensity.standard,
                    dense: true,
                    leading: Icon(
                      FontAwesome.credit_card,
                      color: widget.isExpenses ? Colors.red : Colors.green,
                    ),
                    title: Text(
                      "Total Received",
                      style: TextStyle(
                        color: const Color(0xff70697B),
                      ),
                    ),
                    subtitle: Text(
                      r"$ 947,472.78",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: widget.isExpenses ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                ),

                /// pending

                Expanded(
                  child: ListTile(
                    visualDensity: VisualDensity.standard,
                    dense: true,
                    leading: Icon(
                      Icons.timer,
                      color: Colors.yellow,
                    ),
                    title: Text(
                      "Pending",
                      style: TextStyle(
                        color: const Color(0xff70697B),
                      ),
                    ),
                    subtitle: Text(
                      r"$ 472",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
