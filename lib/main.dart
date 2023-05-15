import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyager_v01/pages/map_page.dart';
import 'package:voyager_v01/pages/nearby_places.dart';
import 'package:voyager_v01/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VoyagerApp());
}

class VoyagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Define the categories
    List<Category> categories = [
      Category(name: 'Breakfast', icon: Icons.egg_alt_outlined),
      Category(name: 'Lunch', icon: Icons.fastfood_outlined),
      Category(name: 'Dinner', icon: Icons.local_restaurant_outlined),
      Category(name: 'Tea & Coffee', icon: Icons.coffee_outlined),
      Category(name: 'Pub', icon: Icons.nightlife_outlined),
      Category(name: 'Events', icon: Icons.movie_filter_outlined),
    ];

    return MaterialApp(
      title: 'Categories App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: PageContent(controller: controller, categories: categories),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.controller,
    required this.categories,
  });

  final TextEditingController controller;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15), // Image border
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
          child: Center(
            child: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const WidgetTree()),
                    );
                  },
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        color: Color(0xffFF6000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const NearByPlacesScreen()),
                      );
                    },
                    child: Text(
                      'Nearby Places',
                      style: TextStyle(
                          color: Color(0xffFF6000),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              hintText: 'Where to?',
              fillColor: Color(0xffF1F1F1),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffFF6000),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                categories.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapSample()),
                      );
                    },
                    child: Center(
                      child: CategoryBox(
                        name: categories[index].name,
                        icon: categories[index].icon,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Category class to store the name and icon of a category
class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

// CategoryBox widget to display the category inside a square box with larger icon and font sizes
class CategoryBox extends StatelessWidget {
  final String name;
  final IconData icon;

  CategoryBox({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
