import 'package:bedrockxunderground/main.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: mobile ? size.width * 0.1 : size.width * 0.4,
                height: mobile ? size.width * 0.1 : size.width * 0.4,
                child: const CircularProgressIndicator(
                    strokeWidth: 10,
                    color: Colors.white,
                    strokeCap: StrokeCap.round),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Loading - Please don't refresh or close this page",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
