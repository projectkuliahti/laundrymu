import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/address_form_view_model.dart';

class TambahAlamatPage extends StatelessWidget {
  const TambahAlamatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddressFormViewModel(),
      child: const _TambahAlamatPageContent(),
    );
  }
}

class _TambahAlamatPageContent extends StatelessWidget {
  const _TambahAlamatPageContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddressFormViewModel>();

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

            const Text(
              'Nama lengkap',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: viewModel.nameController,
              hintText: 'Masukkan nama lengkap',
              onChanged: (_) => viewModel.updateForm(),
            ),

            const SizedBox(height: 20),

            const Text(
              'Nomor telepon',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: viewModel.phoneController,
              hintText: 'Masukkan nomor telepon',
              keyboardType: TextInputType.phone,
              onChanged: (_) => viewModel.updateForm(),
            ),

            const SizedBox(height: 20),

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
                controller: viewModel.addressController,
                maxLines: 3,
                onChanged: (_) => viewModel.updateForm(),
                decoration: const InputDecoration(
                  hintText: 'Masukkan alamat lengkap',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tandai sebagai',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildRadioOption(
                  label: 'Rumah',
                  value: 0,
                  groupValue: viewModel.selectedLabel,
                  onChanged: (val) => viewModel.setLabel(val!),
                ),
                const SizedBox(width: 30),
                _buildRadioOption(
                  label: 'Lainnya',
                  value: 1,
                  groupValue: viewModel.selectedLabel,
                  onChanged: (val) => viewModel.setLabel(val!),
                ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: viewModel.canSave
                    ? () {
                        final saved = viewModel.saveAddress();
                        if (!saved) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mohon lengkapi semua data')),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Alamat berhasil disimpan')),
                        );
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: viewModel.canSave ? const Color(0xFF3B499A) : Colors.grey.shade400,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
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
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

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
            width: 22,
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

