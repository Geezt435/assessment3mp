import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserPage extends StatefulWidget {
  final int userId;

  UpdateUserPage({required this.userId});

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/${widget.userId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      _nameController.text = '${data['first_name']} ${data['last_name']}';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user details.')),
      );
    }
  }

  void _updateUser() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.put(
      Uri.parse('https://reqres.in/api/users/${widget.userId}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': _nameController.text,
        'job': _jobController.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated successfully: ${responseData['name']} - ${responseData['job']}')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _jobController,
                    decoration: InputDecoration(labelText: 'Job'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateUser,
                    child: Text('Update User'),
                  ),
                ],
              ),
      ),
    );
  }
}
