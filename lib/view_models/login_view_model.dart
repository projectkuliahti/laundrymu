import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  LoginViewModel() {
    phoneController.addListener(() {
      notifyListeners();
    });
  }

  bool get hasValidPhone {
    final phone = phoneController.text.trim();
    return phone.isNotEmpty && phone.length >= 10;
  }

  String get formattedPhone {
    final raw = phoneController.text.trim();
    if (raw.startsWith('+62')) return raw;
    return '+62$raw';
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
