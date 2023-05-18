import 'package:aws_cognito_app/Data/Services/AWS/aws_cognito.dart';
import 'package:aws_cognito_app/Presentation/Screens/Login/UI/validation_code.dart';
import 'package:aws_cognito_app/Presentation/Screens/Login/Widgets/input_field.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var UsernameController = TextEditingController();

  var EmailController = TextEditingController();
  
  var PhoneController = TextEditingController();
  var _dropdownvalue;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                    controller: UsernameController,
                    isPassword: false,
                    labelTxt: 'Username',
                    icon: Icons.person),
                SizedBox(height: 10,),

                InputField(
                    controller: EmailController,
                    isPassword: false,
                    labelTxt: 'Email',
                    icon: Icons.email),
                SizedBox(height: 10,),
                Container(
                  color: Colors.purple[100],
                  child: DropdownButton<String>(
                    isExpanded: true,
                      items: [
                        DropdownMenuItem(child: Row(children: [Icon(Icons.male), SizedBox(width: 5,),Text('Male')],), value: 'Male',),
                        DropdownMenuItem(child: Row(children: [Icon(Icons.female), SizedBox(width: 5,),Text('Female')],), value: 'Female',),
                      ],
                      value: _dropdownvalue,
                      onChanged: dropdownCallback,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                  ),
                ),
                SizedBox(height: 10,),

                InputField(
                    controller: PhoneController,
                    isPassword: false,
                    labelTxt: 'Phone Number',
                    icon: Icons.phone_android),
                SizedBox(height: 40,),

                Container(
                  width: 100,
                  height: 50,
                  color: Colors.red,
                  child: TextButton(
                      onPressed: () {
                        AWSServices().signup(
                            UsernameController.text, EmailController.text,
                            _dropdownvalue.toString(), PhoneController.text);
                        if(signup_state == 1){
                          Useremail = EmailController.text;
                          showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                title: Text('User Signed up successfuly'),
                                content: Text('Please check your email for the verified code'),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ValidationScreen()));
                                  }, child: Text('OK'))
                                ],
                              )
                          );
                        }
                        else if(signup_state == 2){

                        }
                      },
                      child: Text(
                          'Signup',
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
        ),
      ),
    );
  }

  void dropdownCallback(String? selectedItem){
    if(selectedItem is String){
      setState((){
        _dropdownvalue = selectedItem;
      });
    }
  }
}
