import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/source/bloc/auth_cubit.dart';
import 'package:sample_app/source/bloc/auth_state.dart';
import 'package:sample_app/source/screen/welcome.dart';
import 'package:sample_app/source/utils/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpForm();
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 90.0),
                child: Text(
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: SvgPicture.asset("assets/images/womanandchild.svg")),
              const Text(
                'Verification',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You will get a six-digit verfication code\n that is time-limited.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: PinFieldAutoFill(
                  textInputAction: TextInputAction.done,
                  autoFocus: true,
                  decoration: BoxLooseDecoration(
                    bgColorBuilder: const FixedColorBuilder(
                      Color.fromRGBO(245, 245, 245, 1),
                    ),
                    textStyle: const TextStyle(
                        fontSize: 20, //300
                        color: AppColors.blackColor,
                        fontFamily: 'lato'),
                    radius: const Radius.circular(8),
                    strokeColorBuilder: const FixedColorBuilder(
                      Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  controller: otpController,
                  codeLength: 6,
                  onCodeChanged: (code) {},
                  onCodeSubmitted: (val) {},
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 16),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      //TODO add proper routes

                      BlocProvider.of<AuthCubit>(context)
                          .verifyOtp(otpController.text);
                    },
                    child: const Text('Verify OTP'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
