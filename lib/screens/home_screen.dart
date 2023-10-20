import 'package:bloc_tutorial/screens/products_screen.dart';
import 'package:bloc_tutorial/screens/users_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsScreen(),
                    ));
              },
              child: Text('Get Products using bloc')),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UsersView(),
                    ));
              },
              child: Text('Get users using cubit')),
        ],
      )),
    );
  }
}
