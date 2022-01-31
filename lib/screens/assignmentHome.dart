import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/notificationBloc.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/NotificationManager.dart';
import 'package:pythagon_admin/data/utils/Utils.dart';
import 'package:pythagon_admin/data/utils/modal/collectionRef.dart';

import '/constants.dart';
import '/data/bloc/currentAssignmentBloc.dart';
import '/data/utils/modal/user.dart';
import '/screens/assignmentDetails/selectTeacher.dart';
import '/widgets/homeLayout.dart';
import 'assignmentDetails/selectSubject.dart';
import 'assignmentDetails.dart';
import 'assignmentList.dart';

class AssignmentHome extends StatefulWidget {
  @override
  State<AssignmentHome> createState() => _AssignmentHomeState();
}

class _AssignmentHomeState extends State<AssignmentHome> {
  @override
  void initState() {
    super.initState();
    NotificationManager.init();

    /// handling the notification in the list

    CollectionRef.notifications
        .where('to', whereIn: [UserData.authData!.uid, 'admin'])
        .snapshots()
        .listen((snapshot) {
          NotificationBloc().onDataUpdate(snapshot.docs);
        });
  }

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
          /// Notifications
          Stack(
            children: [
              Center(
                child: IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: !Provider.of<UserData>(context).isDarkMode
                          ? kDarkModeBackgroundColor
                          : kLightModeBackgroundColor,
                    ),
                    onPressed: () {
                      SideSheet().openDrawer(child: NotificationScreen());
                    }),
              ),

              // new notification count
              Visibility(
                visible: Provider.of<NotificationBloc>(context)
                    .notifications
                    .where((p0) => !p0.isRead)
                    .isNotEmpty,
                child: Positioned(
                  top: 11,
                  left: 3,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${Provider.of<NotificationBloc>(context).notifications.where((p0) => !p0.isRead).length}',
                      style: TextStyle(
                        color: kLightModeBackgroundColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

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

/// Notification screen

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = Provider.of<NotificationBloc>(context).notifications;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 12),
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  SideSheet.closeIfOpen();
                },
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
        Divider(),

        /// notifications

        Expanded(
          child: notifications.isEmpty
              ? Center(
                  child: Text('Nothing here yet!'),
                )
              : ListView.builder(
                  itemCount: notifications.length + 1,
                  itemBuilder: (_, index) {
                    if (index == notifications.length)
                      return SizedBox(height: 16);
                    return NotificationTile(
                      notificationData: notifications[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class NotificationTile extends StatefulWidget {
  final NotificationData notificationData;

  const NotificationTile({Key? key, required this.notificationData})
      : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: !widget.notificationData.isRead
          ? Provider.of<UserData>(context).isDarkMode
              ? kDarkModeSecondaryColor
              : kLightModeSecondaryColor
          : null,
      child: ListTile(
        leading: IconButton(
          onPressed: widget.notificationData.isRead
              ? null
              : () {
                  setState(() {
                    widget.notificationData.isRead = true;
                    widget.notificationData.markAsRead();
                  });
                },
          icon: Icon(
            !widget.notificationData.isRead
                ? Icons.notifications_active_outlined
                : Icons.notifications_outlined,
          ),
          tooltip: !widget.notificationData.isRead ? 'Mark as read' : null,
        ),
        title: Text('New Assignment!'),
        subtitle: Text('2 tutors has accepted the assignment'),
        trailing: Text(
          getFormattedTimeWithAt(DateTime.now()),
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        enabled: !widget.notificationData.isRead,
      ),
    );
  }
}
