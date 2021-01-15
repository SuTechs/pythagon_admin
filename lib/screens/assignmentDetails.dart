import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/assignmentInfoComponents.dart';

class AssignmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Center(child: Text('hello')),
      ),
      body: AssignmentDetailsLayout(
        details: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: AssignmentInfo(),
        ),
      ),
    );
  }
}

class AssignmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentInfoLayout(
      studentInfo: StudentInfoRow(),
      nameAndSubject: AssignmentNameAndSubject(),
      timeAndType: AssignmentTimeAndType(),
      description: DescriptionTextField(),
      attachments: AttachmentList(),
    );
  }
}
