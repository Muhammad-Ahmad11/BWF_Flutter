import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  const GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //grab the data from the snapshot
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['first name']}' +
              ' '
                  '${data['last name']},' +
              ' '
                  '${data['age']}' +
              ' years old');
        }
        return Text('loading...');
      }),
      future: users.doc(documentId).get(),
    );
  }
}
