import 'package:deu_cis/feature/home/subview/draweritems/qr_scan/widget/qr_generator_widget.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:flutter/material.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  late String _qrData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qrData = locator<AuthViewModel>().user!.id.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('QR Kod Oluşturucu'),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: _controller,
            //   decoration: const InputDecoration(
            //     labelText: 'QR Kod İçeriği',
            //     hintText: 'QR kod için metin girin',
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) {
            //     setState(() {
            //       _qrData = value;
            //     });
            //   },
            // ),
            const SizedBox(height: 24),
            if (_qrData.isNotEmpty)
              Center(
                child: QRGeneratorWidget(
                  data: _qrData,
                  size: 250,
                ),
              ),
            const SizedBox(height: 24),
            // ElevatedButton(
            //   onPressed: _qrData.isEmpty
            //       ? null
            //       : () {
            //           // TODO: QR kodu kaydetme işlemi
            //           ScaffoldMessenger.of(context).showSnackBar(
            //             const SnackBar(
            //               content: Text('QR kod oluşturuldu'),
            //             ),
            //           );
            //         },
            //   child: const Text('QR Kodu Kaydet'),
            // ),
          ],
        ),
      ),
    );
  }
}
