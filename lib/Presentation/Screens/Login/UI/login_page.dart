import 'package:aws_cognito_app/Presentation/Screens/Login/UI/change_password.dart';
import 'package:aws_cognito_app/Presentation/Screens/Login/UI/test_screen.dart';
import 'package:aws_cognito_app/constants.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Services/AWS/aws_cognito.dart';
import '../../../Components/app_bar.dart';
import '../../../Components/primary_btn.dart';
import '../../../Components/spacer.dart';
import '../../../Declarations/Constants/Images/image_files.dart';
import '../../../Declarations/Constants/constants.dart';
import '../Widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(appBarTitle: widget.title),
      body: Padding(
        padding: kHPadding,
        child: SingleChildScrollView(
          child: Column(children: [
            Image.asset(
              loginImages[0],
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
            InputField(
                controller: emailController,
                isPassword: false,
                labelTxt: 'Email',
                icon: Icons.person),
            HeightSpacer(myHeight: kSpacing),
            InputField(
                controller: passwordController,
                isPassword: true,
                labelTxt: 'Password',
                icon: Icons.lock),
            HeightSpacer(myHeight: kSpacing),
            Container(
              width: 350,
              color: Colors.purple,
              child: TextButton(

                  child: Text('Login', style: TextStyle(fontSize: 30),),
                  onPressed: () {
                    login_state = -1;
                    login(emailController.text, passwordController.text).then((value){
                      if(login_state == 1){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => WelcomeScreen())
                        );
                      }
                      else
                        if(login_state == 2){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChangePassword())
                          );
                        }
                        else
                          if(login_state == 3){
                            showDialog(context: context, builder: (context) =>
                                AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Invalid Username or Password'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: Text('OK'))
                                  ],
                                )
                            );
                          }
                    });
                  }
              ),
            )
          ]),
        ),
      ),
    );
  }

  login(String email, String password) =>
      AWSServices().createInitialRecord(email, password);
}
