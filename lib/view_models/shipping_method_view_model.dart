import 'package:flutter/material.dart';

class ShippingMethodViewModel extends ChangeNotifier {
  int selectedMethod = 1;
  DateTime? startDate;
  DateTime? endDate;

  void selectMethod(int value) {
    selectedMethod = value;
    if (value == 1) {
      startDate = null;
      endDate = null;
    }
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    if (endDate != null && endDate!.isBefore(startDate!)) {
      endDate = null;
    }
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Pilih Tanggal';
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
