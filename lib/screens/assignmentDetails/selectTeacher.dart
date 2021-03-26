import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
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
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NewOrEditTeacher()));
                              },
                            );

                          index--;

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
                        itemCount: teachersList.length + 1,
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
        rating: teacher.rating.avgRating,
      ),
    );
  }
}

class NewOrEditTeacher extends StatefulWidget {
  final Teacher? teacher;
  final bool isEdit;
  const NewOrEditTeacher({Key? key, this.teacher, this.isEdit = false})
      : super(key: key);

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
      _subjectsList.text = widget.teacher!.subjectsIds.join(' ');
      _gender.text = widget.teacher!.gender;
      _dob.text = widget.teacher!.dateOfBirth;
    }
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _college = TextEditingController();
  final TextEditingController _subjectsList = TextEditingController();
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
                        return Center(child: Text('Error = ${snapshot.error}'));
                      }

                      if (snapshot.hasData)
                        return SelectMultipleSubjects(
                          subjects: snapshot.data!,
                          onSelect: (value) {
                            _subjectsList.text = value;
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
    final teacher = Teacher(
      id: _phone.text.trim(),
      name: _name.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      dateOfBirth: _dob.text.trim(),
      gender: _gender.text.trim(),
      profilePic: kBlankProfilePicUrl,
      college: College(
          collegeName: _college.text.trim(), collegeId: _college.text.trim()),
      subjectsIds: _subjectsList.text.split(' '),
      totalRating: widget.isEdit ? widget.teacher!.totalRating : 0,
      balance: widget.isEdit ? widget.teacher!.balance : 0,
      rating: widget.isEdit
          ? widget.teacher!.rating
          : TeacherRating(performance: 0, accuracy: 0, availability: 0),
    );

    if (widget.teacher != teacher) teacher.addOrUpdateTeacher(widget.isEdit);
  }
}

class SelectMultipleSubjects extends StatefulWidget {
  final List<Subject> subjects;
  final void Function(String subjectsList) onSelect;

  const SelectMultipleSubjects(
      {Key? key, required this.subjects, required this.onSelect})
      : super(key: key);
  @override
  _SelectMultipleSubjectsState createState() => _SelectMultipleSubjectsState();
}

class _SelectMultipleSubjectsState extends State<SelectMultipleSubjects> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
