import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import '../../constants.dart';

class SelectTeacher extends StatefulWidget {
  @override
  _SelectTeacherState createState() => _SelectTeacherState();
}

class _SelectTeacherState extends State<SelectTeacher> {
  late ScrollController _scrollViewController;

  bool _showAppbar = true;

  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
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
    return Stack(
      children: [
        Column(
          children: [
            /// search bar
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
                    onPressed: () {
                      SideSheet.closeDrawer();
                    },
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),

            /// teachers list
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  controller: _scrollViewController,
                  itemBuilder: (context, index) {
                    // /// new student
                    // if (index == 0)
                    //   return ListTile(
                    //     leading: CircleAvatar(child: Icon(Icons.add)),
                    //     title: Text('New Teacher'),
                    //     onTap: () {
                    //       print('add new teacher');
                    //     },
                    //   );

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
        ),

        /// action button

        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: _showAppbar ? kToolbarHeight - 10 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Opacity(
              opacity: _showAppbar ? 1 : 0,
              child: Row(
                children: [
                  SizedBox(width: 12),

                  /// teacher amount text field
                  Expanded(
                    child: RoundedTextField(hintText: 'Enter amount'),
                  ),
                  SizedBox(width: 12),

                  /// Float button
                  SizedBox(
                    width: 36 * 2,
                    height: 36,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                      child: Text('Float'),
                      onPressed: () {
                        SideSheet.closeDrawer();
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
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
