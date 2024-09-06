import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/source/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitState());

  String? verficationId;

  //
  void sendOtp(String phoneNumber) async {
    emit(AuthLoadingState());

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        verficationId = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        //signInWithPhone(credential);
      },
      verificationFailed: (e) {
        emit(AuthErrorState(e.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        //????
        verficationId = verificationId;
      },
    );
  }

  void verifyOtp(String otpCode) async {
    emit(AuthLoadingState());

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verficationId!,
      smsCode: otpCode,
    );
    signInWithPhone(phoneAuthCredential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (userCredential.user != null) {
        emit(AuthLoggedInState(user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
