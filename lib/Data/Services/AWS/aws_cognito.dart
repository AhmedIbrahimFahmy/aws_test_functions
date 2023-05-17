import 'dart:async';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:aws_cognito_app/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


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
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print('New password required. $e');
      Change = true;
    } catch (e) {
      print('Error authenticating user. $e');
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
      Change = true;
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
        if(e.requiredAttributes!.isEmpty) {
          // No attribute hast to be set
          session = await cognitoUser.sendNewPasswordRequiredAnswer(newPassword);
        } else {
          // All attributes from the e.requiredAttributes has to be set.
          print(e.requiredAttributes);
          // For example obtain and set the name attribute.
          var attributes = { "name": "Adam Kaminski"};
          session = await cognitoUser.sendNewPasswordRequiredAnswer(newPassword, attributes);
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


  Future<void> signup() async {
    final userAttributes = [
      AttributeArg(name: 'phone_number', value: '+201011111111'),
    ];
    var data;
    try {
      data = await userPool.signUp(
        'af2752001@gmail.com',
        'Ahmed@123456',
        userAttributes: userAttributes,
      );
      print('Signed up successful');
      print(data);
    } catch (e) {
      print(e);
    }
  }
}
