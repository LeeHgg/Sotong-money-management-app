import 'package:flutter/material.dart';

class AmountChangeChoice extends StatefulWidget {
  final List<dynamic> depositItems;

  const AmountChangeChoice({
    super.key,
    required this.depositItems,
  });

  @override
  State<AmountChangeChoice> createState() => _AmountChangeChoiceState();
}

class _AmountChangeChoiceState extends State<AmountChangeChoice> {
  bool isGoalSelected = true;
  bool isLimitSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('추가입금'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '금액에 변화가 생겼어요.\n',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '소비 한도',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0062FF), // 파란색 강조
                    ),
                  ),
                  TextSpan(
                    text: '나 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '목표 달성 기간',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0062FF), // 파란색 강조
                    ),
                  ),
                  TextSpan(
                    text: '을\n변경하시겠어요?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildOptionButton(
              title: '기간을 변경할래요',
              isSelected: isGoalSelected,
              onTap: () {
                setState(() {
                  isGoalSelected = true;
                  isLimitSelected = false;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              title: '소비 한도를 변경할래요',
              isSelected: isLimitSelected,
              onTap: () {
                setState(() {
                  isGoalSelected = false;
                  isLimitSelected = true;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/period_application_complete');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0062FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF0062FF) : const Color(0xFFD9D9D9),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF0062FF) : Colors.black54,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
} 