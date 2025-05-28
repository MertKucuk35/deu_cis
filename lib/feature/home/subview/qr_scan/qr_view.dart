import 'package:deu_cis/feature/home/subview/qr_scan/widget/qr_scanner_widget.dart';
import 'package:deu_cis/product/common/model/tab_item.dart';
import 'package:deu_cis/product/constants/string_consts.dart';
import 'package:flutter/material.dart';
import 'subview/qr_generator_screen.dart';

class QRView extends StatelessWidget {
  const QRView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TabItem> _tabs = [
      TabItem(title: 'QR Kod', child: QRGeneratorScreen()),
      TabItem(
        title: 'QR Kod Tarayıcı',
        child: QRScannerWidget(
          onQRCodeScanned: (String code) {
            // Handle scanned QR code here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('QR Code: $code')),
            );
          },
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: DefaultTabController(
          length: _tabs.length,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TabBar(
                  tabs: _tabs
                      .map((tab) => Tab(
                            text: tab.title,
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                  flex: 13,
                  child: TabBarView(
                      children: _tabs.map((tab) => tab.child).toList())),
            ],
          ),
        ),
      ),
    );
  }
}
