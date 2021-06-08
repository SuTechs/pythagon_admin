import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/database.dart';
import '/data/utils/modal/user.dart';
import '/screens/assignmentDetails.dart';
import '/widgets/iconTextField.dart';
import '/widgets/roundedTextField.dart';
import '/widgets/selectFromBottomSheet.dart';
import '/widgets/showRoundedBottomSheet.dart';
import '/widgets/showToast.dart';
import '../../constants.dart';

class SelectSubject extends StatefulWidget {
  final List<Subject> fetchedSubjects;
  final void Function(Subject) onSubjectSelect;

  const SelectSubject(
      {Key? key, required this.fetchedSubjects, required this.onSubjectSelect})
      : super(key: key);

  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  final List<Subject> subjects = [];

  @override
  void initState() {
    subjects.addAll(widget.fetchedSubjects);
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
              Expanded(
                child: RoundedTextField(
                  hintText: 'Search subject...',
                  autoFocus: true,
                  onChanged: (value) {
                    setState(() {
                      subjects.clear();
                      subjects.addAll(widget.fetchedSubjects);
                      subjects.retainWhere((element) => element.name
                          .toLowerCase()
                          .contains(value.trim().toLowerCase()));
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () => SideSheet.closeDrawer(),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),

        /// subjects list
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (context, index) {
                /// new subject
                if (index == 0)
                  return Visibility(
                    visible: UserData.isGod,
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.add)),
                      title: Text('New Subject'),
                      onTap: () {
                        print('add new subject');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SubjectAddEditDetails()));
                      },
                    ),
                  );

                index--;

                return SubjectTile(
                  onSubjectChange: widget.onSubjectSelect,
                  subject: subjects[index],
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
              itemCount: subjects.length + 1,
            ),
          ),
        ),
      ],
    );
  }
}

class SubjectTile extends StatelessWidget {
  final void Function(Subject) onSubjectChange;
  final Subject subject;

  const SubjectTile(
      {Key? key, required this.onSubjectChange, required this.subject})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onSubjectChange(subject);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(subject.image),
      ),
      title: Text('${subject.name}'),
    );
  }
}

/// add edit subject
class SubjectAddEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subject>>(
        future: Subject.getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error = ${snapshot.error}'));
          }

          if (snapshot.hasData)
            return SelectSubject(
              fetchedSubjects: snapshot.data ?? [],
              onSubjectSelect: (s) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SubjectAddEditDetails(subject: s)));
              },
            );

          return Center(child: CircularProgressIndicator());
        });
  }
}

class SubjectAddEditDetails extends StatefulWidget {
  final Subject? subject;
  late final bool isEdit;
  SubjectAddEditDetails({Key? key, this.subject}) : super(key: key) {
    isEdit = subject != null;
  }

  @override
  _SubjectAddEditDetailsState createState() => _SubjectAddEditDetailsState();
}

class _SubjectAddEditDetailsState extends State<SubjectAddEditDetails> {
  // ToDo: add a blank subject url
  late String _imageUrl =
      widget.isEdit ? widget.subject!.image : kBlankProfilePicUrl;

  late final TextEditingController _nameController =
      TextEditingController(text: widget.isEdit ? widget.subject!.name : '');

  late final TextEditingController _isActiveController = TextEditingController(
      text: _getActiveText(widget.isEdit ? widget.subject!.isEnable : false));

  final _formKey = GlobalKey<FormState>();

  /// image
  PlatformFile? localImage;

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
                    /// update or add new subject
                    if (_formKey.currentState!.validate()) {
                      addUpdateSubjects();
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
            child: InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundImage: localImage != null
                    ? MemoryImage(localImage!.bytes!)
                    : NetworkImage(_imageUrl) as ImageProvider,
                radius: 64,
              ),
            ),
          ),

          SizedBox(height: 32),

          /// name
          IconTextField(
            labelText: 'Name',
            icon: Icons.school,
            controller: _nameController,
            isRequired: true,
          ),

          /// gender
          IconTextField(
            labelText: 'Is Active',
            icon: Icons.wc,
            controller: _isActiveController,
            readOnly: true,
            onTap: () {
              showRoundedBottomSheet(
                context: context,
                child: SelectFromList<bool>(
                  items: [
                    ListItem(true, 'Enable'),
                    ListItem(false, 'Disable'),
                  ],
                  canHaveNewItem: false,
                  onSelect: (value) {
                    _isActiveController.text = _getActiveText(value);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getActiveText(bool value) => value ? 'Active' : 'Disabled';

  void _pickImage() async {
    final f = await FilePicker.platform.pickFiles(type: FileType.image);
    if (f != null) {
      setState(() {
        localImage = f.files.single;
      });
    }
  }

  Future<void> _uploadImage(String id) async {
    if (localImage == null) return;

    /// uploading image

    final r = await FirebaseStorage.instance
        .ref('Subjects')
        .child(id + '.png')
        .putData(localImage!.bytes!);

    _imageUrl = await r.ref.getDownloadURL();
  }

  void addUpdateSubjects() async {
    final id = widget.isEdit ? widget.subject!.id : _nameController.text.trim();

    await _uploadImage(id);

    final s = Subject(
      id: id,
      name: _nameController.text.trim(),
      image: _imageUrl,
      isEnable: _isActiveController.text == 'Active',
    );

    await s.addOrEditSubject(widget.isEdit);

    showToast('Subject ${s.name} ${widget.isEdit ? 'Updated' : 'Added'}!');
  }
}
