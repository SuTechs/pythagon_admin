import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '/data/bloc/currentAssignmentBloc.dart';
import '/data/database.dart';
import '/data/utils/Utils.dart';
import '/data/utils/modal/collectionRef.dart';
import '/data/utils/modal/user.dart';
import '/screens/assignmentDetails/teacherInfo.dart';
import '/widgets/assignmentDetailsLayout.dart';
import '/widgets/assignmentInfoComponents.dart';
import '/widgets/priceTextField.dart';
import '/widgets/showToast.dart';
import '/widgets/teacherAssignmentStatusIcon.dart';
import '../constants.dart';
import 'assignmentDetails/selectSubject.dart';
import 'assignmentDetails/selectTeacher.dart';
import 'assignmentList.dart';

class SideSheet {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  static final SideSheet _singleton = SideSheet._internal();
  factory SideSheet() {
    return _singleton;
  }
  SideSheet._internal();

  Widget? _sideChild;

  Widget? get sideChild => _sideChild;

  void openDrawer({required Widget child}) {
    _sideChild = child;
    scaffoldKey.currentState!.openEndDrawer();
  }

  static void closeDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  static void closeIfOpen() {
    if (scaffoldKey.currentState != null &&
        scaffoldKey.currentState!.isEndDrawerOpen) closeDrawer();
  }
}

class AssignmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      key: SideSheet.scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      floatingActionButton: Visibility(
        visible: Provider.of<CurrentAssignmentBloc>(context).canUpdate,
        child: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            CurrentAssignmentBloc().updateAssignment();
          },
        ),
      ),

      /// side sheet drawer
      endDrawer: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Provider.of<UserData>(context).isDarkMode
                ? kDarkModeSecondaryColor
                : kLightModeSecondaryColor,
          ),
        ),
        child: CustomContainer(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            child: Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (_) => SideSheet().sideChild!,
              ),
            ),
          ),
        ),
      ),

      /// body
      body: Provider.of<CurrentAssignmentBloc>(context).assignment == null
          ? CustomContainer(
              child: Center(
                child: Text('Add some illustration here!'),
              ),
            )
          : AssignmentDetailsLayout(
              details: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: AssignmentInfo(),
              ),
              teacher: TeacherCard(),
              payment: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: PaymentCard(),
              ),
            ),
    );
  }
}

class AssignmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AssignmentInfoLayout(
      studentInfo: GestureDetector(
        child: StudentInfoRow(
          student:
              Provider.of<CurrentAssignmentBloc>(context).assignment!.student,
        ),
        onTap: () {
          SideSheet().openDrawer(
            child: NewOrEditStudent(
              isEdit: true,
              student:
                  Provider.of<CurrentAssignmentBloc>(context, listen: false)
                      .assignment!
                      .student,
            ),
          );
        },
      ),
      nameAndSubject: AssignmentNameAndSubject(
        subject:
            Provider.of<CurrentAssignmentBloc>(context).assignment!.subject,
        initialName: CurrentAssignmentBloc().assignment!.name,
        onSubjectTap: () {
          SideSheet().openDrawer(
            child: FutureBuilder<List<Subject>>(
                future: Subject.getSubjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error = ${snapshot.error}'));
                  }

                  if (snapshot.hasData)
                    return SelectSubject(
                      fetchedSubjects: snapshot.data ?? [],
                      onSubjectSelect: (s) {
                        CurrentAssignmentBloc().onSubjectSelect(s);
                        SideSheet.closeDrawer();
                      },
                    );

                  return Center(child: CircularProgressIndicator());
                }),
          );
        },
        onNameChanged: (name) {
          CurrentAssignmentBloc().assignment!.name = name;
          CurrentAssignmentBloc().notifyAssignmentUpdate();
        },
      ),
      timeAndType: AssignmentTimeAndType(),
      description: DescriptionTextField(
        initialDesc: CurrentAssignmentBloc().assignment!.description,
        onDescChanged: (desc) {
          CurrentAssignmentBloc().assignment!.description = desc;
          CurrentAssignmentBloc().notifyAssignmentUpdate();
        },
      ),
      attachments: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Assignment Files'),
                Tab(text: 'Reference Files'),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  /// assignment files
                  AttachmentList(
                    assignmentId: CurrentAssignmentBloc().assignment!.id,
                    files: CurrentAssignmentBloc().assignment!.assignmentFiles,
                    onFilesUpload: (urls) async {
                      CurrentAssignmentBloc()
                          .assignment!
                          .assignmentFiles
                          .addAll(urls);
                      CurrentAssignmentBloc().updateAssignment();
                    },
                    onFileDelete: (url) async {
                      CurrentAssignmentBloc()
                          .assignment!
                          .assignmentFiles
                          .remove(url);
                      CurrentAssignmentBloc().updateAssignment();
                    },
                  ),

                  /// reference files
                  AttachmentList(
                    assignmentId: CurrentAssignmentBloc().assignment!.id,
                    files: CurrentAssignmentBloc().assignment!.referenceFiles,
                    onFilesUpload: (urls) async {
                      CurrentAssignmentBloc()
                          .assignment!
                          .referenceFiles
                          .addAll(urls);
                      CurrentAssignmentBloc().updateAssignment();
                    },
                    onFileDelete: (url) async {
                      CurrentAssignmentBloc()
                          .assignment!
                          .referenceFiles
                          .remove(url);
                      CurrentAssignmentBloc().updateAssignment();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DueAmountAndSettleUp(
          key: Key('${CurrentAssignmentBloc().textFieldKey}'),
          dueAmount: CurrentAssignmentBloc().assignment!.dueAmount,
          onSettleUp: CurrentAssignmentBloc().settleUp,
        ),

        Spacer(),

        /// total amount
        Row(
          children: [
            Text('Total: ', style: Theme.of(context).textTheme.headline5),
            Expanded(
              child: PriceTextField(
                textStyle: Theme.of(context).textTheme.headline5,
                hintText: 'Enter Total Amount',
                initialPrice: CurrentAssignmentBloc().assignment!.totalAmount,
                onPriceChanged: (totalAmount) {
                  CurrentAssignmentBloc().assignment!.totalAmount = totalAmount;
                  CurrentAssignmentBloc().notifyAssignmentUpdate();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TeacherCard extends StatefulWidget {
  @override
  _TeacherCardState createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool _isScrollingDown = false;

  /// data
  bool _isLoading = true;
  final List<Teacher> fetchedTeachers = [];
  final List<TeachersAssignments> teachersAssignments = [];

  @override
  void initState() {
    super.initState();

    fetchTeachers();

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

  /// fetch teachers
  void fetchTeachers() async {
    // if (!_isLoading)
    //   setState(() {
    //     _isLoading = true;
    //   });

    /// fetch teachers

    final t = await Teacher.getTeachers();
    // fetchedTeachers.addAll(t);

    // if (_isLoading)
    setState(() {
      fetchedTeachers.addAll(t);
      _isLoading = false;
    });
  }

  List<TeachersAssignments> handleStreamData(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    teachersAssignments.clear();
    for (QueryDocumentSnapshot<Map<String, dynamic>> v in snapshot.docs) {
      try {
        teachersAssignments
            .add(TeachersAssignments.fromJson(v.data(), fetchedTeachers));
      } catch (e) {
        print('\nError while parsing teachers assignment = $e');
        continue;
      }
    }

    teachersAssignments.sort((a, b) => a.time.compareTo(b.time));

    return teachersAssignments;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: CollectionRef.teachersAssignments
            .where('assignmentId',
                isEqualTo: CurrentAssignmentBloc().assignment!.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error #213 = ${snapshot.error}'));
          }

          if (snapshot.hasData && !_isLoading) {
            final data = handleStreamData(snapshot.data!);

            return Stack(
              children: [
                /// list
                data.isEmpty
                    ? Center(child: Text('Select Teachers!'))
                    : Scrollbar(
                        child: ListView.builder(
                          controller: _scrollViewController,
                          itemBuilder: (context, index) {
                            return TeacherAssignmentListTile(data: data[index]);
                          },
                          itemCount: data.length,
                        ),
                      ),

                /// actions
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
                          Spacer(),
                          FloatingActionButton(
                            child: Icon(Icons.add),
                            onPressed: () {
                              if (CurrentAssignmentBloc()
                                      .assignment!
                                      .totalAmount ==
                                  null) {
                                showToast('Enter Total Amount First!');
                                return;
                              } else if (CurrentAssignmentBloc()
                                      .assignment!
                                      .subject ==
                                  null) {
                                showToast('Select Subject First!');
                                return;
                              } else
                                SideSheet().openDrawer(
                                    child: SelectTeacher(
                                  assignmentId:
                                      CurrentAssignmentBloc().assignment!.id,
                                  assignmentPrice: CurrentAssignmentBloc()
                                      .assignment!
                                      .totalAmount!,
                                  subjectId: CurrentAssignmentBloc()
                                      .assignment!
                                      .subject!
                                      .id,
                                  alreadySelectedTeachersIds:
                                      data.map((e) => e.teacher.id).toList(),
                                ));
                            },
                            mini: true,
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

          return Center(child: CircularProgressIndicator());
        });
  }

  // @override
  // void dispose() {
  //   _scrollViewController.dispose();
  //   _scrollViewController.removeListener(() {});
  //   super.dispose();
  // }
}

class TeacherAssignmentListTile extends StatelessWidget {
  final TeachersAssignments data;

  const TeacherAssignmentListTile({Key? key, required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        SideSheet().openDrawer(
            child: TeacherInfo(
          currentAssignment: CurrentAssignmentBloc().assignment!,
          teachersAssignments: data,
        ));
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data.teacher.profilePic),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${data.teacher.name}'),
          SizedBox(width: 4),
          if (data.status != TeacherAssignmentStatus.Sent)
            TeacherAssignmentStatusIcon(
              size: 16,
              status: data.status,
              rating: data.status == TeacherAssignmentStatus.Rated
                  ? data.rating!.avgRating
                  : null,
            ),
        ],
      ),
      subtitle: Text('Rs ${data.amount}'),
      trailing: Text(
        '${getFormattedTime(data.time)}',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
    );
  }
}
