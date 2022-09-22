import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:share/share.dart';
import 'package:skany/widget/ButtonWidget.dart';
import 'package:skany/widget/custom_drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String qrCode = "";
  void _launchURL() async {
    if (await launchUrlString(qrCode)) ;
  }

  bool isVisivle = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          // backgroundColor: Colors.white70,
          title: Text(
            "SKANY",
            style: TextStyle(color: Colors.white, fontFamily: "Sofia"),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "[ Skany Result 👎 ]",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$qrCode",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              Visibility(
                visible: isVisivle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButtonWidget(
                        text: "Copy",
                        icon: Icons.copy,
                        onClicked: () {
                          final data = ClipboardData(text: qrCode);
                          Clipboard.setData(data);
                        }),
                    IconButtonWidget(
                        text: "Open",
                        icon: Icons.open_in_browser,
                        onClicked: () => _launchURL()),
                    IconButtonWidget(
                        text: "Share",
                        icon: Icons.share,
                        onClicked: () {
                          if (qrCode.isNotEmpty) {
                            Share.share(qrCode);
                          } else {
                            return null;
                          }
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonWidget(
                // color: Colors.white,
                text: "Scan QR Code",
                onClicked: () => scanQrCode(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#5fa693",
        "cancel",
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        isVisivle = true;
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == "-1"
                ? ''
                : qrCode;
      });
    } on PlatformException {
      qrCode = "Failed to get QR";
    }
  }
}
