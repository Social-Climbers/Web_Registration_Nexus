import 'dart:html' as html;

import 'package:bedrockxunderground/Complete.dart';
import 'package:bedrockxunderground/form.dart';
import 'package:bedrockxunderground/map_style.dart';
import 'package:bedrockxunderground/rulebook.dart';
import 'package:bedrockxunderground/splashscreen.dart';
import 'package:bedrockxunderground/viewRegistration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'firebase_options.dart';

bool mobile = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last Man Standing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          // RuleBookPage()
          //CompletedPage(id: '')

          const MyHomePage(title: 'Last Man Standing by Underground'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFull = false;
  int climberCap = 0;
  bool _loading = true;
  late GoogleMapController mapController;
  String des =
      """This competition will be held on a Kilter Board set at a 30-degree angle. Participants will begin with a V1 route, progressing through increasingly difficult climbs in an elimination format until the Last Man Standing is determined""";
  Set<Marker> markers = {};
  Future<bool> checkKilterboardFull() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("KilterboardUC").get();
      print(snapshot.docs.length);
      climberCap = snapshot.docs.length;
      isFull = snapshot.docs.length >= 30;
      return isFull;
    } catch (e) {
      print("Error checking KilterboardUC count: $e");
      return false; // Default to false in case of an error
    }
  }

  @override
  void initState() {
    super.initState();
    checkKilterboardFull().then((onValue) {
      print("Event full:" + onValue.toString());
      markers.add(
        Marker(
            markerId: MarkerId('sf_pin'),
            position: LatLng(13.7167551, 100.5904526),
            infoWindow: InfoWindow(
              title: 'Stonegoat Climb',
            ),
            icon: BitmapDescriptor.defaultMarker // Custom color
            ),
      );
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          _loading = false;
        });
      });
    });

    // Precache images
    // precacheImage(const NetworkImage("https://iili.io/2eRSO5x.png"), context);
    // precacheImage(const NetworkImage("https://iili.io/2e56QBp.jpg"), context);
    // precacheImage(const NetworkImage("https://iili.io/2e2Tad7.png"), context);
    // precacheImage(const AssetImage("assets/backgroundbk.jpg"), context);
    // precacheImage(const AssetImage("assets/bumplogoinvert.png"), context);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print(size.width);
    if (size.width > 1200) {
      mobile = false;
      //  print("Desktop");
    } else {
      mobile = true;
      //   print("Mobile");
    }
    return Scaffold(
      body: _loading
          ? Splash()
          : Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                    image: AssetImage("assets/backgroundbk.jpg"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
                            mainAxisAlignment: mobile
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RuleBookPage()),
                                  );
                                },
                                child: Icon(Icons.info),
                              ),
                              Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: mobile ? 0 : 30),
                                  alignment: mobile
                                      ? Alignment.center
                                      : Alignment.centerLeft,
                                  height: size.height * 0.03,
                                  width: size.width * 0.6,
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewRegistrationPage()),
                                  );
                                },
                                child: Icon(Icons.data_array),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: size.height < 700
                            ? size.height * 0.875
                            : size.height > 900
                                ? size.height * 0.69
                                : size.height * 0.72,
                        width: mobile ? size.width : size.width * 0.6,
                        decoration: const BoxDecoration(
                          // borderRadius:
                          //     BorderRadius.only(topLeft: Radius.circular(10)),
                          // color: Colors.blueGrey,
                          image: DecorationImage(
                              image:
                                  NetworkImage("https://iili.io/3dirWhB.jpg"),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter),
                        ),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          height: size.height * 0.72,
                          width: size.width,
                          decoration: BoxDecoration(
                            // color: mobile
                            //     ? Colors.black.withOpacity(0.3)
                            //     : Colors.black.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10)),
                            // color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                mobile
                                    ? const SizedBox()
                                    : Container(
                                        alignment: Alignment.bottomCenter,
                                        height: size.height * 0.45,
                                        width: mobile
                                            ? size.width
                                            : size.width * 0.6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.blueGrey,
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  "https://iili.io/3dlP50P.jpg"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center),
                                        ),
                                      ),
                                Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    width: mobile
                                        ? size.width * 1
                                        : size.width * 0.6,
                                    // height: size.height * 0.15,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: mobile
                                                ? size.width * 0.9
                                                : size.width * 0.55,
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              mobile ? 10 : 20,
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            width: mobile
                                                                ? size.width *
                                                                    0.9
                                                                : size.width *
                                                                    0.55,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration: BoxDecoration(
                                                                // image: const DecorationImage(
                                                                //     image: AssetImage(
                                                                //         "assets/backgroundbk.jpg"),
                                                                //     fit: BoxFit
                                                                //         .fitWidth),
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Colors.blueGrey),
                                                            child: const Center(
                                                              child: Text(
                                                                "Event",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              mobile ? 10 : 20,
                                                        ),
                                                        SizedBox(
                                                          width: mobile
                                                              ? size.width * 0.9
                                                              : size.width *
                                                                  0.55,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width: size
                                                                              .width *
                                                                          0.9,
                                                                      child:
                                                                          const Text(
                                                                        "Last Man Standing – Kilter Board Competition",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Text(
                                                                          "Hosted by:",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                              color: Colors.black),
                                                                        ),
                                                                        Text(
                                                                          " Underground Climb",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                              color: Colors.cyan[300]),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    const Row(
                                                                      children: [
                                                                        Text(
                                                                          "Event Type:",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 10,
                                                                              color: Colors.black),
                                                                        ),
                                                                        Text(
                                                                          " Friendly Competition",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 10,
                                                                              color: Colors.blueGrey),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              mobile
                                                                  ? const SizedBox()
                                                                  : Center(
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => const FormPage(
                                                                                        title: '',
                                                                                      )));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade900,
                                                                            borderRadius:
                                                                                BorderRadius.circular(30),
                                                                            // image: const DecorationImage(
                                                                            //     image: AssetImage("assets/background.jpg"),
                                                                            //     fit: BoxFit.cover),
                                                                          ),
                                                                          height:
                                                                              size.height * 0.04,
                                                                          width:
                                                                              size.width * 0.2,
                                                                          child:
                                                                              const Text(
                                                                            "Register",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w300,
                                                                                fontSize: 12,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: mobile ? size.width : size.width * 0.6,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            // image: const DecorationImage(
                            //     image: AssetImage("assets/background.jpg"),
                            //     fit: BoxFit.fitWidth),
                          ),
                          // height: size.height,
                          // width: size.width,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
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
                                Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    // image: DecorationImage(
                                    //     image: AssetImage("assets/background.jpg"),
                                    //     alignment: Alignment.topCenter,
                                    //     fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "About the Event:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.blueGrey),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: const Icon(
                                                        Icons
                                                            .confirmation_number_rounded,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                  Row(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Competition Price",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              "300 Baht",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     Container(
                                                      //         decoration: BoxDecoration(
                                                      //             borderRadius:
                                                      //                 BorderRadius
                                                      //                     .circular(
                                                      //                         10),
                                                      //             color: Colors
                                                      //                 .blueGrey),
                                                      //         padding:
                                                      //             const EdgeInsets
                                                      //                 .all(8),
                                                      //         margin: const EdgeInsets
                                                      //             .all(4),
                                                      //         child: const Icon(
                                                      //           Icons
                                                      //               .confirmation_number_rounded,
                                                      //           size: 20,
                                                      //           color: Colors.white,
                                                      //         )),
                                                      //     const Padding(
                                                      //       padding:
                                                      //           EdgeInsets.all(8.0),
                                                      //       child: Column(
                                                      //         crossAxisAlignment:
                                                      //             CrossAxisAlignment
                                                      //                 .start,
                                                      //         children: [
                                                      //           Text(
                                                      //             "Treasure Hunt Only Price",
                                                      //             style: TextStyle(
                                                      //                 fontWeight:
                                                      //                     FontWeight
                                                      //                         .w500,
                                                      //                 fontSize: 12),
                                                      //           ),
                                                      //           Text(
                                                      //             "400 Baht",
                                                      //             style: TextStyle(
                                                      //                 fontWeight:
                                                      //                     FontWeight
                                                      //                         .w600,
                                                      //                 fontSize: 12),
                                                      //           ),
                                                      //         ],
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  "(Does not include Gym admission Fee) - Competitors if not a member of the gym already must buy their own gym pass for the day.",
                                                  style: TextStyle(
                                                      color: Colors.red[900],
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.blueGrey),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: const Icon(
                                                        Icons.pin_drop_outlined,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Location",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Kilterboard at Stonegoat Climbing Gym, Bangkok",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.blueGrey),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: const Icon(
                                                        Icons.calendar_month,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Date",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "22 March 2025",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.blueGrey),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: const Icon(
                                                        Icons.person,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Avaiable Spaces",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${30 - climberCap} /30",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            "Description:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                            width: mobile
                                                ? size.width * 0.9
                                                : size.width * 0.55,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Time: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "12:00 PM – 6:00 PM\n"),
                                                  TextSpan(
                                                      text: "Registration: ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "Opens at 11:00 AM (Participants are required to be on time).\n"),
                                                  TextSpan(
                                                      text: "Event Format:\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "This competition will be held on a Kilter Board set at a 30-degree angle. Participants will begin with a V1 route, progressing through increasingly difficult climbs in an elimination format until the Last Man Standing is determined.\n\n"),
                                                  TextSpan(
                                                      text:
                                                          "Prize Distribution Rule:\n",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "• If you bust out at a certain placement, you will receive all the prizes from your tier and everything from the tiers below.\n"),
                                                  TextSpan(
                                                      text:
                                                          "• Example: If you finish in the Top 10, you will receive a Vola Pinch Block plus all the prizes from Top 15, Top 20, Top 25, and Participation levels."),
                                                ],
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: SizedBox(
                                              width: size.width * 0.9,
                                              child: ExpansionTile(
                                                title: Text(
                                                  "Competition Format – Last Man Standing",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                children: [
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                14), // Changed font size to 14
                                                        children: [
                                                          TextSpan(
                                                            text: "1. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Turn-Based Climbing: Each participant is given 1 minute to attempt their climb when it is their turn. "
                                                                "However, once the competition reaches the top 10 climbers, each remaining participant is granted 1 minute and 30 seconds per turn.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "2. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Elimination Format: The competition follows an elimination structure, continuing until only one climber remains.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "3. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Rotational Order: Climbers take turns in a fixed rotation, ensuring each participant climbs when their turn arrives.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "4. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Mandatory Attempts: Participants must attempt their climb when it is their turn. Failing to do so may result in elimination.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "5. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Prizes for All Positions: Every position in the competition has a prize, ensuring all participants receive recognition.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "6. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Eligibility Restriction: National-level athletes are not allowed to participate in the competition.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        children: [
                                                          TextSpan(
                                                            text: "7. ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Winner Determination: The competition continues until a single climber remains, who is declared the Last Man Standing and the winner of the event.",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: ExpansionTile(
                                                title: Text(
                                                  "Placements & Prizes",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                children: [
                                                  _buildAwardTable(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Map:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  html.window.open(
                                                      'https://maps.app.goo.gl/NbwbyCgJVvnEpSxv8',
                                                      'new tab');
                                                },
                                                child: const Text(
                                                  "Open in maps",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          height: size.height * 0.3,
                                          child: GoogleMap(
                                            style: Utils.mapStyles,
                                            onMapCreated: onMapCreated,
                                            initialCameraPosition:
                                                const CameraPosition(
                                              target: LatLng(
                                                  13.7167551, 100.590458),
                                              zoom: 12.0,
                                            ),
                                            markers: markers,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width:
                                        mobile ? size.width : size.width * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: mobile
                                                ? size.width
                                                : size.width * 0.55,
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              "Organisers:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          child: Row(
                                            children: [
                                              // Column(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: [
                                              //     Row(
                                              //       children: [
                                              //         Padding(
                                              //           padding:
                                              //               const EdgeInsets.all(8.0),
                                              //           child: Container(
                                              //             height: size.height * 0.05,
                                              //             width: size.height * 0.05,
                                              //             decoration: BoxDecoration(
                                              //               borderRadius:
                                              //                   BorderRadius.circular(
                                              //                       50),
                                              //               color: Colors.blueGrey,
                                              //               image: const DecorationImage(
                                              //                   image: NetworkImage(
                                              //                       "https://iili.io/2e56QBp.jpg"),
                                              //                   fit: BoxFit.cover),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         const Padding(
                                              //           padding: EdgeInsets.all(8.0),
                                              //           child: Text(
                                              //             "Bedrock Inn",
                                              //             style: TextStyle(
                                              //                 fontWeight:
                                              //                     FontWeight.w600,
                                              //                 fontSize: 14),
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: size.height *
                                                              0.05,
                                                          width: size.height *
                                                              0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color:
                                                                Colors.blueGrey,
                                                            image: const DecorationImage(
                                                                image: NetworkImage(
                                                                    "https://iili.io/2e2Tad7.png"),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Underground Climb",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.1,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  mobile
                      ? Positioned(
                          bottom: 0,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                // image: const DecorationImage(
                                //     image: AssetImage("assets/background.jpg"),
                                //     fit: BoxFit.cover),
                              ),
                              height: size.height * 0.08,
                              width: size.width,
                              child: InkWell(
                                onTap: () {
                                  if (isFull == false) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FormPage(
                                                  title: '',
                                                )));
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isFull
                                          ? Colors.grey
                                          : Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(30),
                                      // image: const DecorationImage(
                                      //     image: AssetImage("assets/background.jpg"),
                                      //     fit: BoxFit.cover),
                                    ),
                                    height: size.height * 0.06,
                                    width: size.width * 0.8,
                                    child: Text(
                                      isFull ? "Event Full" : "Register",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
    );
  }

  // Widget _buildAwardTable() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: DataTable(
  //         columnSpacing: 16.0,
  //         columns: [
  //           DataColumn(
  //             label: Text(
  //               "Placement",
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           DataColumn(
  //             label: Text(
  //               "Prize(s) Received",
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         ],
  //         rows: [
  //           _buildTableRow("Participation", "Sticker"),
  //           _buildTableRow("Top 25", "Keychain + Sticker"),
  //           _buildTableRow("Top 20", "Skin file + Keychain + Sticker"),
  //           _buildTableRow("Top 15",
  //               "Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
  //           _buildTableRow("Top 10",
  //               "Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
  //           _buildTableRow("3rd Place",
  //               "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
  //           _buildTableRow("2nd Place",
  //               "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
  //           _buildTableRow("1st Place (Winner)",
  //               "Evolv Phantom + 1,500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAwardTable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTableHeader("Placement"),
                  _buildTableHeader("Prize(s) Received"),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 20),
              color: Colors.black,
              height: 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            _buildTableRow("Participation", "Sticker"),
            _buildTableRow("Top 25", "Keychain + Sticker"),
            _buildTableRow("Top 20", "Skin file + Keychain + Sticker"),
            _buildTableRow("Top 15",
                "Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
            _buildTableRow("Top 10",
                "Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
            _buildTableRow("3rd Place",
                "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
            _buildTableRow("2nd Place",
                "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
            _buildTableRow("1st Place (Winner)",
                "Evolv Phantom + 1,500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker"),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableRow(String placement, String prize) {
    return Column(
      children: [
        Row(
          children: [
            _buildTableCell(placement),
            Container(
              // margin: EdgeInsets.only(bottom: 20),
              color: Colors.black,
              height: 100,
              width: 0.08,
            ),
            _buildTableCell2(prize),
          ],
        ),
        Container(
          // margin: EdgeInsets.only(bottom: 20),
          color: Colors.black,
          height: 0.08,
          width: MediaQuery.of(context).size.width * 0.9,
        )
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 100, // Accommodate up to 4 lines of text
      child: Text(
        text,
        overflow: TextOverflow.visible,
        softWrap: true,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildTableCell2(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      width: MediaQuery.of(context).size.width * 0.45,
      height: 100, // Accommodate up to 4 lines of text
      child: Text(
        text,
        overflow: TextOverflow.visible,
        softWrap: true,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
