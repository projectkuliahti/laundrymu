import 'package:flutter/material.dart';
import 'tambah_alamat.dart'; // ✅ Import halaman tambah alamat

class PilihAlamatPage extends StatelessWidget {
  const PilihAlamatPage({super.key});

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
          'Pilih Alamat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ✅ Tombol Tambah Alamat (Sekarang Bisa Diklik)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TambahAlamatPage()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3B499A), width: 1),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Color(0xFF3B499A), size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Tambah alamat',
                        style: TextStyle(
                          color: Color(0xFF3B499A),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Kartu Alamat 1 (Fahmi Syahdan) - DEFAULT
            _buildAddressCard(
              name: 'Fahmi Syahdan',
              phone: '(+62) 86743257123',
              address: 'Perum, Mastrip V, Surnbersari, Jember',
              isDefault: true,
              onEdit: () {
                // Logika edit alamat
              },
            ),

            const SizedBox(height: 16),

            // Kartu Alamat 2 (Rafi Pidekso)
            _buildAddressCard(
              name: 'Rafi Pidekso',
              phone: '(+62) 896152487',
              address: 'Jl. Mastrrip, Surnbersari, Jember',
              isDefault: false,
              onEdit: () {
                // Logika edit alamat
              },
            ),
            
            const SizedBox(height: 100), // Spacer bawah
          ],
        ),
      ),
    );
  }

  // 🎯 Widget Helper untuk Kartu Alamat
  Widget _buildAddressCard({
    required String name,
    required String phone,
    required String address,
    required bool isDefault,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Icon Lokasi
          const Icon(Icons.location_on_outlined, color: Color(0xFF3B499A), size: 24),
          const SizedBox(width: 12),
          
          // Detail Alamat
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama & Badge Default
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // Badge "Default" hanya muncul kalau isDefault = true
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEB3B), // Warna Kuning
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                // No Telepon
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                // Alamat
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Tombol Edit
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF3B499A)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B499A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
