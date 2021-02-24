import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import '../../constants.dart';

class SelectSubject extends StatefulWidget {
  final List<Subject> fetchedSubjects;
  final void Function(Subject) onSubjectChange;

  const SelectSubject(
      {Key? key, required this.fetchedSubjects, required this.onSubjectChange})
      : super(key: key);

  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  final List<Subject> subjects = [];

  @override
  void initState() {
    subjects.addAll(widget.fetchedSubjects);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 12),
              Expanded(
                child: RoundedTextField(
                  hintText: 'Search subject...',
                  autoFocus: true,
                  onChanged: (value) {
                    setState(() {
                      subjects.clear();
                      subjects.addAll(widget.fetchedSubjects);
                      subjects.retainWhere((element) => element.name
                          .toLowerCase()
                          .contains(value.trim().toLowerCase()));
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () => SideSheet.closeDrawer(),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// subjects list
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (context, index) {
                // /// new subject
                // if (index == 0)
                //   return ListTile(
                //     leading: CircleAvatar(child: Icon(Icons.add)),
                //     title: Text('New Subject'),
                //     onTap: () {
                //       print('add new subject');
                //     },
                //   );

                return SubjectTile(
                  onSubjectChange: (s) {
                    widget.onSubjectChange(s);
                    SideSheet.closeDrawer();
                  },
                  subject: subjects[index],
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
              itemCount: subjects.length,
            ),
          ),
        ),
      ],
    );
  }
}

class SubjectTile extends StatelessWidget {
  final void Function(Subject) onSubjectChange;
  final Subject subject;

  const SubjectTile(
      {Key? key, required this.onSubjectChange, required this.subject})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSubjectChange(subject);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(subject.image),
      ),
      title: Text('${subject.name}'),
    );
  }
}
