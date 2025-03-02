import 'package:bedrockxunderground/main.dart';
import 'package:flutter/material.dart';

class QRExapndPage extends StatefulWidget {
  QRExapndPage(this.qr, {super.key});
  String qr = '';
  @override
  State<QRExapndPage> createState() => _QRExapndPageState();
}

class _QRExapndPageState extends State<QRExapndPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; // print(size.width);
    if (size.width > 1200) {
      mobile = false;
      //  print("Desktop");
    } else {
      mobile = true;
      //   print("Mobile");
    }
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        image: DecorationImage(
            image: AssetImage("assets/backgroundbk.jpg"),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover),
      ),
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  image: NetworkImage(widget.qr),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover),
            ),
            height: mobile ? size.height * 0.5 : size.height * 0.4,
            width: mobile ? size.width * 0.8 : size.height * 0.4,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    ));
  }
}
