import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/controllers/home_controller.dart';
import 'package:flutter_movie_list/src/pages/info_page.dart';

import 'src/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TVMaze',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => HomePage(title: 'Séries e Filmes'),
      //   '/home': (context) =>
      //       InfoPage(title: 'Filme tal' /*$.name.toString()*/),
      //   // '/home/info':(context) => InfoPage(title: 'Filme tal' /*$.name.toString()*/),
      // },
      home: HomePage(title: 'Séries e Filmes'),
    );
  }
}
