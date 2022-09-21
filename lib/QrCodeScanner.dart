import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:share/share.dart';
import 'package:skany/ButtonWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String qrCode = "";
  void _launchURL() async {
    if (await launch(qrCode)) throw "Could not launch $qrCode";
    //if (!await launch(qrCode)) throw 'Could not launch $qrCode';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: Text(
            "SKANY",
            style: TextStyle(color: Colors.black87, fontFamily: "Sofia"),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "[ Skany Result ]",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            final data = ClipboardData(text: qrCode);
                            Clipboard.setData(data);
                          },
                          icon: const Icon(
                            Icons.copy,
                            size: 20,
                          )),
                      const Text(
                        "Copy",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () => _launchURL(),
                          icon: const Icon(
                            Icons.open_in_browser,
                            size: 20,
                          )),
                      const Text(
                        "Open",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            if (qrCode.isNotEmpty) {
                              Share.share(qrCode);
                            } else {
                              return null;
                            }
                          },
                          icon: const Icon(
                            Icons.share,
                            size: 20,
                          )),
                      const Text(
                        "Share",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ButtonWidget(
                color: Colors.white,
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
