import 'package:bedrockxunderground/main.dart';
import 'package:flutter/material.dart';

class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<WarningScreen> createState() => _WarningScreenState();
}

class _WarningScreenState extends State<WarningScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String platformBrowserL = platformBrowser.toLowerCase();
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage(mobile ? "assets/backgroundbk.jpg" : ''),
            fit: BoxFit.cover,
            alignment: Alignment.center),
      ),
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size.width * 0.8,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.65,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          border: Border.all(color: Colors.red),
                          image: DecorationImage(
                            image: AssetImage(platformBrowser
                                        .toLowerCase()
                                        .contains("line") ==
                                    true
                                ? 'assets/line_guide.jpg'
                                : 'assets/i_guide.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(9),
                      width: size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "${platformBrowser} Detected",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Please open in an external browser like 'Chrome' or 'Safari' to avoid any registration issues.",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "You can follow the arrows or instructions above.",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          platformBrowser.toLowerCase().contains("instagram") == true
              ? Positioned(
                  top: 0.0,
                  right: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Add your onPressed code here
                        },
                      ),
                      Text(
                        "Open in external browser",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          platformBrowser.toLowerCase().contains("line") == true
              ? Positioned(
                  bottom: 00.0,
                  right: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Open in browser",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Add your onPressed code here
                        },
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
