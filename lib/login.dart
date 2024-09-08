import 'package:banha4_firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _login(context, 'marwa@gmail.com', '123456'),
                child: Text('Login')),
            ElevatedButton(
                onPressed: () =>
                    _register(context, 'marwa@gmail.com', '123456'),
                child: Text('Register')),
          ],
        ),
      ),
    );
  }

  _login(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print('${e.code}  ${e.message}');
    }
  }

  _register(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      print('${e.code}  ${e.message}');
    }
  }
}
