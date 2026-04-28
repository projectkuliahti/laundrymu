import 'package:flutter/material.dart';

class RincianPesananPage extends StatefulWidget {
  const RincianPesananPage({super.key});

  @override
  State<RincianPesananPage> createState() => _RincianPesananPageState();
}

class _RincianPesananPageState extends State<RincianPesananPage> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> _timelineData = [
    {
      'date': 'Hari ini',
      'time': '09.41',
      'title': 'Menunggu dikonfirmasi',
      'subtitle': 'Menunggu dikonfirmasi',
      'status': 'active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rincian Pesanan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // HEADER "Pesananmu diproses"
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Pesananmu diproses',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // ========== ROW ALAMAT (DIAMBIL & DIANTAR - KE SAMPING) ==========
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Diambil
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Diambil',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Jl. Mastrip, Perum Mastrip, Blok BB 1L, Sumbersari, Jember',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Diantar
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Diantar',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Jl. Mastrip, Perum Mastrip, Blok BB 1L, Sumbersari, Jember',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Rafi Pidekso',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.phone_outlined,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '(+62) 89615152487',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ========== STATUS PESANAN (TIMELINE KE SAMPING) ==========
            const Text(
              'Status Pesanan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Timeline dengan layout horizontal (Row)
            ..._buildTimelineHorizontal(),

            const SizedBox(height: 8),

            // Waktu zona lokal
            Text(
              'Waktu ditampilkan dalam zona waktu lokal',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade400,
              ),
            ),

            const SizedBox(height: 16),

            // ========== TOMBOL TAMPILKAN LEBIH BANYAK ==========
            Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 18,
                  color: const Color(0xFF3B499A),
                ),
                label: Text(
                  _isExpanded ? 'Tampilkan lebih sedikit' : 'Tampilkan lebih banyak',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF3B499A),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Garis pemisah
            Divider(
              color: Colors.grey.shade200,
              thickness: 1,
            ),

            const SizedBox(height: 16),

            // ========== PESANAN ==========
            const Text(
              'Pesanan',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            // Card Pesanan
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B499A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_laundry_service,
                    color: Color(0xFF3B499A),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                // Detail tengah
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cuci Kering',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bersih maksimal, Kering sempurna',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delivery_dining_outlined,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Pengiriman jasa kurir (Gratis)',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Harga kanan
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rp 4000',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      '/KG',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // TIMELINE HORIZONTAL (KE SAMPING)
  List<Widget> _buildTimelineHorizontal() {
    List<Map<String, dynamic>> items = [
      {
        'date': 'Hari ini',
        'time': '09.41',
        'title': 'Menunggu dikonfirmasi',
        'subtitle': 'Menunggu dikonfirmasi',
        'isFirst': true,
        'isLast': false,
      },
    ];

    if (_isExpanded) {
      items.add({
        'date': 'Hari ini',
        'time': '09.41',
        'title': 'Menunggu dikonfirmasi',
        'subtitle': 'Menunggu dikonfirmasi',
        'isFirst': false,
        'isLast': false,
      });
      items.add({
        'date': 'Kemarin',
        'time': '18.32',
        'title': 'Proses',
        'subtitle': 'Pesanan sedang dilipat',
        'isFirst': false,
        'isLast': true,
      });
    } else {
      items[0]['isLast'] = true;
    }

    List<Widget> timelineWidgets = [];
    
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = item['isLast'] == true;
      
      timelineWidgets.add(
        Expanded(
          child: Row(
            children: [
              // Lingkaran indikator
              Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item['isFirst'] == true 
                          ? const Color(0xFF3B499A) 
                          : Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 1,
                      height: 80,
                      color: Colors.green,
                      margin: const EdgeInsets.only(top: 4),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Konten
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item['date']!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item['time']!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['subtitle']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      
      if (!isLast) {
        timelineWidgets.add(
          Container(
            width: 40,
            child: Divider(
              color: Colors.green,
              thickness: 1,
            ),
          ),
        );
      }
    }
    
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: timelineWidgets,
      ),
    ];
  }
}