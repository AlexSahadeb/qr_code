import "package:flutter/material.dart";

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  // final Color color;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    //required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ))),
    );
    // return MaterialButton(
    //   child: Text(
    //  text,
    //    style: TextStyle(fontSize: 20),
    //   ),
    //   shape: StadiumBorder(),
    //   color: color,
    //   //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   textColor: Colors.black,
    //   onPressed: onClicked,
    // );
  }
}

class IconButtonWidget extends StatelessWidget {
  final String text;
  IconData icon;
  final VoidCallback onClicked;

  IconButtonWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClicked,
      icon: Icon(
        icon,
        size: 20,
      ),
      label: Text(
        text,
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ))),
    );
  }
}
