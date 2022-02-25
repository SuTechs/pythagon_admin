import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../constants.dart';
import '../../widgets/CustomDataTable.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/detailPageComponents.dart';

class TeacherDetails extends StatelessWidget {
  const TeacherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),

            /// info & doc
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
                    child: _DocInfo(),
                  )
                ],
              ),
            ),
            SizedBox(height: 24),

            /// subjects
            SizedBox(
              height: 600,
              child: _SubjectInfo(),
            ),

            SizedBox(height: 24),

            /// works
            SizedBox(
              height: 600,
              child: _WorkInfo(),
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
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DetailBasicInfoTile(
            isSubject: false,
            otherInfoData: [
              OtherInfoIconTileData(
                '\$300',
                'Total',
                FeatherIcons.dollarSign,
                kActiveColor,
              ),
              OtherInfoIconTileData(
                "4.5(50)",
                'Rating',
                FeatherIcons.star,
                Colors.red,
              ),
              OtherInfoIconTileData(
                "Verified",
                'Status',
                Icons.done,
                Colors.green,
              ),
            ],
          ),
        ),

        /// info
        Expanded(
          child: Container(
            color: kForegroundColor,
            child: ListView(
              children: [
                SizedBox(height: 16),

                /// username
                SingleLineIconTextField(
                  labelText: 'Username',
                  labelIcon: FeatherIcons.user,
                  hintText: 'darksumit',
                  initialText: 'darkSuMit',
                ),

                /// phone
                SingleLineIconTextField(
                  labelText: 'Phone',
                  labelIcon: FeatherIcons.phone,
                  hintText: '987654321',
                  initialText: '+91 7667323338',
                ),

                /// email
                SingleLineIconTextField(
                  labelText: 'Email',
                  labelIcon: FeatherIcons.mail,
                  hintText: 'example@mail.com',
                  initialText: 'sumit123210@gmail.com',
                ),

                /// college
                SingleLineIconTextField(
                  labelText: 'College',
                  labelIcon: FeatherIcons.home,
                  hintText: 'IIT Delhi',
                  initialText: 'Dark College',
                ),

                /// branch
                SingleLineIconTextField(
                  labelText: 'Branch',
                  labelIcon: FeatherIcons.book,
                  hintText: 'Mechanical Eng',
                  initialText: 'CSE',
                ),

                /// join on
                SingleLineIconTextField(
                  labelText: 'Join On',
                  labelIcon: FeatherIcons.calendar,
                  hintText: '24 Feb 2022',
                  initialText: '2 March 2022',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DocInfo extends StatelessWidget {
  const _DocInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailTabView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      tabTitles: [
        'Account Info',
        'Documents',
      ],
      children: [
        _AccountInfoTab(),
        AttachmentList(
          files: [],
          onFileDelete: (s) async {},
          onFilesUpload: (s) async {},
        ),
      ],
    );
  }
}

class _AccountInfoTab extends StatelessWidget {
  const _AccountInfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),

        /// account no
        SingleLineIconTextField(
          labelText: 'Account No',
          labelIcon: Icons.account_balance,
        ),

        /// account no
        SingleLineIconTextField(
          labelText: 'Account Name',
          labelIcon: Icons.person,
        ),

        /// IFSC no
        SingleLineIconTextField(
          labelText: 'IFSC No',
          labelIcon: Icons.account_balance_wallet,
        ),

        /// Pan no
        SingleLineIconTextField(
          labelText: 'Pan No',
          labelIcon: Icons.key,
        ),

        Spacer(),

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
      ],
    );
  }
}

class _SubjectInfo extends StatelessWidget {
  const _SubjectInfo({Key? key}) : super(key: key);

  final _tabs = const <String>[
    'CSE',
    'Mechanical',
    'Electrical',
    'Civil',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    return DetailTabView(
      padding: EdgeInsets.all(0),
      tabTitles: _tabs,
      children: [
        for (int i = 0; i < _tabs.length; i++)
          SingleChildScrollView(
            child: CustomDataTable(
              headersLabel: const [
                "#",
                "BASIC INFO",
                "APPLIED DATE",
                "STATUS",
                "RATING",
                "PAYMENT",
                "COMMENT",
                "ACTION",
              ],
              dataRows: [
                for (int i = 0; i < 20; i++)
                  DataRow(
                    cells: [
                      /// ID
                      CustomDataTable.getIdCell('6262'),

                      /// Basic Info
                      CustomDataTable.getBasicInfoCell(
                        title: 'Python',
                      ),

                      /// Applied Date
                      CustomDataTable.getTextCell('19 Apr 2022'),

                      /// Status
                      CustomDataTable.getChipCell(
                        'Verified',
                        const Color(0xff28c76f),
                      ),

                      /// Rating
                      CustomDataTable.getTextCell('4.1(23)'),

                      /// Payment
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
          ),
      ],
    );
  }
}

class _WorkInfo extends StatelessWidget {
  const _WorkInfo({Key? key}) : super(key: key);

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
          "PAYMENT",
          "STATUS",
          "RATING",
          // "COMMENT",
          "ACTION",
        ],
        dataRows: [
          for (int i = 0; i < 20; i++)
            DataRow(
              cells: [
                /// ID
                CustomDataTable.getIdCell('6262'),

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

                /// Payment
                CustomDataTable.getTextCell('\$762'),

                /// Status
                CustomDataTable.getChipCell('Paid', const Color(0xff28c76f)),

                /// Rating
                CustomDataTable.getTextCell('4.1(23)'),

                // /// Comment
                // CustomDataTable.getCommentCell(
                //   'New Teacher Assigned For The Assignment',
                // ),

                /// Action
                CustomDataTable.getActionCell(),
              ],
            ),
        ],
      ),
    );
  }
}
