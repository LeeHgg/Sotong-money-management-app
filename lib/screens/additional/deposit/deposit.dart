import 'package:flutter/material.dart';

class DepositItem {
  String category;
  String content;
  int amount;

  DepositItem({
    required this.category,
    required this.content,
    required this.amount,
  });
}

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  String? selectedCategory;
  final List<String> categories = ['용돈', '장학금', '지원금', '기타(직접입력)'];
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
    if (selectedCategory == null || 
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
          category: selectedCategory!,
          content: _contentController.text,
          amount: int.parse(_amountController.text.replaceAll(',', '')),
        ),
      );
      
      // 입력 필드 초기화
      selectedCategory = null;
      _contentController.clear();
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, '/'),
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
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownMenu<String>(
                initialSelection: selectedCategory,
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
                dropdownMenuEntries: categories.map(
                  (category) => DropdownMenuEntry(
                    value: category,
                    label: category,
                  ),
                ).toList(),
                onSelected: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: '내용',
                filled: true,
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
                      title: Text(item.content),
                      subtitle: Text(item.category),
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
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    '입금내역 추가+',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: depositItems.isEmpty ? null : () {
                  Navigator.pushNamed(context, '/amount_change_choice');
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
} 