import 'package:flutter/material.dart';
import 'display_screen.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
        backgroundColor: Color.fromARGB(255, 103, 80, 164),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => _validateNotEmpty(value, 'Name'),
                onSaved: (value) {
                  _formData['Name'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: (value) {
                  _formData['Email'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => _validateNotEmpty(value, 'Password'),
                onSaved: (value) {
                  _formData['Password'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => _validateNotEmpty(value, 'Age'),
                onSaved: (value) {
                  _formData['Age'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => _validateNotEmpty(value, 'Phone Number'),
                onSaved: (value) {
                  _formData['Phone Number'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                validator: (value) => _validateNotEmpty(value, 'Date of Birth'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                      _formData['Date of Birth'] = _dateController.text;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Preferred Time'),
                readOnly: true,
                validator: (value) =>
                    _validateNotEmpty(value, 'Preferred Time'),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _timeController.text = pickedTime.format(context);
                      _formData['Preferred Time'] = _timeController.text;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                validator: (value) =>
                    value == null ? 'Gender is required' : null,
                onChanged: (value) {
                  setState(() {
                    _formData['Gender'] = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) => _validateNotEmpty(value, 'Address'),
                onSaved: (value) {
                  _formData['Address'] = value;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bio'),
                maxLines: 3,
                validator: (value) => _validateNotEmpty(value, 'Bio'),
                onSaved: (value) {
                  _formData['Bio'] = value;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Country'),
                items: ['Pakistan', 'Canada', 'UK', 'Australia', 'Other']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                validator: (value) =>
                    value == null ? 'Country is required' : null,
                onChanged: (value) {
                  setState(() {
                    _formData['Country'] = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Select Marital Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                title: Text('Single'),
                value: 'Single',
                groupValue: _formData['Marital Status'],
                onChanged: (value) {
                  setState(() {
                    _formData['Marital Status'] = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Married'),
                value: 'Married',
                groupValue: _formData['Marital Status'],
                onChanged: (value) {
                  setState(() {
                    _formData['Marital Status'] = value;
                  });
                },
              ),
              Text('Satisfaction Level'),
              Slider(
                value: (_formData['Satisfaction'] ?? 5.0).toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                label: (_formData['Satisfaction'] ?? 5.0).toString(),
                onChanged: (double value) {
                  setState(() {
                    _formData['Satisfaction'] = value;
                  });
                },
              ),
              SizedBox(height: 10),
              SwitchListTile(
                title: Text('Subscribe to Newsletter'),
                value: _formData['Newsletter'] ?? false,
                onChanged: (bool value) {
                  setState(() {
                    _formData['Newsletter'] = value;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: Text('Accept Terms and Conditions'),
                value: _formData['Terms'] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _formData['Terms'] = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: _formData['Terms'] == false
                    ? Text(
                        'Required',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (_formData['Terms'] == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('You must accept the terms and conditions'),
                        ),
                      );
                      return;
                    }
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayScreen(data: _formData),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
