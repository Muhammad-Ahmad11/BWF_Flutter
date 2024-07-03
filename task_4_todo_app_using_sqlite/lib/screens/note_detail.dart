import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_4_todo_app_using_sqlite/models/note.dart';
import 'package:task_4_todo_app_using_sqlite/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final Note? note;

  const NoteDetail({super.key, this.note});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  var _selectedPriority = 'Low';
  var _currentStatus = 'Pending';

  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title!;
      descriptionController.text = widget.note!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Ensure the method returns a Future<bool>
          moveToLastScreen();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.note == null ? "Add Note" : "Edit Note"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // First element
                    Expanded(
                      child: ListTile(
                        title: DropdownButton<String>(
                          value: _selectedPriority,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPriority = newValue!;
                            });
                          },
                          items: <String>['Low', 'High']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // Status
                    Expanded(
                      child: ListTile(
                        title: DropdownButton<String>(
                          value: _currentStatus,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentStatus = newValue!;
                            });
                          },
                          items: <String>['Pending', 'Completed']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    //style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        //labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Third Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    //style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        //labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),

                // Fourth Element row
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // for equal space
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColorDark),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColorLight),
                          ),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColorDark),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColorLight),
                          ),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        widget.note!.priority = 1;
        break;
      case 'Low':
        widget.note!.priority = 2;
        break;
    }
  }

  void updateTitle() {
    print(titleController.text);
    widget.note!.title = titleController.text;
    print(widget.note!.title);
  }

  void updateDescription() {
    widget.note!.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    var date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    // Create a Note object
    Note note = Note(
      id: widget.note
          ?.id, // Use existing id if updating, otherwise it will be null for new notes
      title: titleController.text,
      description: descriptionController.text,
      date: date.toString(),
      priority: _selectedPriority == 'High' ? 2 : 1,
      status: _currentStatus == 'Pending' ? 'Pending' : 'Completed',
    );

    if (widget.note != null) {
      // Case 1: Update operation
      print("update");
      /*Note note = Note(
        id: 1,
        title: titleController.text,
        description: descriptionController.text,
        date: date.toString(),
        priority: _selectedStatus == 'High' ? 2 : 1,
      );*/
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      print("insert");
      /*Note note = Note(
        id: 1,
        title: titleController.text,
        description: descriptionController.text,
        date: date.toString(),
        priority: _selectedStatus == 'High' ? 2 : 1,
      );*/
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (widget.note!.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(widget.note!.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
