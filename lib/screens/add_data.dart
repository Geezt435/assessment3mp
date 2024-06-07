import 'package:assessment_3_mp/services/firestore.dart';
import 'package:flutter/material.dart';

class AddGamePage extends StatefulWidget {
  @override
  _AddGamePageState createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  double _ratingValue = 1;

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _gamenameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();

  void _addGame() async {
    String rating = '${_ratingValue.toInt()}/10';

    // Add the new user to the Firestore database
    firestoreService.addGame(
      _gamenameController.text,
      _descriptionController.text,
      _genreController.text,
      _platformController.text,
      _releaseDateController.text,
      _developerController.text,
      rating,
    );

    // Clear the text fields
    _gamenameController.clear();
    _descriptionController.clear();
    _genreController.clear();
    _platformController.clear();
    _releaseDateController.clear();
    _developerController.clear();

    Navigator.pop(context, true); // Mengirim true jika berhasil ditambahkan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Game Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _gamenameController,
              decoration: const InputDecoration(labelText: 'Game Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _platformController,
              decoration: const InputDecoration(labelText: 'Platform'),
            ),
            TextFormField(
              controller: _releaseDateController,
              decoration: const InputDecoration(labelText: 'Release Date'),
              onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String formattedDate = pickedDate.toString().split(' ')[0];
                _releaseDateController.text = formattedDate;
              }
              },
            ),
            TextField(
              controller: _developerController,
              decoration: const InputDecoration(labelText: 'Developer'),
            ),
            Slider(
              value: _ratingValue,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (double value) {
                setState(() {
                  _ratingValue = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addGame,
              child: const Text('Add Game Data'),
            ),
          ],
        ),
      ),
    );
  }
}
