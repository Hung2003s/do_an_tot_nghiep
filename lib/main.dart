import 'package:do_an_tot_nghiep/ui/homepage/home_page.dart';
import 'package:do_an_tot_nghiep/ui/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

