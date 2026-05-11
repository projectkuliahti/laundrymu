import 'package:flutter/material.dart';

class FormDataDiriViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  bool get canSubmit {
    return nameController.text.trim().isNotEmpty && addressController.text.trim().isNotEmpty;
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
