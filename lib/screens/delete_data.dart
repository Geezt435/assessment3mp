import 'package:assessment_3_mp/services/firestore.dart';
import 'package:flutter/material.dart';

class DeleteGamePage extends StatefulWidget {
  final String documentId;
  final String gamename;

  DeleteGamePage({required this.documentId, required this.gamename});

  @override
  _DeleteGamePageState createState() => _DeleteGamePageState();
}

class _DeleteGamePageState extends State<DeleteGamePage> {
  final FirestoreService firestoreService = FirestoreService();

  bool isLoading = false;

  void _deleteGame() async {
    setState(() {
      isLoading = true;
    });

    // Delete the game from the Firestore database
    firestoreService.deleteGame(widget.documentId);

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context, true); // Mengirim true jika berhasil ditambahkan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Deletion Confirmation'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Deleted Game will be permanently removed from the database."),
            Text("Are you sure you want to delete ${widget.gamename}?"),
            ElevatedButton(
              onPressed: _deleteGame,
              child: Text('Confirm Deletion of ${widget.gamename}'),
            ),
          ]
        ),
      )
    );
  }
}
