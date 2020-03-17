
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pro4/utils/firebase_auth.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.amber,
      body:  Center(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Container(
                    width: 250,
                    height: 50,
                    child: RaisedButton(
                    
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google,color: Colors.redAccent),
                            SizedBox(width:10.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.black,fontSize: 18.0),
                            ),

                        ],
                      ),
                      onPressed: () async{
                        await auth.loginWithGoogle();
                        
                      }
                    ),
                  ),
                ],
            ),
      ),
        );
  }
}

