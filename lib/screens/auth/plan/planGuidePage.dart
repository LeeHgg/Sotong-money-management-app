import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanGuidePage extends StatefulWidget {
  const PlanGuidePage({super.key});

  @override
  State<PlanGuidePage> createState() => _PlanGuidePageState();
}

class _PlanGuidePageState extends State<PlanGuidePage> {
  Future<String> _getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? '사용자';
  }

  @override
  Widget build(BuildContext context) {
    // 임시 하드코딩 값
    final durationMonths = 4;
    final savingRate = 70;
    final monthlyLimit = 500000;
    final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder<String>(
            future: _getUsername(),
            builder: (context, snapshot) {
              final userName = snapshot.data ?? '...';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: '$userName님은 '),
                        TextSpan(
                          text: '$durationMonths개월',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        TextSpan(
                          text: '동안\n',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '$savingRate%의 ',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        TextSpan(text: '절약비율로\n생활하시게 될 거예요.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '입력하신 고정 수입과 소비,\n절약비율과 기간을 토대로\n변동소비 한달 금액이 한 달',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${formatter.format(monthlyLimit)}으로 설정되었어요.',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('한달 전체 수입'),
                              Text('-'),
                              Text('고정소비'),
                              Text('-'),
                              Text('저축'),
                              Text('='),
                              Text('변동소비', style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '소통은 여러분의 \'변동소비\' 관리를 도와드립니다.\n\n이 안에서 예산을 꾸려 볼까요?',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/variableExpense');

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0062FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('네, 진행해주세요!'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
