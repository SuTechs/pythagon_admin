import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/Utils.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/assignmentInfoComponents.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';
import 'package:pythagon_admin/widgets/showRoundedBottomSheet.dart';
import 'package:pythagon_admin/widgets/teacherAssignmentStatusIcon.dart';

import '../../constants.dart';

class TeacherInfo extends StatelessWidget {
  final TeachersAssignments teachersAssignments;
  final Assignment currentAssignment;

  const TeacherInfo(
      {Key? key,
      required this.teachersAssignments,
      required this.currentAssignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /// teacher info
        ExpansionTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage(teachersAssignments.teacher.profilePic),
          ),
          title: Text('${teachersAssignments.teacher.name}'),
          subtitle: Text('${teachersAssignments.teacher.phone}'),
          trailing: RatingStar(
              rating: teachersAssignments.teacher.rating != null
                  ? teachersAssignments.teacher.rating!.avgRating
                  : 0),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 4,
                children: [
                  for (String s in teachersAssignments.teacher.subjectsIds)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                          backgroundImage: NetworkImage(Subject.subjects
                              .firstWhere((element) => element.id == s)
                              .image),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${Subject.subjects.firstWhere((element) => element.id == s).name}',
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),

        /// assignments

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Current Assignment',
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10),
          ),
        ),

        // for (TeacherAssignmentStatus v in TeacherAssignmentStatus.values)
        //   TeacherAssignmentDetailsListTile(status: v),

        TeacherAssignmentDetailsListTile(
          isInitiallyOpened: true,
          data: teachersAssignments,
          assignment: currentAssignment,
        ),
      ],
    );
  }
}

class TeacherAssignmentDetailsListTile extends StatelessWidget {
  final bool isInitiallyOpened;
  final TeachersAssignments data;
  final Assignment assignment;
  const TeacherAssignmentDetailsListTile(
      {Key? key,
      this.isInitiallyOpened = false,
      required this.data,
      required this.assignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(child: FlutterLogo()),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${assignment.name}'),
          SizedBox(width: 4),
          Text(
            '${getFormattedTime(assignment.time!)}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
      subtitle: Text('Rs ${data.amount}'),
      trailing: InkWell(
        onTap: () {
          onStatusClick(context);
        },
        child: TeacherAssignmentStatusIcon(
          status: data.status,
          rating: data.status == TeacherAssignmentStatus.Rated ? 3.6 : null,
        ),
      ),
      children: [
        if (hasFile())
          SizedBox(
            height: 150,
            child: AttachmentList(
              updateFiles: ({required bool isDelete, required String url}) {
                if (isDelete)
                  data.assignmentFiles.remove(url);
                else
                  data.assignmentFiles.add(url);

                TeachersAssignments.updateFiles(data.assignmentFiles, data.id);
              },
              files: data.assignmentFiles,
            ),
          ),
      ],
    );
  }

  bool hasFile() {
    switch (data.status) {
      case TeacherAssignmentStatus.Completed:
      case TeacherAssignmentStatus.Rejected:
      case TeacherAssignmentStatus.Closed:
      case TeacherAssignmentStatus.Rated:
        return true;

      default:
        return false;
    }
  }

  void onStatusClick(BuildContext context) {
    showRoundedBottomSheet(
      context: context,
      child: SelectTeacherAssignmentStatus(
          teacherAssignmentId: data.id, teacherId: data.teacher.id),
    );
  }
}

class SelectTeacherAssignmentStatus extends StatelessWidget {
  final String teacherAssignmentId;
  final String teacherId;

  const SelectTeacherAssignmentStatus(
      {Key? key, required this.teacherAssignmentId, required this.teacherId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Scrollbar(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: TeacherAssignmentStatusIcon(
                size: 16,
                status: TeacherAssignmentStatus.values[index],
              ),
              title: Text(
                  '${kTeacherAssignmentStatusEnumMap[TeacherAssignmentStatus.values[index]]}'),
              onTap: () {
                if (TeacherAssignmentStatus.values[index] ==
                    TeacherAssignmentStatus.Rated) {
                  Navigator.pop(context);
                  showRoundedBottomSheet(
                      context: context, child: RateTeacher());
                } else {
                  /// updating status
                  TeachersAssignments.changeStatus(
                      TeacherAssignmentStatus.values[index],
                      teacherAssignmentId);
                  SideSheet.closeIfOpen();
                  // Navigator.pop(context);
                }
              },
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Container(
                height: 0.1,
                color: Provider.of<User>(context).isDarkMode
                    ? kDarkModeSecondaryColor
                    : kLightModeSecondaryColor,
              ),
            );
          },
          itemCount: TeacherAssignmentStatus.values.length,
        ),
      ),
    );
  }
}

class RateTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListView(
        children: [
          SizedBox(height: 8),
          TeacherRatingBar(
            ratingHint: 'OnTime',
          ),
          TeacherRatingBar(
            ratingHint: 'Writing',
          ),
          TeacherRatingBar(
            ratingHint: 'Accuracy',
          ),
          TeacherRatingBar(
            ratingHint: 'Performance',
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class TeacherRatingBar extends StatelessWidget {
  final String ratingHint;

  const TeacherRatingBar({Key? key, required this.ratingHint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.deepOrangeAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              default:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
            }
          },
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(height: 4),
        Text('$ratingHint'),
        SizedBox(height: 4),
      ],
    );
  }
}
