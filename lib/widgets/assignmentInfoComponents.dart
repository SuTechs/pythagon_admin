import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pythagon_admin/data/database.dart';

/// assignment info components

class AssignmentInfoLayout extends StatelessWidget {
  final Widget studentInfo;
  final Widget nameAndSubject;
  final Widget timeAndType;
  final Widget description;
  final Widget attachments;

  const AssignmentInfoLayout(
      {Key? key,
      required this.studentInfo,
      required this.nameAndSubject,
      required this.timeAndType,
      required this.description,
      required this.attachments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Student info row
        studentInfo,
        SizedBox(height: 32),

        /// Assignment name
        Row(
          children: [
            /// assignment name and subject
            Expanded(
              flex: 3,
              child: nameAndSubject,
            ),
            SizedBox(width: 32),

            /// due date and time
            Expanded(
              flex: 2,
              child: timeAndType,
            ),
          ],
        ),
        SizedBox(height: 64),

        /// Assignment description and attachment
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// assignment description
              Expanded(
                flex: 3,
                child: description,
              ),
              SizedBox(width: 32),

              /// attachment
              Expanded(
                flex: 2,
                child: attachments,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentInfoRow extends StatelessWidget {
  final Student student;

  const StudentInfoRow({Key? key, required this.student}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// name
        Text(
          '${student.name}',
          style: Theme.of(context).textTheme.caption,
        ),

        /// college
        Text(
          '${student.college.collegeName}',
          style: Theme.of(context).textTheme.caption,
        ),

        /// phone
        Text(
          '${student.phone}',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class AssignmentNameAndSubject extends StatelessWidget {
  final void Function() onSubjectTap;
  final String? initialName;
  final Subject? subject;
  final void Function(String) onNameChanged;

  const AssignmentNameAndSubject(
      {Key? key,
      required this.onSubjectTap,
      required this.subject,
      required this.initialName,
      required this.onNameChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onSubjectTap,
      contentPadding: EdgeInsets.all(0),

      /// subject logo
      leading: CircleAvatar(
        backgroundImage: subject != null ? NetworkImage(subject!.image) : null,
        child: subject != null
            ? null
            : FlutterLogo(
                size: 48,
              ),
      ),

      /// subject name
      subtitle: Text(
        subject != null ? subject!.name : 'Subject',
        style: TextStyle(height: 2),
      ),

      /// assignment name
      title: TextFormField(
        initialValue: initialName,
        onChanged: (v) {
          if (v.trim().length > 0 && v.trim() != initialName)
            onNameChanged(v.trim());
        },
        validator: (v) {
          if (v != null && v.trim().length < 1) return 'Name is required';
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [
          LengthLimitingTextInputFormatter(60),
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          isDense: true,
          hintText: 'Assignment Name',
        ),
      ),
    );
  }
}

class AssignmentTimeAndType extends StatefulWidget {
  @override
  _AssignmentTimeAndTypeState createState() => _AssignmentTimeAndTypeState();
}

class _AssignmentTimeAndTypeState extends State<AssignmentTimeAndType> {
  String? _value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Due By: 23/08/2021'),
        SizedBox(width: 32),
        DropdownButton<String>(
          value: _value,
          hint: Text('Assignment Type'),
          items: <String>['Assignment', 'Quiz'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          underline: SizedBox.shrink(),
          icon: SizedBox.shrink(),
        ),
      ],
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  final String? initialDesc;
  final void Function(String) onDescChanged;
  final _focus = FocusNode();

  DescriptionTextField(
      {Key? key, this.initialDesc, required this.onDescChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (key) {
        if (key.isShiftPressed && key.isKeyPressed(LogicalKeyboardKey.enter))
          _focus.unfocus();
      },
      child: Scrollbar(
        child: TextFormField(
          onChanged: (v) {
            if (v.trim().length > 0 && v.trim() != initialDesc)
              onDescChanged(v.trim());
          },
          validator: (v) {
            if (v != null && v.trim().length < 1)
              return 'Description is required';
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialDesc,
          focusNode: _focus,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            isDense: true,
            hintText: 'Assignment description',
          ),
        ),
      ),
    );
  }
}

class AttachmentList extends StatefulWidget {
  @override
  _AttachmentListState createState() => _AttachmentListState();
}

class _AttachmentListState extends State<AttachmentList> {
  int? _selectedIndex;
  int _length = 3;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scrollbar(
          child: ListView.builder(
            itemCount: _length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    if (_selectedIndex == index)
                      _selectedIndex = null;
                    else
                      _selectedIndex = index;
                  });
                },
                title: Text('filename_$index.pdf'),
                leading: CircleAvatar(child: Icon(Icons.picture_as_pdf)),
                trailing: _selectedIndex == index
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.download_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                if (_length > 0) {
                                  _length -= 1;
                                  _selectedIndex = null;
                                }
                              });
                            },
                          ),
                        ],
                      )
                    : null,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () {
              setState(() {
                _length += 1;
              });
            },
            icon: Icon(Icons.upload_outlined),
            splashRadius: 16,
          ),
        )
      ],
    );
  }
}
