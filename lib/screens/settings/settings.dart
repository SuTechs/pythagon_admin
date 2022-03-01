import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants.dart';
import '../../widgets/customScaffold.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/detailPageComponents.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Basic Info
              Expanded(flex: 3, child: _BasicInfo()),

              SizedBox(width: 24),

              /// Payment & Transactions
              Expanded(
                flex: 1,
                child: _ChangePassword(),
              )
            ],
          ),
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
          '\$267/300',
          'Payment',
          FeatherIcons.dollarSign,
          kActiveColor,
        ),
        OtherInfoIconTileData(
          "45/67",
          'Work',
          FeatherIcons.star,
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

class _ChangePassword extends StatelessWidget {
  const _ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kForegroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Change Your Password",
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

          /// current password
          IconTextField(
            labelText: 'Current Password',
            icon: Icons.lock_outline,
          ),

          /// new password
          IconTextField(
            labelText: 'New Password',
            icon: Icons.lock_outline,
          ),

          /// confirm new password
          IconTextField(
            labelText: 'Confirm New Password',
            icon: Icons.lock_outline,
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
                'Change Password',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
