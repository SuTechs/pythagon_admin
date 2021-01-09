import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';

class AssignmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Center(child: Text('hello')),
      ),
      body: AssignmentDetailsLayout(),
    );
  }
}
