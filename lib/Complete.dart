import 'package:bedrockxunderground/main.dart';
import 'package:flutter/material.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key, required this.id});

  final String id;

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > 1200) {
      mobile = false;
      //print("Desktop");
    } else {
      mobile = true;
      //  print("Mobile");
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  image: AssetImage("assets/backgroundbk.jpg"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover),
            ),
            child: Stack(children: [
              ListView(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.white,
                    //     spreadRadius: 5,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 3), // changes position of shadow
                    //   ),
                    // ],
                    // image: const DecorationImage(
                    //     image: AssetImage("assets/background.jpg"),
                    //     alignment: Alignment.topCenter,
                    //     fit: BoxFit.cover),
                  ),
                  width: size.width,
                  height: size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: mobile ? 0 : 30),
                          alignment:
                              mobile ? Alignment.center : Alignment.centerLeft,
                          height: size.height * 0.03,
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: const AssetImage(
                                    "assets/bumplogoinvert.png"),
                                alignment: mobile
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                                fit: BoxFit.fitHeight),
                          ),
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: Container(
                    width: mobile ? size.width * 0.95 : size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: const DecorationImage(
                          image: AssetImage("assets/background.jpg"),
                          fit: BoxFit.fitWidth),
                    ),
                    // height: size.height,
                    // width: size.width,
                    child: Center(
                      child: Container(
                        width: mobile ? size.width * 0.95 : size.width * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              // Center(
                              //   child: Container(
                              //     margin: const EdgeInsets.all(8),
                              //     alignment: Alignment.center,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade700,
                              //       borderRadius: BorderRadius.circular(20),
                              //       // image: const DecorationImage(
                              //       //     image: AssetImage("assets/background.jpg"),
                              //       //     fit: BoxFit.cover),
                              //     ),
                              //     height: 5,
                              //     width: size.width * 0.3,
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Container(
                              //   height: size.height * 0.35,
                              //   width: size.width * 0.9,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20),
                              //     color: Colors.blueGrey,
                              //     image: const DecorationImage(
                              //         image: NetworkImage(
                              //             "https://iili.io/2IT2l7R.md.jpg"),
                              //         fit: BoxFit.cover),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  width: mobile
                                      ? size.width * 0.95
                                      : size.width * 0.4,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: mobile
                                              ? size.width * 0.95
                                              : size.width * 0.4,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Registration Complete!",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              const Text(
                                                "Last Man Standing – Kilter Board Competition",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Text(
                                                  //   "You will hear from the organising team soon!",
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w500,
                                                  //       fontSize: 12,
                                                  //       color:
                                                  //           Colors.grey.shade900),
                                                  // ),
                                                ],
                                              ),
                                              Text(
                                                "Your Registration ID is:"
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "${widget.id}".toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                    color: Colors.orange),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Container(
                                      //   //height: size.height * 0.06,
                                      //   // width: size.height * 0.06,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     color: Colors.blueGrey,
                                      //   ),
                                      //   child: const Padding(
                                      //     padding: EdgeInsets.all(8.0),
                                      //     child: Text(
                                      //       "1400 Baht",
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 12,
                                      //           color: Colors.white),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: size.height * 0.5,
                    width: mobile ? size.width * 0.95 : size.width * 0.5,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10)),
                      // color: Colors.blueGrey,
                      image: DecorationImage(
                          image: NetworkImage("https://iili.io/3dirWhB.jpg"),
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter),
                    ),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: size.height * 0.5,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        // color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Powered by Social Climber Nexus",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ])
            ])));
  }
}
