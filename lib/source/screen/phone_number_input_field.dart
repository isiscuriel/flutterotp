import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/source/bloc/auth_cubit.dart';
import 'package:sample_app/source/bloc/auth_state.dart';
import 'package:sample_app/source/screen/otp_input_field.dart';
import 'package:sample_app/source/utils/colors.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Check the available width and height in constraints
      double availableWidth = constraints.maxWidth;
      double availableHeight = constraints.maxHeight;
      return SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: const Text(
                'Registration',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
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
                height: 250,
                child: Image.asset(
                    "assets/images/arab-woman-sitting-on-stool.png")),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'We will send a code (via SMS text\nmessage) to your phone number',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey.shade100,
                height: 50,
                width: availableWidth * 0.70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    //TODO readd formater when can handle seperating
                    //inputFormatters: [MaskedInputFormatter('(###) ###-####')],
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: phoneController,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                return SizedBox(
                  height: 50,
                  width: availableWidth * 0.70,
                  child: ElevatedButton(
                    onPressed: () {
                      //Note will only support USA phone numbers for now
                      String phoneNumber = "+1${phoneController.text}";
                      BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                    },
                    child: const Text('Send Message'),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }));
  }
}
