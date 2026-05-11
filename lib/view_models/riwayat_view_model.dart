import 'package:flutter/material.dart';
import '../models/transaction_item.dart';

class RiwayatViewModel extends ChangeNotifier {
  final List<TransactionItem> transactions = [
    TransactionItem(
      title: 'Cuci Kering',
      address: 'Perum Mastrip V',
      time: '25 Mar 2026, 16.06',
      price: 'Rp. 12.000,00',
      iconPath: 'assets/images/icon_cuci_kering.png',
    ),
    TransactionItem(
      title: 'Cuci Setrika',
      address: 'Perum Mastrip V',
      time: '25 Mar 2026, 09.00',
      price: 'Rp. 4.000,00',
      iconPath: 'assets/images/icon_cuci_setrika.png',
    ),
    TransactionItem(
      title: 'Cuci Setrika',
      address: 'Perum Mastrip V',
      time: '25 Mar 2026, 09.00',
      price: 'Rp. 4.000,00',
      iconPath: 'assets/images/icon_cuci_setrika.png',
    ),
    TransactionItem(
      title: 'Cuci Express',
      address: 'Perum Mastrip V',
      time: '20 Mar 2026, 20.00',
      price: 'Rp. 10.000,00',
      iconPath: 'assets/images/icon_cuci_express.png',
    ),
    TransactionItem(
      title: 'Cuci Express',
      address: 'Perum Mastrip V',
      time: '20 Mar 2026, 12.00',
      price: 'Rp. 10.000,00',
      iconPath: 'assets/images/icon_cuci_express.png',
    ),
  ];
}
