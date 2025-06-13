import 'package:flutter/material.dart';

import '../widgets/HomeAppBar.dart';


class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
            SizedBox(height: 20),
            Text(
              'WELCOME TO',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            Text(
              'GREEN FARM',
              style: TextStyle(fontSize: 32, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text('Forget Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Email or Phone number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/GetCodePage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}