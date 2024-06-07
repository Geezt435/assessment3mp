import 'package:flutter/material.dart';
import 'list_recommended_games.dart';
import 'add_data.dart';
import 'data_list.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Home Page',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Tambahkan tombol untuk menambahkan data
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddGamePage()),
                );
              },
              child: const Text(
                'Add New Game Data',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // Tambahkan tombol untuk melihat data
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamesListPage()),
                );
              },
              child: const Text(
                'View Games',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // Tambahkan tombol games recommended
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamesRecommendedPage()),
                );
              },
              child: const Text(
                'Games Recommended',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),

            // Tambahkan tombol logout
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
