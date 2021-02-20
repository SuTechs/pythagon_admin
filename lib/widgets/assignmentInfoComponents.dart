import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// name
        Text(
          'Su Mit',
          style: Theme.of(context).textTheme.caption,
        ),

        /// college
        Text(
          'Dark College of Eng.',
          style: Theme.of(context).textTheme.caption,
        ),

        /// phone
        Text(
          '+91766732338',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class AssignmentNameAndSubject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),

      /// subject logo
      leading: FlutterLogo(
        size: 48,
      ),

      /// subject name
      subtitle: Text(
        'Subject',
        style: TextStyle(height: 2),
      ),

      /// assignment name
      title: TextFormField(
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
  final _focus = FocusNode();

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
