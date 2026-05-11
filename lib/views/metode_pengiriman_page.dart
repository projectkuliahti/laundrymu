import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/shipping_method_view_model.dart';

class MetodePengirimanPage extends StatelessWidget {
  const MetodePengirimanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShippingMethodViewModel(),
      child: const _MetodePengirimanPageContent(),
    );
  }
}

class _MetodePengirimanPageContent extends StatelessWidget {
  const _MetodePengirimanPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShippingMethodViewModel>();

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
                  _buildOptionCard(
                    title: 'Antar dan ambil sendiri',
                    subtitle: 'Melayani setiap hari buka 07.00 - 21.00',
                    value: 1,
                    isSelected: viewModel.selectedMethod == 1,
                    onTap: () => viewModel.selectMethod(1),
                  ),

                  const SizedBox(height: 15),

                  _buildOptionCard(
                    title: 'Pengiriman jasa kurir (Gratis)',
                    subtitle: 'Melayani setiap hari buka 07.00 - 21.00',
                    value: 2,
                    isSelected: viewModel.selectedMethod == 2,
                    onTap: () => viewModel.selectMethod(2),
                  ),

                  if (viewModel.selectedMethod == 2) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Jadwal Penjemputan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    _buildDateInput(
                      label: 'Dari Tanggal',
                      date: viewModel.startDate,
                      onTap: () => _selectDate(context, viewModel, true),
                    ),

                    const SizedBox(height: 15),

                    _buildDateInput(
                      label: 'Sampai Tanggal',
                      date: viewModel.endDate,
                      onTap: () => _selectDate(context, viewModel, false),
                    ),
                  ],
                ],
              ),
            ),
          ),

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
                  String message = 'Metode: ${viewModel.selectedMethod == 1 ? "Antar Sendiri" : "Kurir"}';
                  if (viewModel.selectedMethod == 2) {
                    message += '\nMulai: ${viewModel.formatDate(viewModel.startDate)}';
                    message += '\nSelesai: ${viewModel.formatDate(viewModel.endDate)}';
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

  Future<void> _selectDate(BuildContext context, ShippingMethodViewModel viewModel, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (isStartDate) {
        viewModel.setStartDate(picked);
      } else {
        viewModel.setEndDate(picked);
      }
    }
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required int value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                  date != null ? '${date.day} ${_monthName(date.month)} ${date.year}' : 'Pilih Tanggal',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
    return months[month - 1];
  }
}

