import 'package:flutter/material.dart';
import 'package:sample_app/source/navigation/get_started.dart';
import 'package:sample_app/source/screen/otp_input_field.dart';
import 'package:sample_app/source/screen/phone_number_input_field.dart';
import 'package:sample_app/source/screen/welcome.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/otp': (context) => const OtpScreen(),
  '/': (context) => const WelcomeScreen(),
  '/phone': (context) => const PhoneNumberScreen(),
  '/start': (context) => const GetStartedScreen()
};
