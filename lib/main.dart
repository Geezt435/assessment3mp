import 'package:firebase_core/firebase_core.dart';
import 'package:assessment_3_mp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

List<List<String>> getUsers() {
  return users;
}

void addUser(String username, String password) {
  users.add([username, password]);
}

List<List<String>> users = [["admin", "admin"]];