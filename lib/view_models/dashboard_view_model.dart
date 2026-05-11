import 'package:flutter/material.dart';
import '../models/service_item.dart';

class DashboardViewModel extends ChangeNotifier {
  int currentPage = 0;
  final PageController pageController = PageController(viewportFraction: 0.92, initialPage: 0);

  final List<String> banners = [
    'assets/images/cuci_kering_banner.svg',
    'assets/images/cuci_setrika_banner.svg',
    'assets/images/cuci_express_banner.svg',
  ];

  final List<ServiceItem> services = [
    ServiceItem(
      title: 'Cuci Kering',
      desc: 'Bersih maksimal, Kering sempurna',
      time: '3 hari',
      price: 'Rp. 4.000/KG',
      imagePath: 'assets/images/cuci_kering_pallete.png',
    ),
    ServiceItem(
      title: 'Cuci Setrika',
      desc: 'Bersih, Rapi, Siap pakai',
      time: '4 hari',
      price: 'Rp. 5.000/KG',
      imagePath: 'assets/images/cuci_setrika_pallete.png',
    ),
    ServiceItem(
      title: 'Cuci Express',
      desc: 'Cepat, Tanpa menunggu lama',
      time: '1 hari',
      price: 'Rp. 4.000/S',
      imagePath: 'assets/images/cuci_express_pallete.png',
    ),
  ];

  void updateCurrentPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
