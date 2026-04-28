import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'riwayat_page.dart';
import 'rincian_pemesanan_page.dart'; // ✅ Tambahkan import ini

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

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
                    image: NetworkImage("https://i.pravatar.cc/150?img=11"),
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
              _buildMenuItem(Icons.percent, 'Offers', context),
              const SizedBox(height: 12),
              _buildMenuItem(Icons.login, 'Masukkan', context),
              const SizedBox(height: 12),
              _buildMenuItem(Icons.help_outline, 'Pusat Bantuan', context),
              const SizedBox(height: 12),
              _buildMenuItem(Icons.headset_mic, 'Layanan Servis', context),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.logout, color: Colors.red),
                  ),
                  title: const Text('Keluar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // 5. BOTTOM NAVIGATION (PAKAI GAMBAR DARI FIGMA)
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF3B499A),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu (Tidak Aktif)
            _buildImgNavItem(
              activeIcon: 'assets/images/Menu Biru.png',
              inactiveIcon: 'assets/images/Menu Putih.png',
              label: '',
              isActive: false,
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
              },
            ),
            // Keranjang (Tidak Aktif) - ✅ UPDATE: Navigasi ke Rincian Pesanan
            _buildImgNavItem(
              activeIcon: 'assets/images/Keranjang Biru.png',
              inactiveIcon: 'assets/images/Keranjang Putih.png',
              label: '',
              isActive: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RincianPesananPage()),
                );
              },
            ),
            // Riwayat (Tidak Aktif)
            _buildImgNavItem(
              activeIcon: 'assets/images/Riwayat Biru.png',
              inactiveIcon: 'assets/images/Riwayat Putih.png',
              label: '',
              isActive: false,
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
              },
            ),
            // Profile (Aktif: Biru + Pill Putih)
            _buildImgNavItem(
              activeIcon: 'assets/images/Profile Biru.png',
              inactiveIcon: 'assets/images/Profile Putih.png',
              label: 'Profil',
              isActive: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: const Color(0xFF3B499A), size: 20),
        ),
        title: Text(title, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  // 🛠️ WIDGET BOTTOM NAV PAKAI GAMBAR PNG
  Widget _buildImgNavItem({
    required String activeIcon,
    required String inactiveIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isActive ? 16 : 12, vertical: 8),
        decoration: isActive ? BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isActive ? activeIcon : inactiveIcon,
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: isActive ? const Color(0xFF3B499A) : Colors.white70, fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ],
        ),
      ),
    );
  }
}