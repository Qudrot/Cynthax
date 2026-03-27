import 'package:equatable/equatable.dart';
import '../../domain/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SendOtpRequested extends AuthEvent {
  final String emailOrPhone;
  const SendOtpRequested(this.emailOrPhone);
  @override
  List<Object> get props => [emailOrPhone];
}

class VerifyOtpRequested extends AuthEvent {
  final String emailOrPhone;
  final String otp;
  const VerifyOtpRequested(this.emailOrPhone, this.otp);
  @override
  List<Object> get props => [emailOrPhone, otp];
}

class UpdateProfileRequested extends AuthEvent {
  final UserModel user;
  const UpdateProfileRequested(this.user);
  @override
  List<Object> get props => [user];
}

class LogoutRequested extends AuthEvent {}
