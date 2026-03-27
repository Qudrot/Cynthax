import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class JoinerVettingScreen extends StatelessWidget {
  const JoinerVettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Requests', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.background,
                          child: Icon(Icons.person, color: AppColors.primary, size: 30),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chidi Nwosu', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                              Text('Product Manager @ TechCorp', style: Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(Icons.verified_user, color: AppColors.accent, size: 16),
                                  SizedBox(width: 4),
                                  Text('NIN Verified', style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Mutual Interests (Professional context)
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildInterestChip('FinTech'),
                        _buildInterestChip('Product Strategy'),
                        _buildInterestChip('Lagos Tech Comm'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger, side: const BorderSide(color: AppColors.danger)),
                            child: const Text('Decline'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                            child: const Text('Accept Joiner'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Confirm Selected Joiners'),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String text) {
    return Chip(
      label: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textBody)),
      backgroundColor: AppColors.background,
      side: const BorderSide(color: AppColors.textSubtle),
      padding: EdgeInsets.zero,
    );
  }
}
