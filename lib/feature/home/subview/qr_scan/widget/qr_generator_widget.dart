import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGeneratorWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const QRGeneratorWidget({
    Key? key,
    required this.data,
    this.size = 200,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: data,
            version: QrVersions.auto,
            size: size,
            backgroundColor: backgroundColor ?? Colors.white,
            foregroundColor: foregroundColor ?? Colors.black,
            errorStateBuilder: (context, error) => Center(
              child: Text(
                'QR kod oluşturulamadı: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          // const SizedBox(height: 16),
          // Text(
          //   data,
          //   style: const TextStyle(fontSize: 16),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
