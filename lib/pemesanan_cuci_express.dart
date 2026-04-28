import 'package:flutter/material.dart';
import 'metode_pengiriman_page.dart';
import 'pilih_alamat_page.dart'; // ✅ Tambahkan ini

class PemesananCuciExpressPage extends StatelessWidget {
  const PemesananCuciExpressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buat Pesanan',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/cuci_express_pallete.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cleaning_services, size: 60, color: Colors.grey.shade400),
                        const Text('Cuci Express', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Judul & Harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Cuci Express',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const Text(
                  'Rp. 4.000/S',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Durasi
            Row(
              children: [
                Icon(Icons.access_time, color: Color(0x99666666), size: 16),
                const SizedBox(width: 6),
                const Text('1 hari waktu pengerjaan', style: TextStyle(fontSize: 14, color: Color(0x99666666))),
              ],
            ),
            const SizedBox(height: 20),

            // Deskripsi
            const Text('Deskripsi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 8),
            const Text(
              'Layanan cuci express memberikan cucian bersih dan cepat selesai dalam waktu singkat, cocok bila kamu butuh pakaian segera.',
              style: TextStyle(fontSize: 14, color: Color(0x99666666), height: 1.5),
            ),
            const SizedBox(height: 20),

            // Garis titik-titik pertama
            _buildDottedDivider(),
            const SizedBox(height: 20),

            // Pilih metode pengiriman
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MetodePengirimanPage()))
                    .then((_) {
                  // Optional: refresh state jika diperlukan
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_shipping_outlined, color: const Color(0xFF3B499A), size: 20),
                        const SizedBox(width: 12),
                        const Text('Pilih metode pengiriman', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Pilih alamat (UPDATE: Navigasi ke PilihAlamatPage)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PilihAlamatPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: const Color(0xFF3B499A), size: 20),
                        const SizedBox(width: 12),
                        const Text('Pilih alamat', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Garis titik-titik kedua
            _buildDottedDivider(),
            const SizedBox(height: 16),

            // Info text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.grey.shade600, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Dengan melakukan pemesanan, Anda menyetujui ketentuan layanan laundry dan menyatakan bahwa Anda telah membaca kebijakan yang berlaku. Pembayaran dilakukan secara langsung (tatap muka/cash) saat penyerahan atau pengambilan laundry.',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tombol Buat Pesanan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan berhasil dibuat!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B499A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Buat Pesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const int dotCount = 20;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(dotCount, (i) => Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF3B499A)),
            )),
          );
        },
      ),
    );
  }
}