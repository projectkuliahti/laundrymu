import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dashboard_page.dart';
import 'profil_page.dart';
import 'rincian_pemesanan_page.dart'; // ✅ Tambahkan import ini

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            // SEARCH BAR
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

            // SECTION: HARI INI
            _buildSectionHeader('Hari ini'),
            _buildTransactionCard(
                title: 'Cuci Kering',
                address: 'Perum Mastrip V',
                time: '25 Mar 2026, 16.06',
                price: 'Rp. 12.000,00',
                iconPath: 'assets/images/icon_cuci_kering.png'),
            _buildTransactionCard(
                title: 'Cuci Setrika',
                address: 'Perum Mastrip V',
                time: '25 Mar 2026, 09.00',
                price: 'Rp. 4.000,00',
                iconPath: 'assets/images/icon_cuci_setrika.png'),
            _buildTransactionCard(
                title: 'Cuci Setrika',
                address: 'Perum Mastrip V',
                time: '25 Mar 2026, 09.00',
                price: 'Rp. 4.000,00',
                iconPath: 'assets/images/icon_cuci_setrika.png'),

            const SizedBox(height: 16),

            // SECTION: 20 MAR 2026
            _buildSectionHeader('20 Mar 2026'),
            _buildTransactionCard(
                title: 'Cuci Express',
                address: 'Perum Mastrip V',
                time: '20 Mar 2026, 20.00',
                price: 'Rp. 10.000,00',
                iconPath: 'assets/images/icon_cuci_express.png'),
            _buildTransactionCard(
                title: 'Cuci Express',
                address: 'Perum Mastrip V',
                time: '20 Mar 2026, 12.00',
                price: 'Rp. 10.000,00',
                iconPath: 'assets/images/icon_cuci_express.png'),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // BOTTOM NAVIGATION (PAKAI GAMBAR DARI FIGMA)
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF3B499A),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()));
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
            // Riwayat (Aktif: Biru + Pill Putih)
            _buildImgNavItem(
              activeIcon: 'assets/images/Riwayat Biru.png',
              inactiveIcon: 'assets/images/Riwayat Putih.png',
              label: 'Riwayat',
              isActive: true,
              onTap: () {},
            ),
            // Profile (Tidak Aktif)
            _buildImgNavItem(
              activeIcon: 'assets/images/Profile Biru.png',
              inactiveIcon: 'assets/images/Profile Putih.png',
              label: '',
              isActive: false,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const ProfilPage()));
              },
            ),
          ],
        ),
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

  // ✅ UPDATE: Menggunakan GAMBAR ICON berdasarkan Tipe Cuci
  Widget _buildTransactionCard({
    required String title,
    required String address,
    required String time,
    required String price,
    required String iconPath,
  }) {
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
              child: _buildImageIcon(iconPath),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 4),
                Text(address,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                const Text('Selesai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green)),
              ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(time,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(price,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ]),
        ],
      ),
    );
  }

  // ✅ WIDGET UNTUK MENAMPILKAN GAMBAR ICON
  Widget _buildImageIcon(String iconPath) {
    return Image.asset(
      iconPath,
      width: 28,
      height: 28,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback icon jika gambar tidak ditemukan
        return Icon(
          Icons.local_laundry_service,
          color: const Color(0xFF3B499A),
          size: 24,
        );
      },
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
        padding:
            EdgeInsets.symmetric(horizontal: isActive ? 16 : 12, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30))
            : null,
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
              Text(label,
                  style: TextStyle(
                      color:
                          isActive ? const Color(0xFF3B499A) : Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ],
          ],
        ),
      ),
    );
  }
}