import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan ini
import 'dashboard_page.dart';
import 'profil_page.dart';
import 'rincian_pemesanan_page.dart';
import '../view_models/riwayat_view_model.dart';
import '../models/transaction_item.dart';
import '../widgets/compact_bottom_nav.dart'; // Pastikan ini ada dan benar

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  late final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(2); // Index 2 = Riwayat

  @override
  void initState() {
    super.initState();
    // Jika halaman ini dibuka, pastikan currentIndex di bottom nav adalah 2
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentIndexNotifier.value != 2) {
        _currentIndexNotifier.value = 2;
      }
    });
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 2) {
      // Sudah di riwayat
      if (_currentIndexNotifier.value != 2) {
        _currentIndexNotifier.value = 2;
      }
      return;
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/dashboard'),
          builder: (_) => const DashboardPage(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/rincian'),
          builder: (_) => const RincianPesananPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/profil'),
          builder: (_) => const ProfilPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Bungkus dengan Provider untuk menyediakan RiwayatViewModel ke widget di bawahnya
    return ChangeNotifierProvider(
      create: (context) => RiwayatViewModel(), // ViewModel dibuat di sini
      child: Consumer<RiwayatViewModel>( // Gunakan Consumer untuk rebuild jika ViewModel berubah
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context)),
              title: const Text('Riwayat Transaksi',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: const Color(0xFF3B499A),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white, size: 24),
                        SizedBox(width: 10),
                        Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Cari Riwayat Transaksi',
                                    hintStyle: TextStyle(color: Colors.white70),
                                    border: InputBorder.none),
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),

                  _buildSectionHeader('Hari ini'),
                  ...viewModel.transactions.take(3).map(_buildTransactionCard),

                  const SizedBox(height: 16),

                  _buildSectionHeader('20 Mar 2026'),
                  ...viewModel.transactions.skip(3).map(_buildTransactionCard),

                  const SizedBox(height: 100),
                ],
              ),
            ),
            // Gunakan CompactBottomNav yang kamu buat
            bottomNavigationBar: CompactBottomNav(
              currentIndexNotifier: _currentIndexNotifier,
              items: [
                BottomNavItem(activeIcon: 'assets/images/Menu Biru.png', inactiveIcon: 'assets/images/Menu Putih.png', label: 'Menu'),
                BottomNavItem(activeIcon: 'assets/images/Keranjang Biru.png', inactiveIcon: 'assets/images/Keranjang Putih.png', label: 'Rincian'),
                BottomNavItem(activeIcon: 'assets/images/Riwayat Biru.png', inactiveIcon: 'assets/images/Riwayat Putih.png', label: 'Riwayat'),
                BottomNavItem(activeIcon: 'assets/images/Profile Biru.png', inactiveIcon: 'assets/images/Profile Putih.png', label: 'Profil'),
              ],
              onItemTapped: _onBottomNavTapped,
            ),
          );
        }
      ),
    );
  }

  Widget _buildSectionHeader(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
      );

  Widget _buildTransactionCard(TransactionItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 2))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFFEFF0FF),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: _buildImageIcon(item.iconPath),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 4),
                Text(item.address,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                const Text('Selesai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green)),
              ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(item.time,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(item.price,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ]),
        ],
      ),
    );
  }

  Widget _buildImageIcon(String iconPath) {
    return Image.asset(
      iconPath,
      width: 28,
      height: 28,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.local_laundry_service,
          color: const Color(0xFF3B499A),
          size: 24,
        );
      },
    );
  }
}