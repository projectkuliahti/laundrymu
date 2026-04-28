import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'riwayat_page.dart';
import 'profil_page.dart';
import 'pemesanan_cuci_kering.dart';
import 'pemesanan_cuci_setrika.dart';
import 'pemesanan_cuci_express.dart';
import 'notifikasi_page.dart';
import 'chat_page.dart';
import 'rincian_pemesanan_page.dart'; // ✅ Tambahkan import ini

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  int _currentPage = 0;
  final PageController _pageController = PageController(
    viewportFraction: 0.92,
    initialPage: 0,
  );

  final List<Map<String, String>> _banners = [
    {'image': 'assets/images/cuci_kering_banner.svg'},
    {'image': 'assets/images/cuci_setrika_banner.svg'},
    {'image': 'assets/images/cuci_express_banner.svg'},
  ];

  final List<Map<String, String>> _services = [
    {'title': 'Cuci Kering', 'desc': 'Bersih maksimal, Kering sempurna', 'time': '3 hari', 'price': 'Rp. 4.000/KG', 'image': 'assets/images/cuci_kering_pallete.png'},
    {'title': 'Cuci Setrika', 'desc': 'Bersih, Rapi, Siap pakai', 'time': '4 hari', 'price': 'Rp. 5.000/KG', 'image': 'assets/images/cuci_setrika_pallete.png'},
    {'title': 'Cuci Express', 'desc': 'Cepat, Tanpa menunggu lama', 'time': '1 hari', 'price': 'Rp. 4.000/S', 'image': 'assets/images/cuci_express_pallete.png'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Halo, Fahmi!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NotifikasiPage()),
                            );
                          },
                          child: _buildHeaderIcon(Icons.notifications_none),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ChatPage()),
                            );
                          },
                          child: _buildHeaderIcon(Icons.chat_bubble_outline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // BANNER SECTION
              Column(
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: _banners.length,
                      itemBuilder: (context, index) => _buildRawBanner(_banners[index]['image']!, index),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_banners.length, (index) => _buildDot(index == _currentPage)),
                  ),
                ],
              ),

              // SEMUA LAYANAN
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
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _services.length,
                      itemBuilder: (context, index) => _buildServiceCard(
                        _services[index]['title']!,
                        _services[index]['desc']!,
                        _services[index]['time']!,
                        _services[index]['price']!,
                        _services[index]['image']!,
                      ),
                    ),
                  ],
                ),
              ),

              // PESANAN TERBARU
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

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF3B499A),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImgNavItem('assets/images/Menu Biru.png', 'assets/images/Menu Putih.png', 'Menu', true, () {}),
            _buildImgNavItem(
              'assets/images/Keranjang Biru.png', 
              'assets/images/Keranjang Putih.png', 
              '', 
              false, 
              () {
                // ✅ NAVIGASI KE HALAMAN RINCIAN PEMESANAN
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RincianPesananPage()),
                );
              }
            ),
            _buildImgNavItem('assets/images/Riwayat Biru.png', 'assets/images/Riwayat Putih.png', '', false, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
            }),
            _buildImgNavItem('assets/images/Profile Biru.png', 'assets/images/Profile Putih.png', '', false, () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilPage()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.black87, size: 20),
      );

  Widget _buildRawBanner(String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciKeringPage()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciSetrikaPage()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciExpressPage()));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
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

  Widget _buildServiceCard(String title, String desc, String time, String price, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == 'Cuci Kering') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciKeringPage()));
        } else if (title == 'Cuci Setrika') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciSetrikaPage()));
        } else if (title == 'Cuci Express') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PemesananCuciExpressPage()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8, spreadRadius: 2, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.blue.shade50,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
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
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey))
                      ]),
                      Text(price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF3B499A))),
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

  Widget _buildImgNavItem(String activeIcon, String inactiveIcon, String label, bool isActive, VoidCallback onTap) {
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