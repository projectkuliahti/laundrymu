import 'package:flutter/material.dart';

class OTPViewModel extends ChangeNotifier {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  bool isLoading = false;

  String get otpCode => controllers.map((controller) => controller.text).join();
  bool get isOtpComplete => otpCode.length == 4;

  void requestInitialFocus() {
    if (focusNodes.isNotEmpty) {
      focusNodes[0].requestFocus();
    }
  }

  void onTextChanged(int index, String value) {
    if (value.length == 1 && index < controllers.length - 1) {
      Future.delayed(const Duration(milliseconds: 50), () {
        focusNodes[index + 1].requestFocus();
      });
    } else if (value.isEmpty && index > 0) {
      Future.delayed(const Duration(milliseconds: 50), () {
        focusNodes[index - 1].requestFocus();
      });
    }
    notifyListeners();
  }

  Future<bool> verifyOtp() async {
    if (isLoading) return false;
    if (!isOtpComplete) return false;

    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
    notifyListeners();

    return otpCode == '1234';
  }

  void resendOtp() {
    for (var controller in controllers) {
      controller.clear();
    }
    requestInitialFocus();
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
