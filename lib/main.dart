import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro4/ui/home.dart';
import 'package:pro4/ui/login.dart';
import 'package:pro4/ui/splash.dart';
import 'package:pro4/utils/firebase_auth.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hobby Hub",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Roboto Mono'
      ),
      home: ChangeNotifierProvider<AuthProvider>(
        builder: (context)=>AuthProvider(),
        child: MainScreen(),
        ),
    );
    
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
          print("main connectionState: "+snapshot.connectionState.toString());
          if(snapshot.connectionState == ConnectionState.waiting)
            return Splash();
          if(!snapshot.hasData || snapshot.data == null)
            return LoginPage();
          return HomePage();
      },
    );
  }
}



