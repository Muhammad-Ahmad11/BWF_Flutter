import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DisplayScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
        backgroundColor: Color.fromARGB(255, 103, 80, 164),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Name'),
                subtitle: Text(data['Name'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Email'),
                subtitle: Text(data['Email'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Password'),
                subtitle: Text(data['Password'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Age'),
                subtitle: Text(data['Age'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Phone Number'),
                subtitle: Text(data['Phone Number'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Date of Birth'),
                subtitle: Text(data['Date of Birth'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Preferred Time'),
                subtitle: Text(data['Preferred Time'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Gender'),
                subtitle: Text(data['Gender'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Address'),
                subtitle: Text(data['Address'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Bio'),
                subtitle: Text(data['Bio'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Country'),
                subtitle: Text(data['Country'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Marital Status'),
                subtitle: Text(data['Marital Status'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Newsletter Subscription'),
                subtitle:
                    Text(data['Newsletter'] ? 'Subscribed' : 'Not Subscribed'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Satisfaction Level'),
                subtitle: Text(data['Satisfaction'].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
