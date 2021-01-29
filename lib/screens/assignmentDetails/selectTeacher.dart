import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import '../../constants.dart';

class SelectTeacher<T> extends StatelessWidget {
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
                  hintText: 'Search teacher...',
                  autoFocus: true,
                ),
              ),
              SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (context, index) {
                /// new student
                if (index == 0)
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.add)),
                    title: Text('New Teacher'),
                    onTap: () {
                      print('add new teacher');
                    },
                  );

                return TeacherTile();
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
              itemCount: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class TeacherTile extends StatefulWidget {
  @override
  _TeacherTileState createState() => _TeacherTileState();
}

class _TeacherTileState extends State<TeacherTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      selected: isSelected,
      selectedTileColor: Provider.of<User>(context).isDarkMode
          ? kDarkModeSecondaryColor
          : kLightModeSecondaryColor,
      leading: CircleAvatar(child: FlutterLogo()),
      title: Text('Teacher 1'),
      subtitle: Text('Su'),
    );
  }
}
