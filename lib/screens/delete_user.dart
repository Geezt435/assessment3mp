import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteUserPage extends StatefulWidget {
  final int userId;

  DeleteUserPage({required this.userId});

  @override
  _DeleteUserPageState createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  bool isLoading = false;

  void _deleteUser() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.delete(
      Uri.parse('https://reqres.in/api/users/${widget.userId}'),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 204) {
      Navigator.pop(context, true); // Mengirim true jika berhasil dihapus
    } else {
      // Tampilkan pesan kesalahan jika penghapusan gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _deleteUser,
                child: Text('Delete User'),
              ),
      ),
    );
  }
}
