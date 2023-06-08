import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:voyager_v01/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VoyagerApp());
}

class VoyagerApp extends StatelessWidget {
  const VoyagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WidgetTree());
  }
}
