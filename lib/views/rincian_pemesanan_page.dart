import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'riwayat_page.dart';
import 'profil_page.dart';
import '../widgets/compact_bottom_nav.dart';

class RincianPesananPage extends StatefulWidget {
  const RincianPesananPage({super.key});

  @override
  State<RincianPesananPage> createState() => _RincianPesananPageState();
}

class _RincianPesananPageState extends State<RincianPesananPage> with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  // Data stepper — sesuai Figma
  final List<Map<String, dynamic>> _stepperItems = [
    {'icon': Icons.receipt_long_outlined, 'label': 'Pesan'},
    {'icon': Icons.directions_bike_outlined, 'label': 'Dijemput'},
    {'icon': Icons.scale_outlined, 'label': 'Timbang'},
    {'icon': Icons.local_laundry_service_outlined, 'label': 'Cuci'},
    {'icon': Icons.inventory_2_outlined, 'label': 'Kemas'},
    {'icon': Icons.delivery_dining_outlined, 'label': 'Antar'},
    {'icon': Icons.home_outlined, 'label': 'Sampai'},
  ];

  // Index aktif stepper (mulai dari 0, lalu animasi ke 6)
  int _activeStepIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Mulai animasi setelah halaman terbuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startStepperAnimation();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startStepperAnimation() {
    if (_activeStepIndex < _stepperItems.length - 1) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _activeStepIndex++;
        });
        _startStepperAnimation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rincian Pesanan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE8EAF0)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── STATUS HEADER CARD ───
            _buildStatusHeaderCard(),
            const SizedBox(height: 16),

            // ─── ALAMAT CARD ───
            _buildAddressCard(),
            const SizedBox(height: 16),

            // ─── STATUS PESANAN (TIMELINE) ───
            _buildTimelineCard(),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                'Waktu ditampilkan dalam zona waktu lokal',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(height: 4),

            // ─── TOMBOL EXPAND ───
            Center(
              child: TextButton.icon(
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                icon: Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 18,
                  color: const Color(0xFF3B499A),
                ),
                label: Text(
                  _isExpanded
                      ? 'Tampilkan lebih sedikit'
                      : 'Tampilkan lebih banyak',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF3B499A)),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Divider(color: Colors.grey.shade200, thickness: 1),
            const SizedBox(height: 16),

            // ─── PESANAN CARD ───
            _buildOrderCard(),
            const SizedBox(height: 16),

            // ─── RINGKASAN PEMBAYARAN ───
            _buildPaymentSummary(),
          ],
        ),
      ),
      // ✅ BOTTOM NAVIGATION — KONSISTEN & KOMPAK
      bottomNavigationBar: CompactBottomNav(
        currentIndexNotifier: ValueNotifier<int>(1), // Index 1 = Rincian
        items: [
          BottomNavItem(activeIcon: 'assets/images/Menu Biru.png', inactiveIcon: 'assets/images/Menu Putih.png', label: 'Menu'),
          BottomNavItem(activeIcon: 'assets/images/Keranjang Biru.png', inactiveIcon: 'assets/images/Keranjang Putih.png', label: 'Rincian'),
          BottomNavItem(activeIcon: 'assets/images/Riwayat Biru.png', inactiveIcon: 'assets/images/Riwayat Putih.png', label: 'Riwayat'),
          BottomNavItem(activeIcon: 'assets/images/Profile Biru.png', inactiveIcon: 'assets/images/Profile Putih.png', label: 'Profil'),
        ],
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
          } else if (index == 1) {
            // Sudah di rincian
            return;
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiwayatPage()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilPage()));
          }
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  STATUS HEADER CARD
  // ═══════════════════════════════════════════════════════════════
  Widget _buildStatusHeaderCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B499A).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estimasi selesai 24 Maret',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pesanan Anda telah\nsampai',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 20),
          _buildHorizontalStepper(), // Animasi di sini
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  STEPPER HORIZONTAL DENGAN ANIMASI
  // ═══════════════════════════════════════════════════════════════
  Widget _buildHorizontalStepper() {
    return Row(
      children: List.generate(_stepperItems.length * 2 - 1, (index) {
        if (index.isOdd) {
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex < _activeStepIndex;

          // ✅ Animasi garis biru
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xFF3B499A)
                    : const Color(0xFFDDE0EE),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          );
        }

        final stepIndex = index ~/ 2;
        final isCompleted = stepIndex <= _activeStepIndex;
        final isActive = stepIndex == _activeStepIndex;
        final item = _stepperItems[stepIndex];

        // ✅ Animasi lingkaran (ukuran & shadow)
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 36 : 30,
              height: isActive ? 36 : 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? const Color(0xFF3B499A)
                    : const Color(0xFFDDE0EE),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: const Color(0xFF3B499A).withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: Icon(
                item['icon'] as IconData,
                size: isActive ? 18 : 15,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
              ),
            ),
          ],
        );
      }),
    );
  }

  // ═══════════════════════════════════════════════
  //  ALAMAT CARD
  // ═══════════════════════════════════════════════
  Widget _buildAddressCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B499A).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildAddressRow(
            label: 'Alamat Pengambilan',
            iconColor: const Color(0xFF3B499A),
            iconBgColor: const Color(0xFF3B499A).withOpacity(0.08),
            address: 'JL Mastrip, Perum Mastrip, Blok BB I,\nSumbersari, Jember',
            contact: 'Rafi Pideko  (+62)89615152487',
          ),
          _buildDashedDivider(),
          _buildAddressRow(
            label: 'Alamat Pengantaran',
            iconColor: const Color(0xFF2ECC71),
            iconBgColor: const Color(0xFF2ECC71).withOpacity(0.08),
            address: 'JL Mastrip, Perum Mastrip, Blok BB I,\nSumbersari, Jember',
            contact: 'Rafi Pideko  (+62)89615152487',
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow({
    required String label,
    required Color iconColor,
    required Color iconBgColor,
    required String address,
    required String contact,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.location_on_outlined, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                address,
                style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF2D2D2D),
                    height: 1.45),
              ),
              const SizedBox(height: 3),
              Text(
                contact,
                style: TextStyle(
                    fontSize: 11.5, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      child: Row(
        children: List.generate(
          30,
          (index) => Expanded(
            child: Container(
              height: 1.2,
              color: index % 2 == 0
                  ? const Color(0xFFD8DBE5)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  TIMELINE VERTIKAL
  // ═══════════════════════════════════════════════
  Widget _buildTimelineCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B499A).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Pesanan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(5, (i) {
            final isLast = i == 4;
            final isActive = i == 0; // Contoh: langkah pertama aktif
            final isDone = i < 0; // Tidak ada yang selesai di contoh ini

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    child: Column(
                      children: [
                        if (isActive)
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF3B499A).withOpacity(0.15),
                            ),
                            child: Center(
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF3B499A),
                                ),
                                child: const Icon(Icons.check,
                                    size: 9, color: Colors.white),
                              ),
                            ),
                          )
                        else if (isDone)
                          Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF3B499A),
                            ),
                            child: const Icon(Icons.check,
                                size: 11, color: Colors.white),
                          )
                        else
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                            ),
                          ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: isDone
                                    ? const Color(0xFF3B499A).withOpacity(0.25)
                                    : const Color(0xFFE8EAF0),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: isLast ? 0 : 22,
                        top: isActive ? 0 : 1,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hari ini',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                i == 0 ? '14.20' : i == 1 ? '12.45' : i == 2 ? '10.30' : i == 3 ? '09.15' : '09.00',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            i == 0
                                ? 'Pakaiannya telah sampai'
                                : i == 1
                                    ? 'Kurir dalam perjalanannya ke tempat Anda'
                                    : i == 2
                                        ? 'Pakaian sedang diproses'
                                        : i == 3
                                            ? 'Kurir dalam perjalanan mengambil pesanan'
                                            : 'Pesanan telah dibuat',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isActive
                                  ? const Color(0xFF3B499A)
                                  : const Color(0xFF444444),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  PESANAN CARD
  // ═══════════════════════════════════════════════
  Widget _buildOrderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B499A).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pesanan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B499A).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_laundry_service_outlined,
                    color: Color(0xFF3B499A),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cuci Kering',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Rp. 4.000/kaos',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'x3',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rp. 12.000',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B499A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFE082), width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFF5A623),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Layanan cuci kering mencakup pencucian dan pengeringan pakaian tanpa setrika.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF8D6E00),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  RINGKASAN PEMBAYARAN
  // ═══════════════════════════════════════════════
  Widget _buildPaymentSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B499A).withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 14),
          _buildSummaryRow(label: 'Subtotal (3 item)', value: 'Rp. 12.000'),
          const SizedBox(height: 10),
          _buildSummaryRow(label: 'Ongkos Kirim', value: 'Rp. 5.000'),
          const SizedBox(height: 10),
          _buildSummaryRow(label: 'Biaya Layanan', value: 'Rp. 1.000'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(height: 1.2, color: const Color(0xFFE8EAF0)),
          ),
          _buildSummaryRow(label: 'Total Pembayaran', value: 'Rp. 18.000', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.black : const Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isTotal ? const Color(0xFF3B499A) : Colors.black,
          ),
        ),
      ],
    );
  }
}