import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/sign_up_info.dart';

class GetUserInfoPage extends StatefulWidget {
  final SignUpInfo signUpInfo;
  const GetUserInfoPage({Key? key, required this.signUpInfo}) : super(key: key);

  @override
  State<GetUserInfoPage> createState() => _GetUserInfoPageState();
}

class _GetUserInfoPageState extends State<GetUserInfoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  String? selectedGender;
  File? profileImage;
  String? formattedBirth;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  bool get isFormValid =>
      nameController.text.isNotEmpty &&
          birthController.text.isNotEmpty &&
          selectedGender != null;

  @override
  Widget build(BuildContext context) {
    final signUpInfo = widget.signUpInfo;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Text(
              '아래 정보만 입력하면\n회원가입 완료!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : null,
                        backgroundColor: Colors.grey[200],
                        child: profileImage == null
                            ? const Icon(Icons.camera_alt, color: Colors.grey)
                            : null,
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.camera_alt,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('이름', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                filled: true,
                fillColor: nameController.text.isEmpty
                    ? Colors.grey[200]
                    : Colors.blue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('생년월일', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );

                if (pickedDate != null) {
                  setState(() {
                    formattedBirth =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    birthController.text = formattedBirth!;
                  });
                }
              },
              child: Container(
                height: 56,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: birthController.text.isEmpty
                      ? Colors.grey[200]
                      : Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  birthController.text.isEmpty
                      ? '생년월일을 선택하세요'
                      : birthController.text,
                  style: TextStyle(
                    color: birthController.text.isEmpty
                        ? Colors.grey[600]
                        : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('성별', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = '여자';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedGender == '여자'
                            ? Colors.blue[50]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '여자',
                          style: TextStyle(
                            color: selectedGender == '여자'
                                ? Colors.black
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = '남자';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedGender == '남자'
                            ? Colors.blue[50]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '남자',
                          style: TextStyle(
                            color: selectedGender == '남자'
                                ? Colors.black
                                : Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isFormValid
                  ? () async {
                widget.signUpInfo.name = nameController.text.trim();
                widget.signUpInfo.birthday = birthController.text.trim();
                widget.signUpInfo.gender = selectedGender ?? '';

                print("저장할 유저 정보: ${widget.signUpInfo.toMap()}");

                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .add(widget.signUpInfo.toMap());


                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('회원가입이 완료되었습니다!')),
                  );
                  Navigator.of(context).pushReplacementNamed('/compSignUp');
                } catch (e) {
                  print('Firestore 저장 오류: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('저장 실패: $e')),
                  );
                }
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isFormValid ? Colors.blue : Colors.grey[300],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}