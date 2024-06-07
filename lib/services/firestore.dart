import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of games
  final CollectionReference gamesCollection = FirebaseFirestore.instance.collection('games');
  
  // CREATE: add a new note
  Future<void> addGame(String gamename, String description, String genre, String platform, String releaseDate, String developer, String rating) {
    return gamesCollection.add({
      'gamename': gamename,
      'description': description,
      'genre': genre,
      'platform': platform,
      'releaseDate': releaseDate,
      'developer': developer,
      'rating': rating,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get games from database order by timestamp
  Stream<QuerySnapshot> getGames() {
    final gameStream = gamesCollection.orderBy('timestamp', descending: true).snapshots();

    return gameStream;
  }

  // READ; get games from database order by rating
  Stream<QuerySnapshot> getGamesByRating() {
    final gameStream = gamesCollection.orderBy('rating', descending: true).snapshots();

    return gameStream;
  }

  // UPDATE: update a games given a document id
  Future<void> updateGame(String docId, String gamename, String description, String genre, String platform, String releaseDate, String developer, String rating) {
    return gamesCollection.doc(docId).update({
      'gamename': gamename,
      'description': description,
      'genre': genre,
      'platform': platform,
      'releaseDate': releaseDate,
      'developer': developer,
      'rating': rating,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete a games given a document id
  Future<void> deleteGame(String docId) {
    return gamesCollection.doc(docId).delete();
  }

  // GET: get a single game given a document id
  Future<DocumentSnapshot> getGame(String docId) {
    return gamesCollection.doc(docId).get();
  }

  // GET: get a single game given a document id, and specify the fields to get, output is string
  Future<String> getGameField(String docId, String field) async {
    DocumentSnapshot game = await gamesCollection.doc(docId).get();
    Map<String, dynamic> gameData = game.data() as Map<String, dynamic>;
    return gameData[field];
  }
}