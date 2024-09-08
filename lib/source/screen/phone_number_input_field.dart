import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/source/bloc/auth_cubit.dart';
import 'package:sample_app/source/bloc/auth_state.dart';
import 'package:sample_app/source/screen/otp_input_field.dart';
import 'package:sample_app/source/utils/colors.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
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
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeSentState) {
                  //TODO add proper routes
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtpScreen()));
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    //Note will only support USA phone numbers for now
                    String phoneNumber = "+1${phoneController.text}";
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                  },
                  child: const Text('Send Message'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
