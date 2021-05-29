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
import 'package:pythagon_admin/widgets/showToast.dart';
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
          trailing:
              RatingStar(rating: teachersAssignments.teacher.rating.avgRating),
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
          rating: data.status == TeacherAssignmentStatus.Rated
              ? data.rating!.avgRating
              : null,
        ),
      ),
      children: [
        if (hasFile())
          SizedBox(
            height: 160,
            child: AttachmentList(
              onFileDelete: (url) async {
                data.assignmentFiles.remove(url);
                await TeachersAssignments.updateFiles(
                    data.assignmentFiles, data.id);
              },
              onFilesUpload: (urls) async {
                data.assignmentFiles.addAll(urls);

                TeachersAssignments.updateFiles(data.assignmentFiles, data.id);
              },
              files: data.assignmentFiles,
              assignmentId: data.assignmentId,
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
      child: SelectTeacherAssignmentStatus(data: data),
    );
  }
}

class SelectTeacherAssignmentStatus extends StatelessWidget {
  final TeachersAssignments data;

  const SelectTeacherAssignmentStatus({Key? key, required this.data})
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
                      context: context, child: RateTeacher(data: data));
                } else {
                  /// updating status
                  TeachersAssignments.changeStatus(
                      TeacherAssignmentStatus.values[index], data.id,
                      teacherId: data.teacher.id,
                      assignmentId: data.assignmentId,
                      amount: data.amount);
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
                color: Provider.of<UserData>(context).isDarkMode
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

class RateTeacher extends StatefulWidget {
  final TeachersAssignments data;

  const RateTeacher({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  _RateTeacherState createState() => _RateTeacherState();
}

class _RateTeacherState extends State<RateTeacher> {
  double performance = 0;
  double accuracy = 0;
  double availability = 0;

  @override
  void initState() {
    super.initState();

    if (widget.data.rating != null) {
      performance = widget.data.rating!.performance;
      accuracy = widget.data.rating!.accuracy;
      availability = widget.data.rating!.availability;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListView(
        children: [
          SizedBox(height: 8),
          TeacherRatingBar(
            ratingHint: 'Performance',
            initialRating: widget.data.rating != null
                ? widget.data.rating!.performance
                : 0,
            onRatingChange: (v) {
              performance = v;
            },
          ),
          TeacherRatingBar(
            ratingHint: 'Accuracy',
            initialRating:
                widget.data.rating != null ? widget.data.rating!.accuracy : 0,
            onRatingChange: (v) {
              accuracy = v;
            },
          ),
          TeacherRatingBar(
            ratingHint: 'Availability',
            initialRating: widget.data.rating != null
                ? widget.data.rating!.availability
                : 0,
            onRatingChange: (v) {
              availability = v;
            },
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              TeachersAssignments.rate(
                TeacherRating(
                    performance: performance,
                    accuracy: accuracy,
                    availability: availability),
                widget.data.teacher.id,
                widget.data.id,
                widget.data.teacher.rating,
                widget.data.teacher.totalRating,
              ).then((value) {
                showToast('Rating added!');
              });
              SideSheet.closeIfOpen();
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
  final void Function(double) onRatingChange;
  final double initialRating;

  const TeacherRatingBar(
      {Key? key,
      required this.ratingHint,
      required this.onRatingChange,
      required this.initialRating})
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
          onRatingUpdate: onRatingChange,
          initialRating: initialRating,
          maxRating: 5,
        ),
        SizedBox(height: 4),
        Text('$ratingHint'),
        SizedBox(height: 4),
      ],
    );
  }
}
