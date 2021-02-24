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
        backgroundColor: Provider.of<User>(context).isDarkMode
            ? kDarkModeSecondaryColor
            : kLightModeSecondaryColor,
        elevation: 0.5,
        actions: [
          IconButton(
              icon: Icon(
                !Provider.of<User>(context).isDarkMode
                    ? Icons.wb_sunny_outlined
                    : Icons.wb_sunny,
                color: !Provider.of<User>(context).isDarkMode
                    ? kDarkModeBackgroundColor
                    : kLightModeBackgroundColor,
              ),
              onPressed: () {
                User().isDarkMode = !User().isDarkMode;
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
