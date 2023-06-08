import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyager_v01/auth.dart';
import 'package:flutter/material.dart';
import 'package:voyager_v01/main.dart';
import 'package:voyager_v01/pages/dashboard.dart';
import 'package:voyager_v01/pages/map_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text(
      'Profile',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );
  }

  Widget _userUID() {
    return Text(
      user?.email ?? "User e-mail",
      style: TextStyle(fontSize: 22),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffFF6000), fixedSize: Size(200, 60)),
      onPressed: signOut,
      child: const Text(
        'Sign Out',
        style: TextStyle(fontSize: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF6000),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VoyagerApp()),
            );
          },
        ),
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 12,
            ),
            _userUID(),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF6000), fixedSize: Size(200, 60)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: const Text(
                'Go to Main Page',
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
