import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyager_v01/auth.dart';
import 'package:voyager_v01/pages/map_page.dart';
import 'package:voyager_v01/pages/nearby_places.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/voyager.png',
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 70,
                            icon: const Icon(
                              Icons.map_rounded,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NearByPlacesScreen()),
                              );
                            },
                          ),
                          const Text(
                            'Browse Nearby',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 70,
                            icon: const Icon(
                              Icons.pin_drop_outlined,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample()),
                              );
                            },
                          ),
                          const Text(
                            'Search on Map',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(child: Text("Logged in as ${_userUID()}")),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF6000),
                    fixedSize: Size(160, 40)),
                onPressed: signOut,
                child: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> signOut() async {
  await Auth().signOut();
}

final User? user = Auth().currentUser;

String _userUID() {
  return user?.email ?? "User e-mail";
}
