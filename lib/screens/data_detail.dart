import 'package:assessment_3_mp/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameDetailPage extends StatefulWidget {
  final String documentId;

  GameDetailPage({required this.documentId});

  @override
  _GameDetailPageState createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> game = firestoreService.getGame(widget.documentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // get gamename from document
            SizedBox(height: 20),
            Text('Game Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String gamename = gameData['gamename'];
                  return Text(gamename);
                } else {
                  return Text('Loading...');
                }
              },
            ),

            // get genre from document
            SizedBox(height: 20),
            Text('Genre: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String genre = gameData['genre'];
                  return Text(genre);
                } else {
                  return Text('Loading...');
                }
              },
            ),

            // get platform from document
            SizedBox(height: 20),
            Text('Platform: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String platform = gameData['platform'];
                  return Text(platform);
                } else {
                  return Text('Loading...');
                }
              },
            ),

            // get releaseDate from document
            SizedBox(height: 20),
            Text('Release Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String releaseDate = gameData['releaseDate'];
                  return Text(releaseDate);
                } else {
                  return Text('Loading...');
                }
              },
            ),

            // get developer from document
            SizedBox(height: 20),
            Text('Developer: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String developer = gameData['developer'];
                  return Text(developer);
                } else {
                  return Text('Loading...');
                }
              },
            ),

            // get rating from document
            SizedBox(height: 20),
            Text('Rating: ', style: TextStyle(fontWeight: FontWeight.bold)),
            FutureBuilder<DocumentSnapshot>(
              future: game,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get data from document
                  Map<String, dynamic> gameData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String rating = gameData['rating'];
                  return Text(rating);
                } else {
                  return Text('Loading...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
