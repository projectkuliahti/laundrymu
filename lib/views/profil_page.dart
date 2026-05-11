import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'riwayat_page.dart';
import 'rincian_pemesanan_page.dart';
import '../widgets/compact_bottom_nav.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(3); // Index 3 = Profil

  void _onBottomNavTapped(int index) {
    if (index == 3) {
      // Sudah di profil
      if (_currentIndexNotifier.value != 3) {
        _currentIndexNotifier.value = 3;
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
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/riwayat'),
          builder: (_) => const RiwayatPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    // Ganti dengan URL gambar profil nyata jika ada
                    image: NetworkImage("https://i.pravatar.cc/150?img=11"), // URL dari konteks kamu
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fahmi Syahdan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 6),
              Text(
                '+62 86743267123',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_note, size: 18, color: Color(0xFF3B499A)),
                label: const Text('Edit Profil', style: TextStyle(color: Color(0xFF3B499A), fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
              ),
              const SizedBox(height: 30),

              _buildCustomMenuItem(
                iconPath: 'assets/images/icon_offers.png',
                title: 'Offers',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildCustomMenuItem(
                iconPath: 'assets/images/icon_masukkan.png',
                title: 'Masukkan',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildCustomMenuItem(
                iconPath: 'assets/images/icon_pusat_bantuan.png',
                title: 'Pusat Bantuan',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildCustomMenuItem(
                iconPath: 'assets/images/icon_layanan_servis.png',
                title: 'Layanan Servis',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildCustomMenuItem(
                iconPath: 'assets/images/icon_keluar.png',
                title: 'Keluar',
                onTap: () {},
                isLogout: true,
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
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

  Widget _buildCustomMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isLogout ? Colors.red.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isLogout ? Colors.red.shade200 : Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback jika gambar tidak ditemukan
                return Icon(
                  isLogout ? Icons.logout : Icons.help_outline,
                  size: 20,
                  color: isLogout ? Colors.red : const Color(0xFF3B499A),
                );
              },
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}