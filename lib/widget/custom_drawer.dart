import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: null,
              accountEmail: Text("QR Code Scanner & Generator")),
          ListTile(
            onTap: () {
              LaunchReview.launch(
                  //iOSAppId: "",
                  androidAppId: "com.example.skany");
            },
            leading: Icon(Icons.star),
            title: Text("Rate Us"),
          ),
          ListTile(
            onTap: () async {
              await LaunchApp.openApp(
                androidPackageName: "com.android.application",
                openStore: true,

                // appStoreLink:
              );
            },
            leading: Icon(Icons.apps),
            title: Text("Over apps"),
          ),
          ListTile(
            onTap: () {
              SystemNavigator.pop();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
          )
        ],
      ),
    );
  }
}
