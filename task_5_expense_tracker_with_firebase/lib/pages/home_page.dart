import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5_expense_tracker_with_firebase/pages/editListTile.dart';
import 'package:task_5_expense_tracker_with_firebase/read%20data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // list of document IDs
  List<String> docIDs = [];

  //get details
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              //print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        title: Center(
          child: Text(
            user.email!,
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          bool shouldRefresh = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Editlisttile(
                                  documentId: docIDs[index],
                                );
                              },
                            ),
                          );
                          if (shouldRefresh) {
                            await getDocId(); // Wait for the data to be fetched before updating the UI
                            setState(() {
                              docIDs.clear();
                            });
                          }
                        },
                        title: GetUserName(
                          documentId: docIDs[index],
                        ),
                        tileColor: Colors.purple[100],
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
