import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/Provider/provider.dart';

class OrganizationRegistrationScreen extends StatefulWidget {
  @override
  _OrganizationRegistrationScreenState createState() => _OrganizationRegistrationScreenState();
}

class _OrganizationRegistrationScreenState extends State<OrganizationRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _organizationDetails = {};
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Organization Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the organization name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _organizationDetails['name'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _organizationDetails['location'] = value!;
                },
              ),
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                      _organizationDetails['date'] = picked.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Save Organization'),
                value: _organizationDetails['save'] == 'true',
                onChanged: (value) {
                  setState(() {
                    _organizationDetails['save'] = value.toString();
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (_organizationDetails['save'] == 'true') {
                      Provider.of<RegistrationProvider>(context, listen: false)
                          .addOrganization(_organizationDetails);
                    }

                    Navigator.pop(context);
                  }
                },
                child: const Text('Save and Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
