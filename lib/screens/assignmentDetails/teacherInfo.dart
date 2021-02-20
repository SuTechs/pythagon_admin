import 'package:flutter/material.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';

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
            Text('  Subjects: Physics Chemistry Math'),
            Text('  Can Add More details here!'),
          ],
        ),

        /// assignments

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Assignments',
            style:
                Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 12),
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
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Color(0xffdbdbdb))),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
                        child: Text("Reject"),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
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
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Color(0xffdbdbdb))),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
                        child: Text("Reject"),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
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
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Color(0xffdbdbdb))),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
                        child: Text("Reject"),
                        onPressed: () {},
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
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
