import '../models/user_model.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String emailOrPhone);
  Future<UserModel> verifyOtp(String emailOrPhone, String otp);
  Future<UserModel> updateProfile(UserModel user);
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
}
