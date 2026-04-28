import 'package:flutter/material.dart';

class TambahAlamatPage extends StatefulWidget {
  const TambahAlamatPage({super.key});

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  // Controller untuk inputan form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  // Variabel untuk radio button (0 = Rumah, 1 = Lainnya)
  int _selectedLabel = 0;

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
          'Tambah Alamat',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Input Nama Lengkap
            const Text(
              'Nama lengkap',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _namaController,
              hintText: 'Masukkan nama lengkap',
            ),

            const SizedBox(height: 20),

            // Input Nomor Telepon
            const Text(
              'Nomor telepon',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _teleponController,
              hintText: 'Masukkan nomor telepon',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            // Input Alamat
            const Text(
              'Alamat',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _alamatController,
                maxLines: 3, // Biar bisa panjang
                decoration: const InputDecoration(
                  hintText: 'Masukkan alamat lengkap',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pilihan Tandai Sebagai
            const Text(
              'Tandai sebagai',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Opsi Rumah
                _buildRadioOption(
                  label: 'Rumah',
                  value: 0,
                  groupValue: _selectedLabel,
                  onChanged: (val) {
                    setState(() {
                      _selectedLabel = val!;
                    });
                  },
                ),
                const SizedBox(width: 30),
                // Opsi Lainnya
                _buildRadioOption(
                  label: 'Lainnya',
                  value: 1,
                  groupValue: _selectedLabel,
                  onChanged: (val) {
                    setState(() {
                      _selectedLabel = val!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_namaController.text.isEmpty ||
                      _teleponController.text.isEmpty ||
                      _alamatController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mohon lengkapi semua data')),
                    );
                  } else {
                    // Logika simpan berhasil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Alamat berhasil disimpan')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B499A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Input Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Widget Helper untuk Radio Button Custom (SESUAI FIGMA)
  Widget _buildRadioOption({
    required String label,
    required int value,
    required int groupValue,
    required Function(int?) onChanged,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(value),
          child: Container(
            width: 22, // Ukuran pas
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: groupValue == value ? const Color(0xFF3B499A) : Colors.grey,
                width: 2,
              ),
              color: groupValue == value ? const Color(0xFF3B499A) : Colors.transparent,
            ),
            child: groupValue == value
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }
}