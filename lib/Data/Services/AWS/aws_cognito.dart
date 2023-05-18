import 'dart:async';
import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:aws_cognito_app/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_requests/http_requests.dart';
import 'package:requests/requests.dart';


class AWSServices {
  final userPool = CognitoUserPool(
    '${(dotenv.env['POOL_ID'])}',
    '${(dotenv.env['CLIENT_ID'])}',
  );
  CognitoUserSession? _session;

  Future<void> createInitialRecord(String email, String password) async {
    print('Authenticating user...');

    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    try {
      _session = await cognitoUser.authenticateUser(authDetails);
      print('Login successful.');
      // Save the session token for future use.
      print('ID token: ${_session!.getIdToken().getJwtToken()}');
      print('Access token: ${_session!.getAccessToken().getJwtToken()}');
      print('Refresh token: ${_session!.getRefreshToken()!.getToken()}');
      login_state = 1;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print('New password required. $e');
      login_state = 2;
    } catch (e) {
      print('Error authenticating user. $e');
      login_state = 3;
    }
  }

  Future<void> changePassword(email, oldPassword, newPassword) async {
    print('Authenticating User...');
    print('$email -- $oldPassword -- $newPassword');
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: oldPassword,
    );
    try {
      _session = await cognitoUser.authenticateUser(authDetails);
      bool passwordChanged = false;
      try {
        passwordChanged = await cognitoUser.changePassword(
          oldPassword,
          newPassword,
        );
        print(_session!.getAccessToken().getJwtToken());
        print(_session!.getIdToken().getJwtToken());
        print(_session!.getRefreshToken()!.getToken());
      } catch (e) {
        print(e);
      }
      print(passwordChanged);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print('New password required. $e');
    } catch (e) {
      print('Error authenticating user. $e');
    }
  }


  Future<void> forceChangePassword(email, oldPassword, newPassword) async {
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: oldPassword,
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      try {
        if (e.requiredAttributes!.isEmpty) {
          // No attribute hast to be set
          session =
          await cognitoUser.sendNewPasswordRequiredAnswer(newPassword);
          Changed = true;
        } else {
          // All attributes from the e.requiredAttributes has to be set.
          print(e.requiredAttributes);
          // For example obtain and set the name attribute.
          var attributes = { "name": "Adam Kaminski"};
          session = await cognitoUser.sendNewPasswordRequiredAnswer(
              newPassword, attributes);
          Changed = true;
        }
      } on CognitoUserMfaRequiredException catch (e) {
        // handle SMS_MFA challenge
      } on CognitoUserSelectMfaTypeException catch (e) {
        // handle SELECT_MFA_TYPE challenge
      } on CognitoUserMfaSetupException catch (e) {
        // handle MFA_SETUP challenge
      } on CognitoUserTotpRequiredException catch (e) {
        // handle SOFTWARE_TOKEN_MFA challenge
      } on CognitoUserCustomChallengeException catch (e) {
        // handle CUSTOM_CHALLENGE challenge
      } catch (e) {
        print(e);
      }
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE challenge
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
    } catch (e) {
      print(e);
    }
    print(session!.getAccessToken().getJwtToken());
    print(session.getIdToken().getJwtToken());
    print(session.getRefreshToken()!.getToken());
  }


  Future<void> signup(username, email, gender, phone) async {
    print('Signing up...');

    final url = 'http://AIArt-env.eba-z7jwmmxy.us-east-1.elasticbeanstalk.com/api/aiart/v1/users/signup'; // Replace with the correct URL
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'name': username,
      'email': email,
      'gender': gender,
      'phoneNumber': phone,
    };
    final body = json.encode(data);

    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if(response.statusCode == 201){
      signup_state = 1;
    }
    else{
      signup_state = 2;
    }
    print(response.statusCode);
    print(response.body);
  }
}
