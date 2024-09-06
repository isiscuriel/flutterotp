import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/source/screen/otp_input_field.dart';
import 'package:sample_app/source/utils/colors.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 90.0),
              child: Text(
                'Registration',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            DotsIndicator(
                dotsCount: 3,
                position: 1,
                decorator: const DotsDecorator(
                  size: Size.square(5.0),
                  activeColor: AppColors.primaryColor,
                )),
            SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.asset(
                    "assets/images/arab-woman-sitting-on-stool.png")),
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'We will send a code (via SMS text\nmessage) to your phone number',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //TODO add proper routes
                //TODO add logic to send sms code
                //TODO add logic to navigate to otp screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OtpScreen(),
                  ),
                );
              },
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
