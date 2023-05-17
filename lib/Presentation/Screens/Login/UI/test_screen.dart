import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
                'Welcome to the app',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            width: 100,
            height: 50,
              color: Colors.red,
              child: TextButton(
                  onPressed: (){},
                  child: Text(
                      'Logout',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),
                  )
              )
          ),
        ],
      ),
    );
  }
}
