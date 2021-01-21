import 'package:flutter/material.dart';
import 'package:get_it_done/screens/landingpage.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get it done!',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.grey,
          //textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme,)
      ),
        home: LandingPage(),
      );
  }
}
