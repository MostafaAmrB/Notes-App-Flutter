// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todolist_final/screens/home_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(22),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    'What Todoo!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color(0xFF211551),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'What todoo, is a simple app to list \nyour task and to check when finished.',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                      color: Color(0xFF86829D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.of(context).pushNamed(HomePage.RouteName),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF7349FE),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
