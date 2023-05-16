import 'package:aws_cognito_app/Data/Services/AWS/aws_cognito.dart';
import 'package:aws_cognito_app/constants.dart';
import 'package:flutter/material.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  var CodeController = TextEditingController();

  var NewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validation Screen'),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.green,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[800],
                ),
                width: 350.0,
                child: TextFormField(
                  controller: CodeController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,

                  decoration: InputDecoration(
                    labelText: 'Code',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {  },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 50,),
            Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[800],
                ),
                width: 350.0,
                child: TextFormField(
                  controller: NewPassController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,

                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {  },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                )),
            SizedBox(height: 60,),
            Container(
              color: Colors.yellow,
                width: 150,
                height: 70,
                child: TextButton(
                    onPressed: (){
                      AWSServices().forceChangePassword('ahmedglal@protonmail.com',
                          CodeController.text,
                          NewPassController.text
                      );
                    },
                    child: Text(
                        'Submit',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
