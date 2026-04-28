import 'package:flutter/material.dart';

class MetodePengirimanPage extends StatefulWidget {
  const MetodePengirimanPage({super.key});

  @override
  State<MetodePengirimanPage> createState() => _MetodePengirimanPageState();
}

class _MetodePengirimanPageState extends State<MetodePengirimanPage> {
  // 1 = Antar & Ambil Sendiri, 2 = Pengiriman Kurir
  int _selectedMethod = 1; 
  
  // Variabel untuk menyimpan tanggal
  DateTime? _startDate;
  DateTime? _endDate;

  // Format Tanggal agar enak dilihat (contoh: 20 Oktober 2023)
  String _formatDate(DateTime? date) {
    if (date == null) return 'Pilih Tanggal';
    return '${date.day} ${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int month) {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return months[month - 1];
  }

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Tanggal mulai minimal hari ini
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // Reset end date jika start date berubah biar gak aneh (opsional)
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

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
          'Pilih metode pengiriman',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Opsi 1: Antar & Ambil Sendiri
                  _buildOptionCard(
                    title: 'Antar dan ambil sendiri',
                    subtitle: 'Melayani setiap hari buka 07.00 - 21.00',
                    value: 1,
                  ),

                  const SizedBox(height: 15),

                  // Opsi 2: Pengiriman Jasa Kurir
                  _buildOptionCard(
                    title: 'Pengiriman jasa kurir (Gratis)',
                    subtitle: 'Melayani setiap hari buka 07.00 - 21.00',
                    value: 2,
                  ),

                  // 📅 LOGIKA KHUSUS: Form Tanggal muncul kalau pilih Kurir (value 2)
                  if (_selectedMethod == 2) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Jadwal Penjemputan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    // Input Dari Tanggal
                    _buildDateInput(
                      label: 'Dari Tanggal',
                      date: _startDate,
                      onTap: () => _selectDate(isStartDate: true),
                    ),

                    const SizedBox(height: 15),

                    // Input Sampai Tanggal
                    _buildDateInput(
                      label: 'Sampai Tanggal',
                      date: _endDate,
                      onTap: () => _selectDate(isStartDate: false),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Tombol Simpan di Bawah
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Logika Simpan di sini
                  String message = 'Metode: ${_selectedMethod == 1 ? "Antar Sendiri" : "Kurir"}';
                  if (_selectedMethod == 2) {
                    message += '\nMulai: ${_formatDate(_startDate)}';
                    message += '\nSelesai: ${_formatDate(_endDate)}';
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Berhasil Disimpan! $message"),
                      backgroundColor: const Color(0xFF3B499A),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B499A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🛠️ WIDGET BANGUN KARTU OPSI
  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required int value,
  }) {
    bool isSelected = _selectedMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = value;
          // Reset tanggal jika ganti metode biar bersih
          if (value == 1) {
            _startDate = null;
            _endDate = null;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F4FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B499A) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio Icon (Manual)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? const Color(0xFF3B499A) : Colors.grey),
                color: isSelected ? const Color(0xFF3B499A) : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF3B499A) : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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
  }

  // 📅 WIDGET INPUT TANGGAL
  Widget _buildDateInput({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    fontSize: 14,
                    color: date != null ? Colors.black87 : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Color(0xFF3B499A), size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}