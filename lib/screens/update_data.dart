import 'package:assessment_3_mp/services/firestore.dart';
import 'package:flutter/material.dart';

class UpdateGamePage extends StatefulWidget {
  final String documentId;
  final String gamename;
  final String description;
  final String genre;
  final String platform;
  final String releaseDate;
  final String developer;

  UpdateGamePage({required this.documentId, required this.gamename, required this.description, required this.genre, required this.platform, required this.releaseDate, required this.developer});

  @override
  _UpdateGamePageState createState() => _UpdateGamePageState();
}

class _UpdateGamePageState extends State<UpdateGamePage> {

  // Rating value
  double _ratingValue = 1;

  // Firestore service
  final FirestoreService firestoreService = FirestoreService();

  // Initialize the text fields with the current data
  @override
  void initState() {
    super.initState();
    _gamenameController.text = widget.gamename;
    _descriptionController.text = widget.description;
    _genreController.text = widget.genre;
    _platformController.text = widget.platform;
    _releaseDateController.text = widget.releaseDate;
    _developerController.text = widget.developer;
  }

  // Text controllers for the text fields
  final TextEditingController _gamenameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();

  // Update the current data from Firestore
  void _updateGame() async {
    String rating = '${_ratingValue.toInt()}/10';

    // Add the new user to the Firestore database
    firestoreService.updateGame(
      widget.documentId,
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
        title: const Text('Update Game Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _gamenameController,
              decoration: const InputDecoration(labelText: 'Game Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            TextFormField(
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
            TextFormField(
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
              onPressed: _updateGame,
              child: const Text('Add Game Data'),
            ),
          ],
        ),
      ),
    );
  }
}
