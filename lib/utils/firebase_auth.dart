import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider with ChangeNotifier{
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  String id;

  Future<void> logOut() async{
    try {
      await deleteIdPreference();
      await _auth.signOut();
      await googleSignIn.signOut();
      print("Success Logout");  
    } catch (e) {
      print("logout failed");
    }
  }

  Future<bool> loginWithGoogle() async {
      try {
        GoogleSignInAccount account = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        final Firestore firestore = Firestore.instance;

        if(account == null )
          return false;
        AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        );
        final AuthResult res = await _auth.signInWithCredential(credential);
        if(res.user == null)
          return false;
        
        var data = await firestore.collection("users").document(await this.getId()).get();

        if(!data.exists){
          await firestore.collection("users").document(await this.getId()).setData({
            "name": res.user.displayName,
            "email":res.user.email,
            "imagr_uri":res.user.photoUrl
          });
        }
        
        print("Login Succesfull");
        setId(res.user.uid);
        print('id save to memory.');
        return true;
      } catch (e) {
        print("Error logging with google");
        return false;
      }
    }

    Future<void> setId(String id) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("id", id);
      notifyListeners();
    }

    Future<String> getId() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      this.id = await preferences.getString("id");
      notifyListeners();
      return this.id;
    }

    Future<void> deleteIdPreference() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      notifyListeners();
    }
}
