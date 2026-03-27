import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  UserModel? _currentUser;

  @override
  Future<void> sendOtp(String emailOrPhone) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    print('Mock: OTP sent to $emailOrPhone');
  }

  @override
  Future<UserModel> verifyOtp(String emailOrPhone, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // In mock, any 6-digit OTP works
    if (otp.length == 6) {
      _currentUser = UserModel(
        id: 'user_123',
        fullName: 'Chidi Nwosu',
        email: emailOrPhone,
        phone: emailOrPhone.contains('@') ? '08123456789' : emailOrPhone,
        role: UserRole.passenger,
      );
      return _currentUser!;
    } else {
      throw Exception('Invalid OTP');
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = user;
    return _currentUser!;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
  }
}
