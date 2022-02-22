import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/widgets/customScaffold.dart';

import '../../widgets/CustomDataTable.dart';
import '../../widgets/activityTimeline.dart';
import '../../widgets/customTextField.dart';

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
    return Container(
      color: kForegroundColor,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          /// Subject name and description
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Subject
              Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "PYTHON",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kTextDarkGrey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "COMP SCIENCE",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: kTextDarkGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16),

              /// name & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    SingleLineTextField(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff70697B),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: DescriptionTextField(
                        onDescChanged: (_) {},
                        hintText: 'Enter Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: kTextLightGrey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          Spacer(),

          /// other info
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getTile('\$300', 'Total', FeatherIcons.dollarSign, kActiveColor),
              _getTile("29 Jan 2021", 'Due Date', Icons.calendar_today_sharp,
                  Colors.red),
              _getTile("Uchit Chakma", '8979767368',
                  FontAwesome5.graduation_cap, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getTile(String title, subtitle, IconData icon, Color color) =>
      Flexible(
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: color.withOpacity(0.12),
            ),
            child: Center(
              child: Icon(
                icon,
                color: color,
                size: 16.0,
              ),
            ),
          ),
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: kTextDarkGrey,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: kTextDarkGrey,
              fontSize: 12,
            ),
          ),
        ),
      );
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

class _PaymentInfo extends StatefulWidget {
  const _PaymentInfo({Key? key}) : super(key: key);

  @override
  State<_PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<_PaymentInfo>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: kForegroundColor,
          child: TabBar(
            // indicator: BoxDecoration(
            //   color: const Color(0xfff3f2f7),
            // ),
            // isScrollable: true,
            unselectedLabelColor: Color(0xff70697B),
            labelColor: kActiveColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: kActiveColor,
            indicatorWeight: 1.0,
            tabs: const [
              Tab(
                text: "Overview",
              ),
              Tab(
                text: "Transaction",
              ),
              Tab(
                text: "New",
              ),
            ],
            controller: tabController,
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: Container(
            color: kForegroundColor,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBarView(
              controller: tabController,
              children: [
                _PaymentOverview(),
                _TransactionsTab(),
                _NewTransactionTab(),
              ],
            ),
          ),
        ),
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
