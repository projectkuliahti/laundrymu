import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'riwayat_page.dart';
import 'profil_page.dart';
import 'pemesanan_cuci_kering.dart';
import 'pemesanan_cuci_setrika.dart';
import 'pemesanan_cuci_express.dart';
import 'notifikasi_page.dart';
import 'chat_page.dart';
import 'rincian_pemesanan_page.dart';
import '../view_models/dashboard_view_model.dart';
import '../models/service_item.dart';
import '../widgets/compact_bottom_nav.dart'; // Import widget baru

class DashboardPage extends StatelessWidget {
  final String? phoneNumber;
  final String? fullName;
  final String? address;

  const DashboardPage({
    super.key,
    this.phoneNumber,
    this.fullName,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel(),
      child: _DashboardPageContent(
        phoneNumber: phoneNumber,
        fullName: fullName,
        address: address,
      ),
    );
  }
}

class _DashboardPageContent extends StatefulWidget { // Jadikan StatefulWidget
  final String? phoneNumber;
  final String? fullName;
  final String? address;

  const _DashboardPageContent({
    this.phoneNumber,
    this.fullName,
    this.address,
  });

  @override
  State<_DashboardPageContent> createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<_DashboardPageContent> {
  late final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0); // Index 0 = Dashboard

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      // Sudah di dashboard
      if (_currentIndexNotifier.value != 0) {
        _currentIndexNotifier.value = 0; // Update notifier agar UI bottom nav berubah
      }
      return;
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/rincian'), // Tambahkan name
          builder: (_) => const RincianPesananPage(),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/riwayat'), // Tambahkan name
          builder: (_) => const RiwayatPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/profil'), // Tambahkan name
          builder: (_) => const ProfilPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DashboardViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Halo, ${widget.fullName ?? 'Pengguna'}!',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotifikasiPage()));
                          },
                          child: _buildHeaderIcon(Icons.notifications_none),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage()));
                          },
                          child: _buildHeaderIcon(Icons.chat_bubble_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Column(
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller: viewModel.pageController,
                      onPageChanged: viewModel.updateCurrentPage,
                      itemCount: viewModel.banners.length,
                      itemBuilder: (context, index) => _buildRawBanner(context, viewModel.banners[index], index),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(viewModel.banners.length, (i) => _buildDot(i == viewModel.currentPage)),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text('Semua Layanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: viewModel.services.length,
                      itemBuilder: (context, index) => _buildServiceCard(context, viewModel.services[index]),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    const Text('Pesanan Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: SvgPicture.asset(
                              'assets/images/keranjang_belanja.svg',
                              fit: BoxFit.contain,
                              placeholderBuilder: (context) => Icon(
                                Icons.shopping_cart_outlined,
                                size: 120,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Belum ada pesanan. Kalau kamu kecapean cuci sendiri yang banyak, langsung aja ke aplikasi LaundryMu',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      // Ganti bagian ini
      bottomNavigationBar: CompactBottomNav(
        currentIndexNotifier: _currentIndexNotifier, // Kirim notifier
        items: [
          BottomNavItem(activeIcon: 'assets/images/Menu Biru.png', inactiveIcon: 'assets/images/Menu Putih.png', label: 'Menu'),
          BottomNavItem(activeIcon: 'assets/images/Keranjang Biru.png', inactiveIcon: 'assets/images/Keranjang Putih.png', label: 'Rincian'),
          BottomNavItem(activeIcon: 'assets/images/Riwayat Biru.png', inactiveIcon: 'assets/images/Riwayat Putih.png', label: 'Riwayat'),
          BottomNavItem(activeIcon: 'assets/images/Profile Biru.png', inactiveIcon: 'assets/images/Profile Putih.png', label: 'Profil'),
        ],
        onItemTapped: _onBottomNavTapped, // Hubungkan ke fungsi handler
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.black87, size: 20),
      );

  Widget _buildRawBanner(BuildContext context, String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciKeringPage()));
        if (index == 1) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciSetrikaPage()));
        if (index == 2) Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciExpressPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SvgPicture.asset(
            imagePath,
            width: double.infinity,
            height: 220,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => Container(
              height: 220,
              color: Colors.blue.shade50,
              child: const Center(child: CircularProgressIndicator(color: Color(0xFF3B499A))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isActive ? 20 : 6,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3B499A) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service) {
    return GestureDetector(
      onTap: () {
        if (service.title == 'Cuci Kering') Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciKeringPage()));
        if (service.title == 'Cuci Setrika') Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciSetrikaPage()));
        if (service.title == 'Cuci Express') Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PemesananCuciExpressPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.blue.shade50,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  service.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.blue.shade50,
                      child: Center(child: Icon(Icons.broken_image, color: Colors.blue.shade300, size: 40)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.desc,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                service.time,
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          service.price,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF3B499A)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}