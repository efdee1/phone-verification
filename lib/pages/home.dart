import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_verify/pages/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/night.jpg'),
                fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            AppBar(
              title: Text('Welcome'),
              actions: [
                IconButton(icon: Icon(Icons.logout),
                    onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=> LoginPage()),
                          (route) => false);
                    }
                )
              ],
            ),
            Center(
              child: Text('End Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton:CircleAvatar(
        child: Icon(Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
