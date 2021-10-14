import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/Utils.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/iconTextField.dart';
import 'package:pythagon_admin/widgets/ratingStar.dart';
import 'package:pythagon_admin/widgets/roundedTextField.dart';
import 'package:pythagon_admin/widgets/selectFromBottomSheet.dart';
import 'package:pythagon_admin/widgets/showRoundedBottomSheet.dart';
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
                          /// new teacher
                          if (index == 0)
                            return ListTile(
                              leading: CircleAvatar(child: Icon(Icons.add)),
                              title: Text('New Teacher'),
                              onTap: () {
                                print('addOrUpdate new teacher');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NewOrEditTeacher()));
                              },
                            );

                          if (index == 1)
                            return ListTile(
                              leading:
                                  CircleAvatar(child: Icon(Icons.done_all)),
                              title: Text('Select All'),
                              onTap: () {
                                selectedTeachersIds.clear();
                                setState(() {
                                  selectedTeachersIds
                                      .addAll(teachersList.map((e) => e.id));
                                });
                              },
                            );

                          index -= 2;

                          return TeacherTile(
                            onImageTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => NewOrEditTeacher(
                                            teacher: teachersList[index],
                                            isEdit: true,
                                          )));
                            },
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
                              color: Provider.of<UserData>(context).isDarkMode
                                  ? kDarkModeSecondaryColor
                                  : kLightModeSecondaryColor,
                            ),
                          );
                        },
                        itemCount: teachersList.length + 2,
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
    if (selectedTeachersIds.isEmpty) {
      showToast('No Teacher Selected');
      return;
    }

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
  final void Function() onImageTap;
  final bool isSelected;

  const TeacherTile(
      {Key? key,
      required this.teacher,
      required this.onTap,
      required this.onImageTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Provider.of<UserData>(context).isDarkMode
          ? kDarkModeSecondaryColor
          : kLightModeSecondaryColor,
      leading: GestureDetector(
        onTap: onImageTap,
        child: CircleAvatar(
          backgroundImage: NetworkImage(teacher.profilePic),
        ),
      ),
      title: Text(teacher.name),
      subtitle: Text(teacher.phone),
      trailing: RatingStar(
        size: 14,
        rating: teacher.rating.avgRating,
      ),
    );
  }
}

class NewOrEditTeacher extends StatefulWidget {
  final Teacher? teacher;
  final bool isEdit;

  const NewOrEditTeacher({Key? key, this.teacher, this.isEdit = false})
      : assert((!isEdit && teacher == null) || (isEdit && teacher != null),
            'If isEdit == true then teacher should not be null'),
        super(key: key);

  @override
  _NewOrEditTeacherState createState() => _NewOrEditTeacherState();
}

class _NewOrEditTeacherState extends State<NewOrEditTeacher> {
  @override
  void initState() {
    super.initState();
    if (widget.teacher != null) {
      _name.text = widget.teacher!.name;
      _phone.text = widget.teacher!.phone;
      _email.text = widget.teacher!.email;
      _college.text = widget.teacher!.college.collegeName;
      _subjectsList.text = widget.teacher!.subjectsIds.join(', ');
      _subjectIds.addAll(widget.teacher!.subjectsIds);
      _gender.text = widget.teacher!.gender;
      _dob.text = widget.teacher!.dateOfBirth;

      _isVerified.text =
          widget.teacher!.isVerified ? 'Verified' : 'Not Verified';
      _course.text = widget.teacher!.course.courseName;
      _accountInfo.text = widget.teacher!.accountInfo;
    }
  }

  final List<String> _subjectIds = [];
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _subjectsList = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _isVerified = TextEditingController();
  final TextEditingController _course = TextEditingController();
  final TextEditingController _accountInfo = TextEditingController();

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
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createUpdateStudent();
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(width: 12),
              ],
            ),
          ),

          /// info
          Expanded(
            child: ListView(
              children: [
                /// profile pic
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.teacher != null
                          ? widget.teacher!.profilePic
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

                /// subjects
                IconTextField(
                  labelText: 'Subjects',
                  icon: Icons.book,
                  controller: _subjectsList,
                  readOnly: true,
                  isRequired: true,
                  onTap: () {
                    showRoundedBottomSheet(
                      context: context,
                      child: FutureBuilder<List<Subject>>(
                          future: Subject.getSubjects(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error = ${snapshot.error}'));
                            }

                            if (snapshot.hasData)
                              return SelectMultipleSubjects(
                                initialSelectedSubjectIds: _subjectIds,
                                subjects: snapshot.data!,
                                onSelect: (value) {
                                  _subjectsList.text = value.join(', ');
                                  _subjectIds.clear();
                                  _subjectIds.addAll(value);
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
                  icon: Icons.account_balance,
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
                                    .map((e) =>
                                        ListItem<College>(e, e.collegeName))
                                    .toList(),
                                onNewItemSelect: (newItem) {
                                  College(
                                          collegeId: newItem,
                                          collegeName: newItem)
                                      .addCollege();
                                  _college.text = newItem;
                                },
                                onSelect: (value) {
                                  _college.text = value.collegeName;
                                },
                              );

                            return Center(child: CircularProgressIndicator());
                          }),
                    );
                  },
                ),

                /// course
                IconTextField(
                  labelText: 'Course',
                  icon: Icons.school,
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
                              return Center(
                                  child: Text('Error = ${snapshot.error}'));
                            }

                            if (snapshot.hasData)
                              return SelectFromList<Course>(
                                items: snapshot.data!
                                    .map((e) =>
                                        ListItem<Course>(e, e.courseName))
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
                        canHaveNewItem: false,
                        items: [
                          ListItem('Male', 'Male'),
                          ListItem('Female', 'Female'),
                          ListItem('Other', 'Other'),
                        ],
                        // onNewItemSelect: (newItem) {
                        //   _gender.text = newItem;
                        // },
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
                  // textInputAction: TextInputAction.done,
                ),

                /// isVerified
                IconTextField(
                  labelText: 'Verify',
                  icon: Icons.verified_outlined,
                  controller: _isVerified,
                  readOnly: true,
                  onTap: () {
                    showRoundedBottomSheet(
                      context: context,
                      child: SelectFromList<String>(
                        canHaveNewItem: false,
                        items: [
                          ListItem('Verified', 'Verified'),
                          ListItem('Not Verified', 'Not Verified'),
                        ],
                        onSelect: (value) {
                          _isVerified.text = value;
                        },
                      ),
                    );
                  },
                ),

                /// account info
                IconTextField(
                  maxLine: null,
                  labelText: 'Account Info',
                  icon: Icons.attach_money,
                  controller: _accountInfo,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void createUpdateStudent() {
    final teacher = Teacher(
        id: widget.isEdit ? widget.teacher!.id : _phone.text.trim(),
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        dateOfBirth: _dob.text.trim(),
        gender: _gender.text.trim(),
        profilePic: widget.teacher != null
            ? widget.teacher!.profilePic
            : kBlankProfilePicUrl,
        college: College(
            collegeName: _college.text.trim(), collegeId: _college.text.trim()),
        subjectsIds: _subjectIds,
        totalRating: widget.isEdit ? widget.teacher!.totalRating : 0,
        balance: widget.isEdit ? widget.teacher!.balance : 0,
        rating: widget.isEdit
            ? widget.teacher!.rating
            : TeacherRating(performance: 0, accuracy: 0, availability: 0),
        isVerified: _isVerified.text.trim() == 'Verified',
        accountInfo: _accountInfo.text.trim(),
        course: Course(
            courseName: _course.text.trim(), courseId: _course.text.trim()),
        tokens: []);

    print(
        'Hello = ${widget.teacher != teacher} and is verify = ${teacher.isVerified}');
    if (widget.teacher != teacher) teacher.addOrUpdateTeacher(widget.isEdit);
    SideSheet.closeIfOpen();
  }
}

class SelectMultipleSubjects extends StatefulWidget {
  final List<Subject> subjects;
  final List<String> initialSelectedSubjectIds;
  final void Function(List<String> subjectsIds) onSelect;

  const SelectMultipleSubjects(
      {Key? key,
      required this.subjects,
      required this.onSelect,
      required this.initialSelectedSubjectIds})
      : super(key: key);

  @override
  _SelectMultipleSubjectsState createState() => _SelectMultipleSubjectsState();
}

class _SelectMultipleSubjectsState extends State<SelectMultipleSubjects> {
  final List<Subject> subjectsList = [];
  final List<String> selectedSubjectsIds = [];
  String searchText = '';

  @override
  void initState() {
    if (widget.initialSelectedSubjectIds.isNotEmpty)
      selectedSubjectsIds.addAll(widget.initialSelectedSubjectIds);
    subjectsList.addAll(widget.subjects);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Provider.of<UserData>(context).isDarkMode
                          ? kDarkModeSecondaryColor
                          : kLightModeSecondaryColor,
                    ),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Search...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          subjectsList.clear();
                          subjectsList.addAll(widget.subjects);
                          subjectsList.retainWhere((element) => element.name
                              .toLowerCase()
                              .contains(value.trim().toLowerCase()));
                        });
                      },
                    ),
                  ),
                ),
                if (selectedSubjectsIds.isNotEmpty) SizedBox(width: 12),
                if (selectedSubjectsIds.isNotEmpty)
                  FloatingActionButton(
                    mini: true,
                    child: Icon(Icons.done),
                    onPressed: () {
                      widget.onSelect(selectedSubjectsIds);
                      Navigator.pop(context);
                    },
                  ),
                SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected:
                        selectedSubjectsIds.contains(subjectsList[index].id),
                    onTap: () {
                      setState(() {
                        if (selectedSubjectsIds
                            .contains(subjectsList[index].id))
                          selectedSubjectsIds.remove(subjectsList[index].id);
                        else
                          selectedSubjectsIds.add(subjectsList[index].id);
                      });
                    },
                    title: Text('${subjectsList[index].name}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(subjectsList[index].image),
                    ),
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
                itemCount: subjectsList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
///
///  teachers list
class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  // late ScrollController _scrollViewController;
  // bool _showAppbar = true;
  // bool _isScrollingDown = false;
  bool _isLoading = true;

  /// data
  late final List<Teacher> fetchedTeachers;
  final List<Teacher> teachersList = [];

  @override
  void initState() {
    super.initState();

    /// fetching teachers
    Teacher.getTeachers().then((value) {
      setState(() {
        fetchedTeachers = value;
        teachersList.addAll(fetchedTeachers);
        _isLoading = false;
      });
    });

    // _scrollViewController = new ScrollController();
    // _scrollViewController.addListener(() {
    //   if (_scrollViewController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (!_isScrollingDown) {
    //       _isScrollingDown = true;
    //       _showAppbar = false;
    //       setState(() {});
    //     }
    //   }
    //
    //   if (_scrollViewController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     if (_isScrollingDown) {
    //       _isScrollingDown = false;
    //       _showAppbar = true;
    //       setState(() {});
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                    // controller: _scrollViewController,
                    child: ListView.separated(
                      // controller: _scrollViewController,
                      itemBuilder: (context, index) {
                        /// new teacher
                        if (index == 0)
                          return ListTile(
                            leading: CircleAvatar(child: Icon(Icons.add)),
                            title: Text('New Teacher'),
                            onTap: () {
                              print('addOrUpdate new teacher');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => NewOrEditTeacher()));
                            },
                          );

                        index--;

                        return TeacherTile(
                          teacher: teachersList[index],
                          onImageTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => NewOrEditTeacher(
                                          teacher: teachersList[index],
                                          isEdit: true,
                                        )));
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => TeacherListDetails(
                                  teacher: teachersList[index],
                                ),
                              ),
                            );
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
                      itemCount: teachersList.length + 1,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

///  teachers list details
class TeacherListDetails extends StatelessWidget {
  final Teacher teacher;

  const TeacherListDetails({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          ListTile(
            selectedTileColor: Provider.of<UserData>(context).isDarkMode
                ? kDarkModeSecondaryColor
                : kLightModeSecondaryColor,
            // image
            leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NewOrEditTeacher(
                              teacher: teacher,
                              isEdit: true,
                            )));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(teacher.profilePic),
              ),
            ),
            // name
            title: Text(teacher.name),
            // rating
            subtitle: teacher.rating.avgRating == 0
                ? Text('No rating')
                : Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 11,
                      ),
                      SizedBox(width: 2),
                      Text('${teacher.rating.avgRating}'),
                      Text(
                        '  (${teacher.totalRating})',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
            // balance
            trailing: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Provider.of<UserData>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
                padding: EdgeInsets.only(right: 0, left: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TransactionsList(
                              teacherId: teacher.id,
                              balance: teacher.balance,
                            )));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹ ${teacher.balance}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Provider.of<UserData>(context).isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Provider.of<UserData>(context).isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                ],
              ),
            ),
          ),

          /// subjects
          ExpansionTile(
            title: Text('Subjects'),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            children: [
              for (String s in teacher.subjectsIds)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12,
                    backgroundImage: NetworkImage(Subject.subjects
                        .firstWhere((element) => element.id == s)
                        .image),
                  ),
                  title: Text(
                    '${Subject.subjects.firstWhere((element) => element.id == s).name}',
                  ),
                  trailing: Icon(
                    Icons.verified_outlined,
                    size: 14,
                  ),
                ),
            ],
          ),

          // /// current assignments
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     'Current Assignment',
          //     style:
          //         Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10),
          //   ),
          // ),
          // TeacherAssignmentDetailsListTile(
          //   isInitiallyOpened: true,
          //   data: teachersAssignments,
          //   assignment: currentAssignment,
          // ),
        ],
      ),
    );
  }
}

class TransactionsList extends StatefulWidget {
  final String teacherId;
  final double balance;

  const TransactionsList(
      {Key? key, required this.teacherId, required this.balance})
      : super(key: key);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  late double balance = widget.balance;
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;
  double amount = 0;
  final List<Transaction> _transactions = [];
  bool _isLoading = true;

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

    /// fetching data

    Transaction.getTransaction(widget.teacherId).then((value) {
      setState(() {
        _transactions.addAll(value);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Transactions',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              /// balance
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Provider.of<UserData>(context).isDarkMode
                      ? kDarkModeSecondaryColor
                      : kLightModeSecondaryColor,
                ),
                child: Row(
                  children: [
                    Text(
                      'Balance Available',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '₹ $balance',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              /// transaction
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        controller: _scrollViewController,
                        itemBuilder: (_, i) {
                          return TransactionListTile(
                            transaction: _transactions[i],
                          );
                        },
                        separatorBuilder: (_, i) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            color: const Color(0xff707070),
                            height: 0.1,
                          );
                        },
                        itemCount: _transactions.length),
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

                          if (amount > balance)
                            return 'You can not pay more than available balance!';
                        },
                      ),
                    ),
                    SizedBox(width: 12),

                    /// Settle Up button
                    SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kDarkModePrimaryColor),
                          shape: MaterialStateProperty.all(StadiumBorder()),
                        ),
                        child: Text('Settle Up'),
                        onPressed: settleUp,
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void settleUp() async {
    if (amount <= 0) {
      showToast('Invalid amount');
      return;
    }

    if (amount > balance) {
      showToast('You can not pay more than available balance!');
      return;
    }

    /// creating transaction and settling up

    final t =
        await Transaction.createTransaction(widget.teacherId, amount, true);

    if (t != null) {
      setState(() {
        balance = t.closingBalance;
        _transactions.insert(0, t);
      });
    }
  }
}

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionListTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 0.5,
            color: Provider.of<UserData>(context).isDarkMode
                ? kDarkModeSecondaryColor
                : kLightModeSecondaryColor,
          ),
        ),
        child: Icon(
          transaction.isWithdrawn ? Icons.north_east : Icons.south_west,
        ),
      ),
      title: Text(
        'Money ${transaction.isWithdrawn ? 'Withdrawn' : 'Deposited'}',
      ),
      subtitle: Text(getFormattedTime(transaction.createdAt)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${transaction.isWithdrawn ? '-' : '+'} ₹${transaction.amount}',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'CB: ₹${transaction.closingBalance}',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
