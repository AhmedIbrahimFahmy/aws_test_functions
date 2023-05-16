import 'package:aws_cognito_app/Data/Services/AWS/aws_cognito.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 100,
              color: Colors.red,
              child: TextButton(
                  onPressed: (){
                      AWSServices().signup();
                  },
                  child: Text(
                      'Click to add user',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
