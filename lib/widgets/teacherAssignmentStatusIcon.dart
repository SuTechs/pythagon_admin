import 'package:flutter/material.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';

class TeacherAssignmentStatusIcon extends StatelessWidget {
  final TeacherAssignmentStatus status;
  final double? rating;
  final double? size;

  const TeacherAssignmentStatusIcon(
      {Key? key, required this.status, this.rating, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (status) {
      case TeacherAssignmentStatus.Sent:
        return Icon(
          Icons.timer,
          color: Colors.grey,
          size: size,
        );

      case TeacherAssignmentStatus.Interested:
        return Icon(
          Icons.done,
          color: Colors.grey,
          size: size,
        );

      case TeacherAssignmentStatus.NotInterested:
        return Icon(
          Icons.clear,
          color: Colors.grey,
          size: size,
        );

      case TeacherAssignmentStatus.NotAssigned:
        return Icon(
          Icons.clear,
          color: Colors.blue,
          size: size,
        );

      case TeacherAssignmentStatus.Assigned:
        return Icon(
          Icons.done_all,
          size: size,
        );

      case TeacherAssignmentStatus.Completed:
        return Icon(
          Icons.done_all,
          color: Colors.blue,
          size: size,
        );

      case TeacherAssignmentStatus.Rejected:
        return Icon(
          Icons.clear,
          color: Colors.red,
          size: size,
        );

      case TeacherAssignmentStatus.Closed:
        return Icon(
          Icons.done_all,
          color: Colors.green,
          size: size,
        );

      case TeacherAssignmentStatus.Rated:
        return rating == null
            ? Icon(
                Icons.star_border,
                color: Colors.yellow,
                size: size,
              )
            : RatingStar(
                rating: rating ?? 0,
                size: size != null ? size! - 4 : 16,
              );

      default:
        return Icon(
          Icons.error,
          size: size,
        );
    }
  }
}
