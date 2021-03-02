import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:pythagon_admin/data/bloc/currentAssignmentBloc.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/data/utils/modal/user.dart';
import 'package:pythagon_admin/screens/assignmentDetails/teacherInfo.dart';
import 'package:pythagon_admin/widgets/assignmentDetailsLayout.dart';
import 'package:pythagon_admin/widgets/assignmentInfoComponents.dart';
import 'package:pythagon_admin/widgets/priceTextField.dart';
import 'package:pythagon_admin/widgets/teacherAssignmentStatusIcon.dart';
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
      endDrawer: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Provider.of<User>(context).isDarkMode
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
      body: AssignmentDetailsLayout(
        details: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: AssignmentInfo(),
        ),
        teacher: TeacherCard(),
        payment: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                      onSubjectChange: (s) {
                        CurrentAssignmentBloc().onSubjectSelect(s);
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
      attachments: AttachmentList(
        files: CurrentAssignmentBloc().assignment!.referenceFiles,
        updateFiles: ({required bool isDelete, required String url}) {
          if (isDelete)
            CurrentAssignmentBloc().assignment!.referenceFiles.remove(url);
          else
            CurrentAssignmentBloc().assignment!.referenceFiles.add(url);

          CurrentAssignmentBloc().notifyAssignmentUpdate();
        },
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
        /// list
        Scrollbar(
          child: ListView.builder(
            controller: _scrollViewController,
            itemBuilder: (context, index) {
              return TeacherAssignmentListTile(status: _kTeacherStatus[index]);
            },
            itemCount: _kTeacherStatus.length,
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
                      SideSheet().openDrawer(child: SelectTeacher());
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

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }
}

class TeacherAssignmentListTile extends StatelessWidget {
  final TeacherAssignmentStatus status;

  const TeacherAssignmentListTile({Key? key, required this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        SideSheet().openDrawer(child: TeacherInfo());
      },
      leading: CircleAvatar(child: FlutterLogo()),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uchit Chakma'),
          SizedBox(width: 4),
          if (status != TeacherAssignmentStatus.Sent)
            TeacherAssignmentStatusIcon(
              size: 16,
              status: status,
              rating: status == TeacherAssignmentStatus.Rated ? 3.6 : null,
            ),
        ],
      ),
      subtitle: Text('Rs 500/-'),
      trailing: Text(
        'Feb 28 7:45 PM',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
    );
  }
}

const _kTeacherStatus = TeacherAssignmentStatus.values;
