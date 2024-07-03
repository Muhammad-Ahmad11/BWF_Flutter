import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_5_expense_tracker_with_firebase/read%20data/get_user_name.dart';

class Editlisttile extends StatefulWidget {
  final String documentId;

  const Editlisttile({super.key, required this.documentId});

  @override
  State<Editlisttile> createState() => _EditlisttileState();
}

class _EditlisttileState extends State<Editlisttile> {
  // text Controllers
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future updateUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentId)
        .update({
      'first name': _firstNameController.text,
      'last name': _lastNameController.text,
      'age': int.parse(_ageController.text),
    });
    Navigator.pop(context, true);
  }

  Future deleteUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentId)
        .delete();
    Navigator.pop(context, true); // Return true to indicate a deletion
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: FutureBuilder(
        future: users.doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //grab the data fromt he snapshot
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            _firstNameController.text = data['first name'].toString();
            _lastNameController.text = data['last name'].toString();
            _ageController.text = data['age'].toString();

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // first name textField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First Name',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // last name textField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last Name',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // age textField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Age',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  //Text('First Name: ${data['first name']}'),
                  //GetUserName(documentId: widget.documentId),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: updateUser,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                      ElevatedButton(
                          onPressed: deleteUser,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          )),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
