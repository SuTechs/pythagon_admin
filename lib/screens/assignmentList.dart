import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/iconTextField.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import 'package:pythagon_admin/widgets/selectFromBottomSheet.dart';
import 'package:pythagon_admin/widgets/showRoundedBottomSheet.dart';

class AssignmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Navigator(
        onGenerateRoute: (settings) =>
            MaterialPageRoute(builder: (_) => HideShowListView()),
      ),
    );
  }
}

class HideShowListView extends StatefulWidget {
  @override
  _HideShowListViewState createState() => _HideShowListViewState();
}

class _HideShowListViewState extends State<HideShowListView> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(top: _showAppbar ? 12 : 0),
          height: _showAppbar ? kToolbarHeight - 10 : 0.0,
          duration: Duration(milliseconds: 200),
          child: Row(
            children: [
              SizedBox(width: 12),
              Expanded(
                child: RoundedTextField(hintText: 'Search'),
              ),
              SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                child: FlutterLogo(),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StudentList()));
                },
              ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// assignments list

        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              controller: _scrollViewController,
              itemBuilder: (context, index) {
                return AssignmentListTile(
                  isSelected: index == _selectedIndex,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
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
              itemCount: 200,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
}

class AssignmentListTile extends StatelessWidget {
  final bool isSelected;
  final void Function() onTap;

  const AssignmentListTile(
      {Key? key, this.isSelected = false, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Provider.of<User>(context).isDarkMode
          ? kDarkModeSecondaryColor
          : kLightModeSecondaryColor,
      leading: CircleAvatar(child: FlutterLogo()),
      title: Text('Long Long assignment'),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 11,
            ),

            /// time
            Text(
              ' Feb 19 10AM',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
      //trailing: Icon(Icons.lightbulb_outline),
    );
  }
}

/// students list or select student

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 12),
              Expanded(
                child: RoundedTextField(
                  hintText: 'Search student...',
                  autoFocus: true,
                ),
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
                    title: Text('New Student'),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => NewStudent()));
                    },
                  );

                /// student
                return ListTile(
                  leading: CircleAvatar(child: FlutterLogo()),
                  title: Text('Name'),
                  subtitle: Text('+91 7556325559'),
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
              itemCount: 20,
            ),
          ),
        ),
      ],
    );
  }
}

/// new student

class NewStudent extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _course = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => Navigator.pop(context),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// profile pic
        Center(
          child: CircleAvatar(
            child: FlutterLogo(),
            radius: 64,
          ),
        ),

        SizedBox(height: 32),

        /// name
        IconTextField(
          labelText: 'Name',
          icon: Icons.person,
          controller: _name,
        ),

        /// phone
        IconTextField(
          labelText: 'Phone',
          icon: Icons.phone,
          controller: _phone,
        ),

        /// course
        IconTextField(
          labelText: 'Course',
          icon: Icons.book,
          controller: _course,
          readOnly: true,
          onTap: () {
            showRoundedBottomSheet(
              context: context,
              child: SelectFromList<String>(
                items: [
                  ListItem('CSE', 'CSE'),
                ],
                onNewItemSelect: (newItem) {
                  _course.text = newItem;
                },
                onSelect: (value) {
                  _course.text = value;
                },
              ),
            );
          },
        ),

        /// college
        IconTextField(
          labelText: 'College',
          icon: Icons.school,
          controller: _college,
          readOnly: true,
          onTap: () {
            showRoundedBottomSheet(
              context: context,
              child: SelectFromList<String>(
                items: [
                  ListItem('Hello', 'Hello'),
                  ListItem('Hello Noob', 'Hello Noob'),
                ],
                onNewItemSelect: (newItem) {
                  _college.text = newItem;
                },
                onSelect: (value) {
                  _college.text = value;
                },
              ),
            );
          },
        ),

        /// date of birth
        IconTextField(
          labelText: 'Date of birth',
          icon: Icons.date_range,
          controller: _dob,
          readOnly: true,
          onTap: () {},
        ),

        /// gender
        IconTextField(
          labelText: 'Gender',
          icon: Icons.wc,
          controller: _gender,
          readOnly: true,
          onTap: () {
            showRoundedBottomSheet(
              context: context,
              child: SelectFromList<String>(
                items: [
                  ListItem('Male', 'Male'),
                  ListItem('Female', 'Female'),
                  ListItem('Other', 'Other'),
                ],
                onNewItemSelect: (newItem) {
                  _gender.text = newItem;
                },
                onSelect: (value) {
                  _gender.text = value;
                },
              ),
            );
          },
        ),

        /// email
        IconTextField(
          labelText: 'Email',
          icon: Icons.email,
          controller: _email,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
