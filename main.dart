import 'package:flutter/material.dart';
import 'package:flutter_node_email_sender/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget defaultScreen = Home();

  runApp(MaterialApp(
    theme: ThemeData(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => defaultScreen,
    },
  ));
}
