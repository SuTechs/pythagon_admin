import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';

class AssignmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return AssignmentListTile();
          },
        ),
      ),
    );
  }
}

class AssignmentListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          isThreeLine: true,
          leading: CircleAvatar(backgroundColor: Colors.white),
          title: Text('Entropy'),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Su Mit'),
              SizedBox(height: 8),
              Container(height: 0.3, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
