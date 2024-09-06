import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/source/screen/otp_input_field.dart';
import 'package:sample_app/source/screen/phone_number_input_field.dart';
import 'package:sample_app/source/utils/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: Text(
              'Registration',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 500,
              child: Image.asset("assets/images/woman-jogging.jpg")),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Let\'s get started',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          DotsIndicator(
              dotsCount: 3,
              position: 0,
              decorator: const DotsDecorator(
                size: Size.square(5.0),
                activeColor: AppColors.primaryColor,
              )),
          ElevatedButton(
            onPressed: () {
              //TODO change for the proper routes
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PhoneNumberScreen(),
                ),
              );
            },
            child: const Text(
              'Get Started',
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
