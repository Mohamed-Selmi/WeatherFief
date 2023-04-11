import 'package:app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:app/views/login_view.dart';
import 'package:app/views/weather_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const RegisterView(),
    ),
    );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

   Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder(
        future:Firebase.initializeApp(
             options: DefaultFirebaseOptions.currentPlatform,),
        builder: (context, snapshot) {
          switch(snapshot.connectionState)
          {
            
            case ConnectionState.done:
            
              print(FirebaseAuth.instance.currentUser);
              return const Text("done");
            default:
             return const Text("Loading...");
          }
          
        },
        
      ),
    );
  }
}