import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DepositItem {
  String type;
  String content;
  int amount;
  DateTime createdAt;

  DepositItem({
    required this.type,
    required this.content,
    required this.amount,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content,
      'amount': amount,
      'createdAt': createdAt,
    };
  }
}

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  String? selectedType;
  final List<String> types = ['용돈', '장학금', '지원금', '기타(직접입력)'];
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  List<DepositItem> depositItems = [];

  @override
  void dispose() {
    _contentController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addDepositItem() {
    if (selectedType == null || 
        _contentController.text.isEmpty || 
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 항목을 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      depositItems.add(
        DepositItem(
          type: selectedType!,
          content: _contentController.text,
          amount: int.parse(_amountController.text.replaceAll(',', '')),
        ),
      );
      
      // 입력 필드 초기화
      selectedType = null;
      _contentController.clear();
      _amountController.clear();
    });
  }

  Future<void> _saveToFirebase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인이 필요합니다.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final batch = FirebaseFirestore.instance.batch();
      final planRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('plans')
          .doc('main');

      final depositRef = planRef.collection('additionalDeposits');
      int totalDepositAmount = 0;

      for (var item in depositItems) {
        final newDoc = depositRef.doc();
        batch.set(newDoc, item.toJson());
        totalDepositAmount += item.amount;
      }

      batch.update(planRef, {
        'currentSavedAmount': FieldValue.increment(totalDepositAmount),
      });

      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('입금 내역이 저장되었습니다.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, '/amount_change_choice');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownMenu<String>(
                initialSelection: selectedType,
                hintText: '카테고리 선택',
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                ),
                menuStyle: MenuStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                dropdownMenuEntries: types.map(
                  (type) => DropdownMenuEntry(
                    value: type,
                    label: type,
                  ),
                ).toList(),
                onSelected: (String? newValue) {
                  setState(() {
                    selectedType = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                filled: true,
                hintText: '내용',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                hintText: 'ex. 90,000',
                suffixText: '원',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            
            // 입금 내역 리스트
            Expanded(
              child: ListView.builder(
                itemCount: depositItems.length,
                itemBuilder: (context, index) {
                  final item = depositItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(item.type),
                      subtitle: Text(item.content),
                      trailing: Text('${item.amount.toString()}원'),
                      leading: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            depositItems.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            TextButton(
              onPressed: _addDepositItem,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('입금내역 추가+'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: depositItems.isEmpty ? null : _saveToFirebase,
                child: const Text('다음'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 