import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;
import 'package:screenshot/screenshot.dart';
import 'package:skany/widget/ButtonWidget.dart';
import 'package:skany/widget/custom_drawer.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({Key? key}) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  final controller = TextEditingController();

  ScreenshotController screenshotController = ScreenshotController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.white70,
            title: Text(
              "SKANY",
              style: TextStyle(color: Colors.black, fontFamily: "Sofia"),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            elevation: 0.0,
          ),
          drawer: CustomDrawer(),
          body: Center(
              child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: screenshotController,
                child: QrImage(
                  data: controller.text,
                  size: math.min(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height) /
                      1.3,
                  backgroundColor: Color.fromARGB(179, 255, 255, 255),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: isVisible,
                child: Align(
                    alignment: Alignment.center,
                    child: ButtonWidget(
                        text: "Take a Photo",
                        onClicked: () async {
                          final image = await screenshotController.capture();
                          if (image == null) return;
                          await saveImage(image);
                        })),
              ),
              SizedBox(
                height: 10,
              ),
              buildTextField(context),
            ],
          )))),
    );
  }

  saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "Screensort_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result;
  }

  buildTextField(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(19),
        child: TextField(
          controller: controller,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          decoration: InputDecoration(
              hintText: "Enter Data",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              suffixIcon: (IconButton(
                  color: Color(0XFF5fa693),
                  icon: Icon(Icons.done, size: 30),
                  onPressed: () {
                    setState(() {
                      isVisible = true;
                    });
                  }))),
        ));
  }
}
