import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro4/utils/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class AccountMain extends StatelessWidget {
  AuthProvider auth;
  
  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthProvider>(context);
    auth.getId();
    return Container(
      child: Column(
        children: <Widget>[
            IconButton(
                  icon: Icon(
                    FontAwesomeIcons.signOutAlt,
                    size: 20.0,
                    color: Colors.blueAccent,
                  ),
                  onPressed: ()async{
                    await auth.logOut();
                    print('Signed out');
                    //Navigator.pop(context);
                  },
                ),
            RaisedButton(
              child: Text("get dad"),
              onPressed: ()async{
                final Firestore firestore = Firestore.instance;

                try {
                 
                  
                } catch (e) {
                  print(e);
                }
              },
            ),
            RaisedButton(
              child: Text("set data"),
              onPressed: ()async{
                final Firestore firestore = Firestore.instance;

                try {
                  print(await auth.getId());
                } catch (e) {
                  
                }
              }
            ),
              
        
        ],
      ),
    );
  }
}
