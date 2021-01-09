import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/homeLayout.dart';
import 'assignmentDetails.dart';
import 'assignmentList.dart';

class AssignmentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: HomeLayout(
        lessWidthChild: AssignmentList(),
        moreWidthChild: AssignmentDetails(),
      ),
    );
  }
}
