import 'package:aws_cognito_app/Data/Services/AWS/aws_cognito.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  var EmailController = TextEditingController();

  var OldPassController = TextEditingController();

  var NewPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.yellow,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Text(
                  'Change Password',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50,),
              Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey[800],
                  ),
                  width: 350.0,
                  child: TextFormField(
                    controller: EmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 30.0,
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
                    controller: OldPassController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: false,

                    decoration: InputDecoration(
                      labelText: 'Old Password',
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
                      labelText: 'New Password',
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
                  width: 350.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue),
                  child: MaterialButton(
                    onPressed: () {
                      //print(EmailController.text);
                      //print(PassController.text);
                      //Login_Process();
                      //login(EmailController.text, PassController.text);
                      update(EmailController.text, OldPassController.text, NewPassController.text);
                    },
                    child: Text('UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
              SizedBox(height: 300),
            ],
          ),
        ),
      )
    );
  }
  update(String email, String OldPassword, String NewPassword){
    AWSServices().changePassword(email, OldPassword, NewPassword);
  }
}
