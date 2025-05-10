import 'package:flutter/material.dart';

class LimitApplicationComplete extends StatelessWidget {
  const LimitApplicationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 250),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Color(0xFF0062FF),
                size: 40,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '1,500,000원을\n소비한도에 반영했어요!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '기존 플랜의 하루 소비한도가\n7,000원에서 8,500원으로 변경되었어요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text('확인했어요'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
} 