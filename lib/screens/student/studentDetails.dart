import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/detailPageComponents.dart';
import '../../widgets/workDataTable.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),

            /// info & doc
            SizedBox(
              height: 300,
              child: _BasicInfo(),
            ),
            SizedBox(height: 24),

            WorkDataTable(),
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
    return StudentTeacherBasicInfo(
      otherInfoData: [
        OtherInfoIconTileData(
          '\$300',
          'Total',
          FeatherIcons.dollarSign,
          kActiveColor,
        ),
        OtherInfoIconTileData(
          "45/50",
          'Work',
          FeatherIcons.briefcase,
          Colors.red,
        ),
        OtherInfoIconTileData(
          "Active",
          'Status',
          Icons.done,
          Colors.green,
        ),
      ],
      fields: [
        /// username
        IconTextField(
          labelText: 'Username',
          icon: FeatherIcons.user,
          hintText: 'darksumit',
          initialText: 'darkSuMit',
        ),

        /// phone
        IconTextField(
          labelText: 'Phone',
          icon: FeatherIcons.phone,
          hintText: '987654321',
          initialText: '+91 7667323338',
        ),

        /// email
        IconTextField(
          labelText: 'Email',
          icon: FeatherIcons.mail,
          hintText: 'example@mail.com',
          initialText: 'sumit123210@gmail.com',
        ),

        /// college
        IconTextField(
          labelText: 'College',
          icon: FeatherIcons.home,
          hintText: 'IIT Delhi',
          initialText: 'Dark College',
        ),

        /// branch
        IconTextField(
          labelText: 'Branch',
          icon: FeatherIcons.book,
          hintText: 'Mechanical Eng',
          initialText: 'CSE',
        ),

        /// join on
        IconTextField(
          labelText: 'Join On',
          icon: FeatherIcons.calendar,
          hintText: '24 Feb 2022',
          initialText: '2 March 2022',
        ),
      ],
    );
  }
}
