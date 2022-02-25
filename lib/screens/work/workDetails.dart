import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../constants.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/activityTimeline.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/detailPageComponents.dart';

class WorkDetails extends StatelessWidget {
  const WorkDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24),

            /// info & transactions
            SizedBox(
              height: 300,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Basic Info
                  Expanded(flex: 5, child: _BasicInfo()),

                  SizedBox(width: 24),

                  /// Payment & Transactions
                  Expanded(
                    flex: 2,
                    child: _PaymentInfo(),
                  )
                ],
              ),
            ),
            SizedBox(height: 24),

            /// teacher & activity
            SizedBox(
              height: 600,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Basic Info
                  Expanded(
                    flex: 5,
                    child: _TeacherInfo(),
                  ),

                  SizedBox(width: 24),

                  /// activity timeline
                  Expanded(
                    flex: 2,
                    child: _ActivityInfo(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BasicInfo extends StatelessWidget {
  const _BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailBasicInfoTile(
      otherInfoData: [
        OtherInfoIconTileData(
          '\$300',
          'Total',
          FeatherIcons.dollarSign,
          kActiveColor,
        ),
        OtherInfoIconTileData(
          "29 Jan 2021",
          'Due Date',
          Icons.calendar_today_sharp,
          Colors.red,
        ),
        OtherInfoIconTileData(
          "Uchit Chakma",
          '8979767368',
          FontAwesome5.graduation_cap,
          Colors.green,
        ),
      ],
    );
  }
}

class _TeacherInfo extends StatelessWidget {
  const _TeacherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomDataTable(
        headersLabel: const [
          "#",
          "INFO",
          "RATING",
          "PRICE",
          "STATUS",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 20; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell(
                  '6262',
                  onTap: () {},
                ),

                /// Basic Info
                CustomDataTable.getBasicInfoCell(
                  title: 'Tammy Sanchez',
                  subtitle: 'Python',
                  noImageText: 'Py',
                ),

                /// Rating
                CustomDataTable.getTextCell('4.1(23)'),

                /// Price
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell('Paid', const Color(0xff28c76f)),

                /// Action
                CustomDataTable.getActionCell(),
              ],
            ),
        ],
      ),
    );
  }
}

class _PaymentInfo extends StatelessWidget {
  const _PaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailTabView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      tabTitles: [
        'Overview',
        'Transaction',
        'New',
      ],
      children: [
        _PaymentOverview(),
        _TransactionsTab(),
        _NewTransactionTab(),
      ],
    );
  }
}

class _PaymentOverview extends StatelessWidget {
  const _PaymentOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),

        /// Currency
        DropdownPickerWithIcon(
          hint: 'Select Currency',
          options: [
            'USD',
            'INR',
            'CAD',
            'GBP',
          ],
          colors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.pink,
          ],
          optionsIcon: [
            FeatherIcons.dollarSign,
            Icons.currency_rupee,
            Icons.currency_yen,
            Icons.currency_pound,
          ],
        ),

        /// Prices
        PriceTextField(prefixText: 'Deal Amount'),
        PriceTextField(prefixText: 'Coupon'),
        PriceTextField(prefixText: 'Tax'),
        Spacer(),

        /// Total Price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: kTextDarkGrey,
              ),
            ),
            Text(
              '\$500',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: kTextDarkGrey,
              ),
            ),
          ],
        ),

        /// Buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shadowColor: Colors.transparent,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {},
            child: Text(
              'Due: \$7828',
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionsTab extends StatelessWidget {
  const _TransactionsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < 7; i++)
          ListTile(
            dense: true,
            visualDensity: VisualDensity.standard,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            horizontalTitleGap: 3,
            leading: CircleAvatar(
              radius: 16,
              backgroundColor:
                  (i % 2 == 0 ? Colors.green : Colors.red).withOpacity(0.12),
              child: Icon(
                i % 2 == 0
                    ? FeatherIcons.arrowDownLeft
                    : FeatherIcons.arrowUpRight,
                color: i % 2 == 0 ? Colors.green : Colors.red,
                size: 14,
              ),
            ),
            title: Text(
              'Money Credited',
              style: TextStyle(
                color: Color(0xff6e6b7b),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              '19 Apr 2022',
              style: TextStyle(
                color: Color(0xffb9b9c3),
                fontSize: 11.9,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Text(
              '\$76',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: i % 2 == 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}

class _NewTransactionTab extends StatelessWidget {
  const _NewTransactionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),

        /// Credit / Debit Picker
        DropdownPickerWithIcon(
          hint: 'Select Transaction Type',
          colors: [
            Colors.green,
            Colors.red,
          ],
          options: [
            'Credit',
            'Debit',
          ],
          optionsIcon: [
            FeatherIcons.arrowDownLeft,
            FeatherIcons.arrowUpRight,
          ],
        ),

        /// amount
        PriceTextField(prefixText: 'Amount'),
        SizedBox(height: 8),

        /// description
        Expanded(
          child: DescriptionTextField(
            hintText: 'Description',
            style: TextStyle(fontSize: 13),
            onDescChanged: (_) {
              print('$_');
            },
          ),
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

        /// done button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shadowColor: Colors.transparent,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {},
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        SizedBox(height: 8),
      ],
    );
  }
}

class _ActivityInfo extends StatelessWidget {
  const _ActivityInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      child: Column(
        children: [
          Expanded(
            child: TimelineBuilder(
              timeLineData: [
                TimelineTileData(
                  msgType: 0,
                  title: "Subjects changed",
                  subtitle: "Subjects price changed",
                  timeAgo: "3 days ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Uchit Changes",
                  subtitle:
                      "Uploaded Files: I have uploaded the files of Vivek tutor. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Harshit Ranjhan",
                  subtitle: "@Uchitchakma: How many have you Changed. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 0,
                  title: "Subjects changed",
                  subtitle: "Subjects price changed",
                  timeAgo: "3 days ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Uchit Changes",
                  subtitle:
                      "Uploaded Files: I have uploaded the files of Vivek tutor. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Harshit Ranjhan",
                  subtitle: "@Uchitchakma: How many have you Changed. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 0,
                  title: "Subjects changed",
                  subtitle: "Subjects price changed",
                  timeAgo: "3 days ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Uchit Changes",
                  subtitle:
                      "Uploaded Files: I have uploaded the files of Vivek tutor. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Harshit Ranjhan",
                  subtitle: "@Uchitchakma: How many have you Changed. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 0,
                  title: "Subjects changed",
                  subtitle: "Subjects price changed",
                  timeAgo: "3 days ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Uchit Changes",
                  subtitle:
                      "Uploaded Files: I have uploaded the files of Vivek tutor. ",
                  timeAgo: "2 hours ago",
                ),
                TimelineTileData(
                  msgType: 1,
                  title: "Harshit Ranjhan",
                  subtitle: "@Uchitchakma: How many have you Changed. ",
                  timeAgo: "2 hours ago",
                ),
              ],
            ),
          ),

          /// Text field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 100),
              child: DescriptionTextField(
                style: TextStyle(fontSize: 13),
                hintText: 'Enter something',
                onDescChanged: (_) {},
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: kActiveColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
