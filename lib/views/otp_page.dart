import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'form_data_diri.dart';
import '../view_models/otp_view_model.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;

  const OTPPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late OTPViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = OTPViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.requestInitialFocus();
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  String _formatPhoneNumber(String number) {
    if (number.startsWith('+62')) {
      String cleaned = number.substring(3);
      return '+62 ${cleaned.substring(0, 2)} ${cleaned.substring(2, 4)} ${cleaned.substring(4, 6)} ${cleaned.substring(6)}';
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Text(
                'Masukkan OTP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                'Silakan masukkan OTP yang dikirim ke\n${_formatPhoneNumber(widget.phoneNumber)}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              Consumer<OTPViewModel>(
                builder: (context, vm, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < vm.controllers.length; i++)
                        _buildOTPInput(vm, i),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              Consumer<OTPViewModel>(
                builder: (context, vm, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: vm.isLoading ? null : () async {
                        final success = await vm.verifyOtp();
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => FormDataDiri(phoneNumber: widget.phoneNumber)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kode OTP salah. Coba lagi.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: vm.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Verifikasi OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              Consumer<OTPViewModel>(
                builder: (context, vm, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Tidak menerima OTP? ', style: TextStyle(color: Colors.black54)),
                      GestureDetector(
                        onTap: vm.isLoading ? null : vm.resendOtp,
                        child: Text(
                          'Kirim ulang OTP',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPInput(OTPViewModel vm, int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: vm.controllers[index],
        focusNode: vm.focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        enabled: !vm.isLoading,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
        ),
        onChanged: (value) => vm.onTextChanged(index, value),
      ),
    );
  }
}

