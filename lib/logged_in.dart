import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/google_sign_in.dart';

final user = FirebaseAuth.instance.currentUser!;

class FirstPage extends StatefulWidget {
  @override
  FirstState createState() => FirstState();
}

class FirstState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Logged In',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: 32),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Name: ' + user.displayName!,
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text(
              'LOGOUT',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ))
      ],
    ));
  }
}
