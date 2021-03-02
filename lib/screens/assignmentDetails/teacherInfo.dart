import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/assignmentInfoComponents.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/widgets/showRoundedBottomSheet.dart';
import 'package:pythagon_admin/widgets/teacherAssignmentStatusIcon.dart';
import '../../constants.dart';

class TeacherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /// teacher info
        ExpansionTile(
          leading: CircleAvatar(child: FlutterLogo()),
          title: Text('Prince Kumar'),
          subtitle: Text('+91 7667323338'),
          trailing: RatingStar(rating: 3.5),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 4,
                children: [
                  for (int i = 0; i < 3; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Subject',
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
            'Assignments',
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10),
          ),
        ),

        for (TeacherAssignmentStatus v in TeacherAssignmentStatus.values)
          TeacherAssignmentDetailsListTile(status: v),
      ],
    );
  }
}

class TeacherAssignmentDetailsListTile extends StatelessWidget {
  final bool isInitiallyOpened;
  final TeacherAssignmentStatus status;
  const TeacherAssignmentDetailsListTile(
      {Key? key, this.isInitiallyOpened = false, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(child: FlutterLogo()),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uchit Chakma'),
          SizedBox(width: 4),
          Text(
            'Feb 28 7:45 PM',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
      subtitle: Text('Rs 500/-'),
      trailing: InkWell(
        onTap: () {
          onStatusClick(context);
        },
        child: TeacherAssignmentStatusIcon(
          status: status,
          rating: status == TeacherAssignmentStatus.Rated ? 3.6 : null,
        ),
      ),
      children: [
        if (hasFile())
          SizedBox(
            height: 150,
            child: AttachmentList(
              updateFiles: ({required bool isDelete, required String url}) {},
              files: [
                'https://suMit.com/su8298w/su.pdf',
                'https://suMit.com/su8298w/su.doc',
                'https://suMit.com/su8298w/su.docx',
                'https://suMit.com/su8298w/su.docx',
                'https://suMit.com/su8298w/su.docx',
                'https://suMit.com/su8298w/su.docx',
              ],
            ),
          ),
      ],
    );
  }

  bool hasFile() {
    switch (status) {
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
      child: SelectTeacherAssignmentStatus(),
    );
  }
}

class SelectTeacherAssignmentStatus extends StatelessWidget {
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
                } else
                  Navigator.pop(context);
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
      child: Column(
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
