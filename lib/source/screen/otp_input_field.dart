import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/source/bloc/otp_bloc.dart';
import 'package:sample_app/source/screen/welcome.dart';
import 'package:sample_app/source/utils/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: const OtpForm(),
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          // Handle successful OTP verification
        } else if (state is OtpFailure) {
          // Handle OTP verification failure
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
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
                    height: 250,
                    child: SvgPicture.asset("assets/images/womanandchild.svg")),
                const Text(
                  'Verfication',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'You will get a six-digit verfication code\n that is time-limited.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: PinFieldAutoFill(
                    textInputAction: TextInputAction.done,
                    autoFocus: true,
                    decoration: BoxLooseDecoration(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400, //300
                          color: Colors.white70,
                          fontFamily: 'lato'),
                      radius: const Radius.circular(8),
                      strokeColorBuilder: const FixedColorBuilder(
                        Color.fromRGBO(255, 200, 49, 0.45),
                      ),
                    ),
                    codeLength: 6,
                    onCodeChanged: (code) {},
                    onCodeSubmitted: (val) {},
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    //TODO if verfied then navigated
                    //TODO add proper routes
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
