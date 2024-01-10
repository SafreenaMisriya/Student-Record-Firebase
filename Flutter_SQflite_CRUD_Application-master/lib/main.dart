import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_10/screen/splash.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options:const FirebaseOptions(
      apiKey:"AIzaSyBkxkKAUCzkH7IvT0ThmaByqsW5jrUQpe8",
     appId: "1:872918508957:web:b4cac826768d415bc87b74",
      messagingSenderId: "872918508957",
       authDomain: "flutter-firebase-8defc.firebaseapp.com",
        storageBucket: "flutter-firebase-8defc.appspot.com",
       projectId:"flutter-firebase-8defc",) );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
    );
  }
}
