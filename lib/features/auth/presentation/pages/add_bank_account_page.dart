import 'package:flutter/material.dart';
import '../../data/repositories/real_auth_repository.dart'; // Ensure path is correct

class AddBankAccountPage extends StatefulWidget {
  final RealAuthRepository authRepository; // Add this parameter
  
  const AddBankAccountPage({
    super.key, 
    required this.authRepository, // Update constructor
  });

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bank Account')),
      body: const Center(child: Text('Bank details logic goes here')),
    );
  }
}