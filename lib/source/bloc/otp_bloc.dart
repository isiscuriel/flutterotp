import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OtpEvent {}

class OtpCodeSubmittedEvent extends OtpEvent {
  final String otpCode;
  final String verificationId;

  OtpCodeSubmittedEvent(this.otpCode, this.verificationId);
}

class OtpState {}

class OtpInital extends OtpState {}

class OtpOnLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailure extends OtpState {
  final String errorMessage;
  OtpFailure(this.errorMessage);
}

class OtpLoggedInState extends OtpState {
  final User user;
  OtpLoggedInState(this.user);
}

class OtpLoggedOutState extends OtpState {}

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInital());

  Stream<OtpState> mapEventToState(OtpEvent event) async* {
    if (event is OtpCodeSubmittedEvent) {
      yield OtpOnLoading();
      try {
        await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: event.verificationId, smsCode: event.otpCode),
        );
      } catch (e) {
        yield OtpFailure(e.toString());
      }
    }
  }
}
