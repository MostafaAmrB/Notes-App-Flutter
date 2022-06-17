import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './providers/notes_provider.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider() , ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo List',
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: const Color(0xFF7349FE),
        ),
        home: SplashPage2(),
        routes: {
          TaskPage.RouteName: (_) => TaskPage(),
          HomePage.RouteName: (_) => HomePage(),
          NotePage.RouteName: (_) => NotePage(),
        },
      ),
    );
  }
}
