import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/data/bloc/currentAssignmentBloc.dart';
import '/data/utils/modal/user.dart';
import '/screens/assignmentDetails/selectTeacher.dart';
import '/widgets/homeLayout.dart';
import 'assignmentDetails/selectSubject.dart';
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
          /// Teachers
          if (UserData.isGod)
            TextButton(
              child: Text(
                'Teachers',
                style: TextStyle(
                  color: !Provider.of<UserData>(context).isDarkMode
                      ? kDarkModeBackgroundColor
                      : kLightModeBackgroundColor,
                ),
              ),
              onPressed: () {
                SideSheet().openDrawer(child: TeachersList());
              },
            ),

          /// Subjects
          if (UserData.isGod)
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 4),
              child: TextButton(
                child: Text(
                  'Subjects',
                  style: TextStyle(
                    color: !Provider.of<UserData>(context).isDarkMode
                        ? kDarkModeBackgroundColor
                        : kLightModeBackgroundColor,
                  ),
                ),
                onPressed: () {
                  SideSheet().openDrawer(child: SubjectAddEdit());
                },
              ),
            ),

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
                  UserData().isLoggedIn = false;

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (_) => AdminLogin()),
                  //     (route) => false);
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
        moreWidthChild: AssignmentDetails(),
      ),
    );
  }
}
