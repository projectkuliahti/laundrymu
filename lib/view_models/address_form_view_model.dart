import 'package:flutter/material.dart';

class AddressFormViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  int selectedLabel = 0;

  bool get hasValidData {
    return nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }

  bool get canSave => hasValidData;

  String get selectedLabelText => selectedLabel == 0 ? 'Rumah' : 'Lainnya';

  void setLabel(int value) {
    selectedLabel = value;
    notifyListeners();
  }

  void updateForm() {
    notifyListeners();
  }

  bool saveAddress() {
    if (!hasValidData) return false;
    // Simpan data alamat ke model, service, atau local cache di sini bila diperlukan.
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
