import 'package:flutter/material.dart';
import 'package:where_i_parked_my_car/pages/details_page.dart';
import 'package:where_i_parked_my_car/pages/find_car_page.dart';
import 'package:where_i_parked_my_car/pages/history_page.dart';
import 'package:where_i_parked_my_car/pages/home_page.dart';
import 'package:where_i_parked_my_car/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
      routes: {
        RegisterPage.ROUTE_NAME: (BuildContext context) => RegisterPage(),
        FindCarPage.ROUTE_NAME: (BuildContext context) => FindCarPage(),
        HistoryPage.ROUTE_NAME: (BuildContext context) => HistoryPage(),
        DetailsPage.ROUTE_NAME: (BuildContext context) => DetailsPage(),
      },
    );
  }
}
