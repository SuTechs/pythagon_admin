import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../constants.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';

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
                      color: const Color(0xffFF9B26),
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
                          color: const Color(0xffFF9B26)),
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

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      drawerBody: _DetailsDrawer(),
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
        hasTopMargin: false,
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
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                ),

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

class _DetailsDrawer extends StatelessWidget {
  const _DetailsDrawer({Key? key}) : super(key: key);

  // final TextEditingController _name = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          SizedBox(height: 16),

          Text(
            "Add New Transaction",
            style: TextStyle(
              color: kTextColor2,
            ),
          ),

          SizedBox(height: 16),
          Divider(
            height: 0.4,
            color: kTextLightGrey.withOpacity(0.4),
          ),

          SizedBox(height: 16),

          /// credit / debit
          DropdownTextField(
            options: ['Credit', 'Debit'],
            labelText: 'Type',
            icon: FeatherIcons.arrowDownLeft,
            initialValue: 'Credit',
          ),

          /// currency
          DropdownTextField(
            options: ['USD', 'INR', 'CAD', 'GBP'],
            labelText: 'Currency',
            icon: FeatherIcons.dollarSign,
            initialValue: 'INR',
          ),

          /// amount
          IconTextField(
            labelText: 'Amount',
            icon: FeatherIcons.hash,
          ),

          /// notes or comments
          IconTextField(
            isMultipleLine: true,
            labelText: 'Notes',
            hintText: 'Add Some notes here...',
            icon: FeatherIcons.edit,
          ),

          /// attachment
          ListTile(
            dense: true,
            visualDensity: VisualDensity.standard,
            contentPadding: EdgeInsets.all(0),
            horizontalTitleGap: 3,
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: kActiveColor.withOpacity(0.12),
              child: Icon(
                FeatherIcons.uploadCloud,
                color: kActiveColor,
              ),
            ),
            title: Text(
              "Upload Image",
              style: TextStyle(
                color: Color(0xff6e6b7b),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
