import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';

class TeacherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Text('  Subjects: Physics Chemistry Math'),
            Text('  Can Add More details here!'),
          ],
        ),

        /// assignments

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Assignments',
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 12),
          ),
        ),

        /// pending
        ExpansionTile(
          initiallyExpanded: true,
          leading: CircleAvatar(child: FlutterLogo()),
          title: Text('Assignment name'),
          trailing: Icon(Icons.timer),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  FlutterLogo(size: 60),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        color: Colors.red,
                        child: Text("Reject"),
                        borderSide: BorderSide(color: Color(0xffdbdbdb)),
                        shape: StadiumBorder(),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        color: Colors.green,
                        shape: StadiumBorder(),
                        onPressed: () {},
                        child: Text(
                          "Allow",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        ///
        ExpansionTile(
          leading: CircleAvatar(child: FlutterLogo()),
          title: Text('Assignment name'),
          trailing: SizedBox(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: FlutterLogo(
                size: 120,
                style: FlutterLogoStyle.stacked,
              ),
            ),
          ],
        ),

        /// pending
        ExpansionTile(
          leading: CircleAvatar(child: FlutterLogo()),
          title: Text('Assignment name'),
          trailing: Icon(Icons.timer),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  FlutterLogo(size: 60),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        color: Colors.red,
                        child: Text("Reject"),
                        borderSide: BorderSide(color: Color(0xffdbdbdb)),
                        shape: StadiumBorder(),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        color: Colors.green,
                        shape: StadiumBorder(),
                        onPressed: () {},
                        child: Text(
                          "Allow",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        /// pending
        ExpansionTile(
          leading: CircleAvatar(child: FlutterLogo()),
          title: Text('Assignment name'),
          trailing: Icon(Icons.timer),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  FlutterLogo(size: 60),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlineButton(
                        color: Colors.red,
                        child: Text("Reject"),
                        borderSide: BorderSide(color: Color(0xffdbdbdb)),
                        shape: StadiumBorder(),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        color: Colors.green,
                        shape: StadiumBorder(),
                        onPressed: () {},
                        child: Text(
                          "Allow",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
