import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/data/bloc/currentAssignmentBloc.dart';
import '/data/database.dart';
import '/data/utils/Utils.dart';
import '/widgets/fileIcons.dart';
import '/widgets/showToast.dart';

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
        key: Key('${CurrentAssignmentBloc().textFieldKey}'),
        initialValue: initialName,
        onChanged: (v) {
          if (v.trim().length > 0) onNameChanged(v.trim());
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

class AssignmentTimeAndType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.calendar_today_rounded,
            size: 14,
            color:
                Provider.of<CurrentAssignmentBloc>(context).assignment!.time ==
                        null
                    ? Colors.grey
                    : null),
        InkWell(
          onTap: () {
            selectDateTime(context);
          },
          child: Text(
            ' ${Provider.of<CurrentAssignmentBloc>(context).assignment!.time != null ? getFormattedTime(Provider.of<CurrentAssignmentBloc>(context).assignment!.time!) : 'Select Time'}',
            style: TextStyle(
              color: Provider.of<CurrentAssignmentBloc>(context)
                          .assignment!
                          .time ==
                      null
                  ? Colors.grey
                  : null,
            ),
          ),
        ),
        SizedBox(width: 32),
        DropdownButton<AssignmentType>(
          value: Provider.of<CurrentAssignmentBloc>(context)
              .assignment!
              .assignmentType,
          hint: Text('Assignment Type'),
          items: AssignmentType.values
              .map(
                (e) => DropdownMenuItem<AssignmentType>(
                  child: Text('${kAssignmentTypeEnumMap[e]}'),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (v) {
            CurrentAssignmentBloc().assignment!.assignmentType = v;
            CurrentAssignmentBloc().notifyAssignmentUpdate();
          },
          underline: SizedBox.shrink(),
          icon: SizedBox.shrink(),
        ),
      ],
    );
  }

  void selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      useRootNavigator: false,
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 120)),
      firstDate: DateTime.now(),
    );
    if (pickedDate == null) return;

    final TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (timeOfDay == null) return;

    final pickedDateAndTime = pickedDate
        .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));

    // print('time = ${getFormattedTime(pickedDateAndTime)}');
    CurrentAssignmentBloc().assignment!.time = pickedDateAndTime;
    CurrentAssignmentBloc().notifyAssignmentUpdate();
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
      focusNode: _focus,
      onKey: (key) {
        if (key.isShiftPressed && key.isKeyPressed(LogicalKeyboardKey.enter))
          _focus.unfocus();
      },
      child: Scrollbar(
        child: TextFormField(
          key: Key('${CurrentAssignmentBloc().textFieldKey}'),
          onChanged: (v) {
            if (v.trim().length > 0) onDescChanged(v.trim());
          },
          validator: (v) {
            if (v != null && v.trim().length < 1)
              return 'Description is required';
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialDesc,
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
  final List<String> files;
  final String assignmentId;
  final Future<void> Function(List<String> urls) onFilesUpload;
  final Future<void> Function(String url) onFileDelete;

  const AttachmentList({
    Key? key,
    required this.files,
    required this.onFilesUpload,
    required this.onFileDelete,
    required this.assignmentId,
  }) : super(key: key);

  @override
  _AttachmentListState createState() => _AttachmentListState();
}

class _AttachmentListState extends State<AttachmentList> {
  int? _selectedIndex;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.files.isEmpty)
          Center(
            child: Text('Upload Reference files!'),
          )
        else
          Scrollbar(
            child: ListView.builder(
              itemCount: widget.files.length,
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
                  title: Text(_getFileName(widget.files[index])),
                  leading: CircleAvatar(
                    child: FileIcon(_getFileName(widget.files[index])),
                  ),
                  trailing: _selectedIndex == index
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.download_outlined),
                              onPressed: () {
                                _launchURL(widget.files[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = null;
                                });
                                widget.onFileDelete(widget.files[index]);

                                // ToDo: implement delete file here
                              },
                            ),
                          ],
                        )
                      : null,
                );
              },
            ),
          ),

        /// upload file
        Align(
          alignment: Alignment.bottomRight,
          child: _isUploading
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: () async {
                    setState(() {
                      _isUploading = true;
                    });

                    await _uploadFiles();

                    setState(() {
                      _isUploading = false;
                    });
                  },
                  icon: Icon(Icons.upload_outlined),
                  splashRadius: 16,
                ),
        )
      ],
    );
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : showToast('Could not launch $url');

  String _getFileName(String url) {
    try {
      return FirebaseStorage.instance.refFromURL(url).name;
    } catch (e) {
      print('Error #13121 =$e');
      return Uri.decodeFull(url).toString().split('/').last;
    }

    // if (url.contains('key')) {
    //   final f = url.split('key');
    //
    //   if (f.length > 2) return Uri.decodeFull(f[1]).toString();
    // }
    // return Uri.decodeFull(url).toString().split('/').last;
  }

  Future<void> _uploadFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) {
      showToast('No File Selected!');
      return;
    }

    /// uploading file

    final urls = <String>[];

    for (final f in result.files) {
      final r = await FirebaseStorage.instance
          .ref('Assignments')
          .child(widget.assignmentId)
          .child(f.name)
          .putData(f.bytes!);

      final url = await r.ref.getDownloadURL();
      urls.add(url);
    }

    /// calling assignment to update

    await widget.onFilesUpload(urls);
  }
}
