import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import 'package:pythagon_admin/widgets/showToast.dart';

import '../../constants.dart';

class SelectTeacher extends StatefulWidget {
  final double assignmentPrice;
  final String assignmentId;
  final String subjectId;
  final List<String> alreadySelectedTeachersIds;

  const SelectTeacher(
      {Key? key,
      required this.assignmentPrice,
      required this.assignmentId,
      required this.subjectId,
      required this.alreadySelectedTeachersIds})
      : super(key: key);

  @override
  _SelectTeacherState createState() => _SelectTeacherState();
}

class _SelectTeacherState extends State<SelectTeacher> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;
  bool _isLoading = true;

  /// data
  late final List<Teacher> fetchedTeachers;
  final List<Teacher> teachersList = [];

  final List<String> selectedTeachersIds = [];
  double amount = 0;

  @override
  void initState() {
    super.initState();

    /// fetching teachers
    Teacher.getTeachers().then((value) {
      setState(() {
        fetchedTeachers = value
            .where((e) =>
                e.subjectsIds.contains(widget.subjectId) &&
                !widget.alreadySelectedTeachersIds.contains(e.id))
            .toList();
        teachersList.addAll(fetchedTeachers);
        _isLoading = false;
      });
    });

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
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Stack(
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
                            onChanged: (v) {
                              setState(() {
                                teachersList.clear();
                                teachersList.addAll(fetchedTeachers);
                                teachersList.retainWhere((e) =>
                                    e.phone
                                        .toLowerCase()
                                        .contains(v.toLowerCase()) ||
                                    e.name
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              });
                            },
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

                          return TeacherTile(
                            teacher: teachersList[index],
                            isSelected: selectedTeachersIds
                                .contains(teachersList[index].id),
                            onTap: () {
                              setState(() {
                                if (selectedTeachersIds
                                    .contains(teachersList[index].id))
                                  selectedTeachersIds
                                      .remove(teachersList[index].id);
                                else
                                  selectedTeachersIds
                                      .add(teachersList[index].id);
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
                        itemCount: teachersList.length,
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
                          child: RoundedTextField(
                            hintText: 'Enter amount',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onChanged: (v) {
                              amount = double.tryParse(v) ?? 0;
                            },
                            validator: (v) {
                              if (amount <= 0) return 'Invalid amount';

                              if (amount > widget.assignmentPrice * 0.5)
                                return 'Amount should be less than 50% of assignment price';

                              if (amount * selectedTeachersIds.length >
                                  widget.assignmentPrice * 0.6)
                                return 'Total Amount for teachers should be less than 60% of assignment price';
                            },
                          ),
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
                            onPressed: floatAssignment,
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

  void floatAssignment() {
    if (amount <= 0) {
      showToast('Invalid amount');
      return;
    }

    if (amount > widget.assignmentPrice * 0.5) {
      showToast('Amount should be less than 50% of assignment price');
      return;
    }

    if (amount * selectedTeachersIds.length > widget.assignmentPrice * 0.6) {
      showToast(
          'Total Amount for teachers should be less than 60% of assignment price');
      return;
    }

    TeachersAssignments.floatAssignments(
        selectedTeachersIds, widget.assignmentId, amount);

    showToast('Assignment Floated!');

    SideSheet.closeDrawer();
  }
}

class TeacherTile extends StatelessWidget {
  final Teacher teacher;
  final void Function() onTap;
  final bool isSelected;

  const TeacherTile(
      {Key? key,
      required this.teacher,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Provider.of<User>(context).isDarkMode
          ? kDarkModeSecondaryColor
          : kLightModeSecondaryColor,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(teacher.profilePic),
      ),
      title: Text(teacher.name),
      subtitle: Text(teacher.phone),
      trailing: RatingStar(
        size: 14,
        rating: teacher.rating != null ? teacher.rating!.avgRating : 0,
      ),
    );
  }
}
