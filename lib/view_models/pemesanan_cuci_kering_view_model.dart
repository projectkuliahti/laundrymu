import 'package:flutter/material.dart';

class PemesananCuciKeringViewModel extends ChangeNotifier {
  String? selectedShippingMethod;
  String? selectedAddress;

  void selectShippingMethod(String method) {
    selectedShippingMethod = method;
    notifyListeners();
  }

  void selectAddress(String address) {
    selectedAddress = address;
    notifyListeners();
  }

  bool get canCreateOrder => selectedShippingMethod != null && selectedAddress != null;
}