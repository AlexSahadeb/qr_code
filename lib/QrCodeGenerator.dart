import "package:flutter/material.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math' as math;

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({Key? key}) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: controller.text,
              size: math.min(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height) /
                  1.3,
              backgroundColor: Color.fromARGB(179, 255, 255, 255),
            ),
            SizedBox(
              height: 30,
            ),
            buildTextField(context),
          ],
        ))));
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
                    setState(() {});
                  }))),
        ));
  }
}
