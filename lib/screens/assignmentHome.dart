import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/data/bloc/currentAssignmentBloc.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/homeLayout.dart';

import 'assignmentDetails.dart';
import 'assignmentList.dart';

class AssignmentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Provider.of<UserData>(context).isDarkMode
            ? kDarkModeSecondaryColor
            : kLightModeSecondaryColor,
        elevation: 0.5,
        actions: [
          /// logout
          TextButton(
              child: Text(
                'Hi! ${UserData.authData!.displayName}',
                style: TextStyle(
                  color: !Provider.of<UserData>(context).isDarkMode
                      ? kDarkModeBackgroundColor
                      : kLightModeBackgroundColor,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  CurrentAssignmentBloc().onLogOut();
                });
              }),

          /// dark mode
          IconButton(
              icon: Icon(
                !Provider.of<UserData>(context).isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.wb_sunny,
                color: !Provider.of<UserData>(context).isDarkMode
                    ? kDarkModeBackgroundColor
                    : kLightModeBackgroundColor,
              ),
              onPressed: () {
                UserData().isDarkMode = !UserData().isDarkMode;
              }),
        ],
      ),
      body: HomeLayout(
        lessWidthChild: AssignmentList(),
        moreWidthChild:
            Provider.of<CurrentAssignmentBloc>(context).assignment != null
                ? AssignmentDetails()
                : CustomContainer(
                    child: Center(
                      child: Text('Add some illustration here!'),
                    ),
                  ),
      ),
    );
  }
}
