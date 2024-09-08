import 'package:banha4_firebase/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  @override
  void initState() {
    _user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _save(),
                  child: Text('Save data in realtime')),
              ElevatedButton(
                  onPressed: () => _view(),
                  child: Text('View data from realtime')),
              Divider(),
              ElevatedButton(
                  onPressed: () => _saveFirestore(),
                  child: Text('Save data in firestore')),
              ElevatedButton(
                  onPressed: () => _viewFirestore(),
                  child: Text('View data from firestore')),
            ],
          ),
        ),
      ),
    );
  }

  _save() {
    AppUser appUser = AppUser('Marwa', '01659498744', _user!.email!, 'cairo');
    _dbRef.child('users').child(_user!.uid).set(appUser.toMap()).then(
          (value) => print('Done'),
        );
  }

  _view() {
    _dbRef.child('users').child(_user!.uid).onValue.listen(
      (event) {
        // print(event.snapshot.value);
        // print(event.snapshot.value.runtimeType);
        Map<String, dynamic> data =
            Map.from(event.snapshot.value as Map<Object?, Object?>);
        AppUser appUser = AppUser.fromMap(data);
        print(appUser.name);
      },
    );
  }

  _saveFirestore() {
    AppUser appUser = AppUser('Marwa', '01659498744', _user!.email!, 'cairo');
    _firestore.collection('users').doc(_user!.uid).set(appUser.toMap()).then(
      (value) {
        print('Done');
      },
    );
  }

  _viewFirestore() {
    _firestore.collection('users').doc(_user!.uid).get().then(
      (value) {
        AppUser _appUser =
            AppUser.fromMap(value.data() as Map<String, dynamic>);
        print(_appUser.name);
      },
    );
  }
}
