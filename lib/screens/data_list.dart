import 'package:assessment_3_mp/screens/data_detail.dart';
import 'package:assessment_3_mp/screens/update_data.dart';
import 'package:assessment_3_mp/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'delete_data.dart';

class GamesListPage extends StatefulWidget {
  @override
  _GamesListPageState createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Games List'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getGames(),
          builder: (context, snapshot) {
            // if we have data, get all the documents from the snapshot
            if (snapshot.hasData) {
              List gamesList = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: gamesList.length,
                  itemBuilder: (context, index) {
                    // get each individual document
                    DocumentSnapshot game = gamesList[index];
                    String docId = game.id;

                    // get games from each document
                    Map<String, dynamic> gameData =
                        game.data() as Map<String, dynamic>;
                    String gamename = gameData['gamename'];
                    String description = gameData['description'];
                    String genre = gameData['genre'];
                    String platform = gameData['platform'];
                    String releaseDate = gameData['releaseDate'];
                    String developer = gameData['developer'];

                    // display as list tile
                    return ListTile(
                      title: Text(gamename),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GameDetailPage(documentId: docId),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateGamePage(
                                      documentId: docId,
                                      gamename: gamename,
                                      description: description,
                                      genre: genre,
                                      platform: platform,
                                      releaseDate: releaseDate,
                                      developer: developer),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeleteGamePage(
                                    documentId: docId,
                                    gamename: gamename,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text('No data found'),
              );
            }
          },
        ));
  }
}
