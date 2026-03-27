import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class PaymentTransparencyScreen extends StatelessWidget {
  const PaymentTransparencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings & Payments', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Earnings Summary
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                   Text('Available Balance', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('₦45,200', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Today', '₦15,400'),
                      Container(height: 40, width: 1, color: Colors.white.withOpacity(0.3)),
                      _buildSummaryStat('This Week', '₦45,200'),
                    ],
                  ),
                ],
              ),
            ),

            // Payout Action
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.account_balance_wallet),
                label: const Text('Withdraw to Bank'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            
            const SizedBox(height: 16),

            // Transaction History
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildTransactionCard('Trip #NX-2041', 'Chidi Nwosu (Joiner)', 'Nov 12, 08:30 AM', 1800, isEscrow: true),
                          _buildTransactionCard('Trip #NX-2041', 'Seyi Adebayo (Initiator)', 'Nov 12, 08:30 AM', 2200, isEscrow: false),
                          _buildTransactionCard('Platform Payout', 'Bank Transfer', 'Nov 10, 10:00 AM', -25000, isPayout: true),
                          _buildTransactionCard('Trip #NX-1988', 'Aisha Bello (Initiator)', 'Nov 09, 05:45 PM', 3500, isEscrow: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String amount) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTransactionCard(String title, String subtitle, String date, double amount, {bool isEscrow = false, bool isPayout = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPayout ? AppColors.textSubtle.withOpacity(0.2) : (isEscrow ? AppColors.accent.withOpacity(0.1) : AppColors.primary.withOpacity(0.1)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPayout ? Icons.account_balance : (isEscrow ? Icons.security : Icons.money),
              color: isPayout ? AppColors.textBody : (isEscrow ? AppColors.accent : AppColors.primary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSubtle, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${amount > 0 ? '+' : ''}₦${amount.abs().toInt()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amount > 0 ? AppColors.accent : AppColors.textBody)),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (!isPayout) ...[
                    Icon(isEscrow ? Icons.shield : Icons.money_off, size: 12, color: AppColors.textSubtle),
                    const SizedBox(width: 4),
                  ],
                  Text(isPayout ? date : (isEscrow ? 'Escrow Transfer' : 'Cash'), style: const TextStyle(color: AppColors.textSubtle, fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
