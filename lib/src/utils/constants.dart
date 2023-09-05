import 'package:get/get_utils/src/platform/platform.dart';

class AppKeys {
  static const String authToken = 'AuthToken';
  static const String uRole = 'UserRole';
  static const String uId = 'uId';
}

class ErrorStrings {
  static const String someThingWentWrong = 'some thing went wrong';
  static const String nameReq = 'Name is Required';
  static const String emailReq = 'Email is Required';
  static const String emailInvalid = 'Email is Invalid';
  static const String passwordReq = 'Password is Required';
  static const String passwordContain =
      'contain Capital, small letter & Number & Special';
  static const String notEmpty = 'not empty';
  static const String passwordStrong = 'Password is not Strong';
  static const String acceptTermAndCondition = 'Accept terms and condition';
}

final kGoogleApiKey = GetPlatform.isIOS
    ? 'AIzaSyD3VlXnsbuhUopnmUbTcj7vUj9scxtZZK8'
    : "AIzaSyD3VlXnsbuhUopnmUbTcj7vUj9scxtZZK8";
