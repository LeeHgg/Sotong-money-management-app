import 'package:flutter/material.dart';

class FigmaDepositScreen extends StatelessWidget {
  const FigmaDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('추가 입금'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // 카테고리 선택
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC8C8C8)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '카테고리 선택',
                ),
                items: const ['용돈', '장학금', '지원금', '기타(직접입력)']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
            ),
            const SizedBox(height: 15),
            // 내용 입력
            const TextField(
              decoration: InputDecoration(
                hintText: '내용',
              ),
            ),
            const SizedBox(height: 15),
            // 금액 입력
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '금액',
                suffixText: '원',
              ),
            ),
            const SizedBox(height: 15),
            // 입금내역 추가 버튼
            TextButton(
              onPressed: () {},
              child: const Text('입금내역 추가+'),
            ),
            const Spacer(),
            // 다음 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 74),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('다음'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 