import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/bank_model.dart';

class AddBankAccountPage extends StatefulWidget {
  final AuthRepository authRepository;

  const AddBankAccountPage({super.key, required this.authRepository});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  final _accountNumberController = TextEditingController();
  List<dynamic> _banks = [];
  dynamic _selectedBank;
  bool _isLoading = false;
  bool _isVerifying = false;
  String? _accountName;

  @override
  void initState() {
    super.initState();
    _fetchBanks();
  }

  Future<void> _fetchBanks() async {
    setState(() => _isLoading = true);
    try {
      final banks = await widget.authRepository.getBanks();
      setState(() {
        _banks = banks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching banks: $e')),
      );
    }
  }

  Future<void> _verifyAccount() async {
    if (_selectedBank == null || _accountNumberController.text.length != 10) return;

    setState(() {
      _isVerifying = true;
      _accountName = null;
    });

    try {
      final result = await widget.authRepository.verifyBankAccount(
        _selectedBank['code'],
        _accountNumberController.text,
      );
      setState(() {
        _isVerifying = false;
        if (result != null) {
          _accountName = result['account_name'];
        }
      });
    } catch (e) {
      setState(() => _isVerifying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Add Bank Account',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Name',
                    style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        hint: const Text('Select Bank'),
                        value: _selectedBank,
                        items: _banks.map((bank) {
                          return DropdownMenuItem<dynamic>(
                            value: bank,
                            child: Text(bank['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedBank = value);
                          if (_accountNumberController.text.length == 10) {
                            _verifyAccount();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Account Number',
                    style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _accountNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: '10 digits',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 10) {
                        _verifyAccount();
                      } else {
                        setState(() => _accountName = null);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (_isVerifying)
                    const Center(child: LinearProgressIndicator())
                  else if (_accountName != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            _accountName!,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_accountName != null) ? () => Navigator.pop(context) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: BorderRadius.circular(12),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: Text(
                        'Finish',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
