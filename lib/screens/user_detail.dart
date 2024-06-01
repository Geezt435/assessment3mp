import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserDetailPage extends StatefulWidget {
  final int userId;

  UserDetailPage({required this.userId});

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Map user = {};

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  void _fetchUserDetail() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        user = json.decode(response.body)['data'];
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: user.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text('Name: ${user['first_name']} ${user['last_name']}'),
                  Text('Email: ${user['email']}'),
                  Image.network(user['avatar']),
                ],
              ),
            ),
    );
  }
}
