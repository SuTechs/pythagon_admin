import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/constants.dart';
import 'package:pythagon_admin/data/bloc/assignmentListBloc.dart';
import 'package:pythagon_admin/data/bloc/currentAssignmentBloc.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/Utils.dart';
import 'package:pythagon_admin/data/utils/modal/collectionRef.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/iconTextField.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import 'package:pythagon_admin/widgets/selectFromBottomSheet.dart';
import 'package:pythagon_admin/widgets/showRoundedBottomSheet.dart';

import 'assignmentDetails.dart';

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

/// assignments reactive list

class HideShowListView extends StatefulWidget {
  @override
  _HideShowListViewState createState() => _HideShowListViewState();
}

class _HideShowListViewState extends State<HideShowListView> {
  late ScrollController _scrollViewController = ScrollController();
  bool _showAppbar = true;
  bool _isScrollingDown = false;
  bool _isLoading = true;

  late final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _streamSubscription;

  @override
  void initState() {
    super.initState();

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

    /// assignment list stream
    /// for now all assignment is visible to only Pythagon
    /// and rest can view only their assignments
    if (UserData.isGod)
      snapshots = CollectionRef.assignments
          .orderBy('updatedAt', descending: true)
          .snapshots();
    else
      snapshots = CollectionRef.assignments
          .where('createdBy', isEqualTo: UserData.authData!.email)
          .orderBy('updatedAt', descending: true)
          .snapshots();

    _streamSubscription = snapshots.listen((event) {
      // print('stream data');

      AssignmentListBloc().onDataUpdate(event);
      if (_isLoading)
        setState(() {
          _isLoading = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              AnimatedContainer(
                margin: EdgeInsets.only(top: _showAppbar ? 12 : 0),
                height: _showAppbar ? kToolbarHeight - 10 : 0.0,
                duration: Duration(milliseconds: 200),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _showAppbar ? 1 : 0,
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      FloatingActionButton(
                        heroTag: 'Hello Noob 111',
                        backgroundColor: AssignmentListBloc().isSortByTime
                            ? null
                            : Colors.grey,
                        mini: true,
                        child: Icon(Icons.timer),
                        onPressed: () {
                          /// handle time sorting
                          AssignmentListBloc().toggleSortByTime();
                        },
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: RoundedTextField(
                          hintText: 'Search',
                          onChanged: (v) {
                            AssignmentListBloc().onSearch(v.toLowerCase());
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      FloatingActionButton(
                        heroTag: 'Hello Noob 311',
                        mini: true,
                        child: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => StudentList()));
                        },
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),

              /// assignments list

              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollViewController,
                  itemBuilder: (context, index) {
                    return AssignmentListTile(
                      assignment: Provider.of<AssignmentListBloc>(context)
                          .assignments[index],
                      isSelected: Provider.of<CurrentAssignmentBloc>(context)
                                  .assignment !=
                              null &&
                          Provider.of<AssignmentListBloc>(context)
                                  .assignments[index]
                                  .id ==
                              CurrentAssignmentBloc().assignment!.id,
                      onTap: () {
                        CurrentAssignmentBloc().changeAssignment(
                            Provider.of<AssignmentListBloc>(context,
                                    listen: false)
                                .assignments[index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Container(
                        height: 0.1,
                        color: Provider.of<UserData>(context).isDarkMode
                            ? kDarkModeSecondaryColor
                            : kLightModeSecondaryColor,
                      ),
                    );
                  },
                  itemCount: Provider.of<AssignmentListBloc>(context)
                      .assignments
                      .length,
                ),
              ),
            ],
          );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _scrollViewController.dispose();
    super.dispose();
  }
}

class AssignmentListTile extends StatelessWidget {
  final Assignment assignment;
  final bool isSelected;
  final void Function() onTap;

  const AssignmentListTile(
      {Key? key,
      this.isSelected = false,
      required this.onTap,
      required this.assignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Provider.of<UserData>(context).isDarkMode
          ? kDarkModeSecondaryColor
          : kLightModeSecondaryColor,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(assignment.subject!.image),
      ),
      title: Text(assignment.name ?? 'Assignment Name'),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 11,
            ),

            /// time
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                ' ${assignment.time != null ? getFormattedTime(assignment.time!) : 'Time'}',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
      trailing: Text(
        assignment.id,
        style: TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }
}

/// students list or select student

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
        future: Student.getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error = ${snapshot.error}'));
          }

          if (snapshot.hasData)
            return FetchedStudentsList(fetchedStudents: snapshot.data ?? []);

          return Center(child: CircularProgressIndicator());
        });
  }
}

class FetchedStudentsList extends StatefulWidget {
  final List<Student> fetchedStudents;

  const FetchedStudentsList({Key? key, required this.fetchedStudents})
      : super(key: key);

  @override
  _FetchedStudentsListState createState() => _FetchedStudentsListState();
}

class _FetchedStudentsListState extends State<FetchedStudentsList> {
  final List<Student> studentsList = [];

  @override
  void initState() {
    studentsList.addAll(widget.fetchedStudents);
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
                  onChanged: (value) {
                    setState(() {
                      studentsList.clear();
                      studentsList.addAll(widget.fetchedStudents);
                      studentsList.retainWhere((element) =>
                          element.name
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()) ||
                          element.phone
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()));
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// students list
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NewOrEditStudent()));
                    },
                  );

                if (studentsList.length < 1)
                  return Center(child: Text('No Student!'));

                /// student
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(studentsList[index - 1].profilePic),
                  ),
                  title: Text('${studentsList[index - 1].name}'),
                  subtitle: Text('${studentsList[index - 1].phone}'),
                  onTap: () {
                    CurrentAssignmentBloc()
                        .newAssignment(studentsList[index - 1]);
                    Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Container(
                    height: 0.1,
                    color: Provider.of<UserData>(context).isDarkMode
                        ? kDarkModeSecondaryColor
                        : kLightModeSecondaryColor,
                  ),
                );
              },
              itemCount: studentsList.length < 1 ? 2 : studentsList.length + 1,
            ),
          ),
        ),
      ],
    );
  }
}

/// new student

class NewOrEditStudent extends StatefulWidget {
  final Student? student;
  final bool isEdit;

  const NewOrEditStudent({Key? key, this.student, this.isEdit = false})
      : super(key: key);

  @override
  _NewOrEditStudentState createState() => _NewOrEditStudentState();
}

class _NewOrEditStudentState extends State<NewOrEditStudent> {
  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _name.text = widget.student!.name;
      _phone.text = widget.student!.phone;
      _email.text = widget.student!.email;
      _college.text = widget.student!.college.collegeName;
      _course.text = widget.student!.course.courseName;
      _gender.text = widget.student!.gender;
      _dob.text = widget.student!.dateOfBirth;
    }
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _course = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SizedBox(width: 12),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    if (widget.isEdit)
                      SideSheet.closeDrawer();
                    else
                      Navigator.pop(context);
                  },
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createUpdateStudent();
                      if (widget.isEdit)
                        SideSheet.closeDrawer();
                      else
                        Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(width: 12),
              ],
            ),
          ),

          /// profile pic
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.student != null
                    ? widget.student!.profilePic
                    : kBlankProfilePicUrl,
              ),
              radius: 64,
            ),
          ),

          SizedBox(height: 32),

          /// name
          IconTextField(
            labelText: 'Name',
            icon: Icons.person,
            controller: _name,
            isRequired: true,
          ),

          /// phone
          IconTextField(
            readOnly: widget.isEdit,
            labelText: 'Phone',
            icon: Icons.phone,
            controller: _phone,
            isRequired: true,
          ),

          /// course
          IconTextField(
            labelText: 'Course',
            icon: Icons.book,
            controller: _course,
            readOnly: true,
            isRequired: true,
            onTap: () {
              showRoundedBottomSheet(
                context: context,
                child: FutureBuilder<List<Course>>(
                    future: Course.getCourses(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error = ${snapshot.error}'));
                      }

                      if (snapshot.hasData)
                        return SelectFromList<Course>(
                          items: snapshot.data!
                              .map((e) => ListItem<Course>(e, e.courseName))
                              .toList(),
                          onNewItemSelect: (newItem) {
                            Course(courseId: newItem, courseName: newItem)
                                .addCourse();
                            _course.text = newItem;
                          },
                          onSelect: (value) {
                            _course.text = value.courseName;
                          },
                        );

                      return Center(child: CircularProgressIndicator());
                    }),
              );
            },
          ),

          /// college
          IconTextField(
            labelText: 'College',
            icon: Icons.school,
            controller: _college,
            readOnly: true,
            isRequired: true,
            onTap: () {
              showRoundedBottomSheet(
                  context: context,
                  child: FutureBuilder<List<College>>(
                      future: College.getColleges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error = ${snapshot.error}'));
                        }

                        if (snapshot.hasData)
                          return SelectFromList<College>(
                            items: snapshot.data!
                                .map((e) => ListItem<College>(e, e.collegeName))
                                .toList(),
                            onNewItemSelect: (newItem) {
                              College(collegeId: newItem, collegeName: newItem)
                                  .addCollege();
                              _college.text = newItem;
                            },
                            onSelect: (value) {
                              _college.text = value.collegeName;
                            },
                          );

                        return Center(child: CircularProgressIndicator());
                      }));
            },
          ),

          /// date of birth
          IconTextField(
            labelText: 'Date of birth',
            icon: Icons.date_range,
            controller: _dob,
            readOnly: true,
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                useRootNavigator: false,
                context: context,
                initialDate: DateTime(2000),
                lastDate: DateTime.now(),
                firstDate: DateTime(1980),
              );
              if (pickedDate != null)
                _dob.text = pickedDate.toString().substring(0, 10);
            },
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
      ),
    );
  }

  void createUpdateStudent() {
    final student = Student(
      studentId: _phone.text.trim(),
      name: _name.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      dateOfBirth: _dob.text.trim(),
      gender: _gender.text.trim(),
      profilePic: kBlankProfilePicUrl,
      college: College(
          collegeName: _college.text.trim(), collegeId: _college.text.trim()),
      course: Course(
          courseName: _course.text.trim(), courseId: _course.text.trim()),
    );

    if (widget.student != student) student.addOrUpdateStudent(widget.isEdit);

    if (widget.isEdit && widget.student != student)
      CurrentAssignmentBloc().onStudentDetailsUpdated(student);
    else
      CurrentAssignmentBloc().newAssignment(student);
  }
}
