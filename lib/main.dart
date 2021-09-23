import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:placeholder/authentication/login.dart';
import 'package:placeholder/services/alternateloading.dart';
import 'package:placeholder/services/dialogherlper.dart';
import 'package:placeholder/services/error.dart';
import 'package:placeholder/users/list.dart';

import 'authentication/password.dart';
import 'authentication/register.dart';

void main() {
  runApp(MaterialApp(
      title: "Chess Clock",
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => Register(),
        'password': (context) => Password(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.white70,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
            headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.white70),
            headline3: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue)
        ),
      )));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late User? user ;
    final Future<FirebaseApp> initialisation = Firebase.initializeApp();
    return WillPopScope(
      child: FutureBuilder(
          future: initialisation,
          builder: (context, snapshot)
          {
            if(snapshot.hasError)
              Navigator.of(context).pushNamed('error');
            if(snapshot.connectionState==ConnectionState.done)
            {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot)
                {
                  if(snapshot.connectionState== ConnectionState.active)
                  {
                    user =  snapshot.data as  User?;
                    if (user == null ) {
                      return LogIn();
                    } else {
                      return Listtile() ;
                    }
                  }
                  return Alternateloading();
                },
              );
            }
            return Errors();
          }
      ),
      onWillPop: () async
      {
        return await DialogHelper.exit(context);
      },
    );
  }
}