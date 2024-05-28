import 'package:chatapp/models/FirebaseHelper.dart';
import 'package:chatapp/models/UserModel.dart';
import 'package:chatapp/pages/CompleteProfile.dart';
import 'package:chatapp/pages/HomePage.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:chatapp/pages/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

void main() async {
  if (kIsWeb) {
    //print("in web");
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB6HbRMIAm9wBEbNFec3sA_Xi8tPHaPBmc",
            authDomain: "chat-app-5780e.firebaseapp.com",
            projectId: "chat-app-5780e",
            storageBucket: "chat-app-5780e.appspot.com",
            messagingSenderId: "105921113706",
            appId: "1:105921113706:web:a768a6164106c8efcca413",
            measurementId: "G-3919TG4KNZ"));
  } else {
    await Firebase.initializeApp();
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // Logged In
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    if (thisUserModel != null) {
      runApp(
          MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    } else {
      runApp(MyApp());
    }
  } else {
    // Not logged in
    runApp(MyApp());
  }
}

// Not Logged In
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}
