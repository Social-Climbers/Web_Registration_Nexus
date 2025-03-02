import 'package:bedrockxunderground/Complete.dart';
import 'package:bedrockxunderground/main.dart';
import 'package:bedrockxunderground/paymentQR.dart';
import 'package:bedrockxunderground/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.title});

  final String title;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int number = 0;
  bool uploaded = false;
  bool paymentError = false;
  bool validationError = false;
  int climbingDays = 0;
  String highestGrade = 'V0';

  @override
  void initState() {
    paymentState = false;
    countProducts();
    print(number);

    highestGrade = 'V0';
    // TODO: implement initState
    super.initState();
  }

  final CollectionReference<Map<String, dynamic>> productList =
      FirebaseFirestore.instance.collection('registration');

  Future<int?> countProducts() async {
    AggregateQuerySnapshot query = await productList.count().get();
    debugPrint('The number of products: ${query.count}');
    number = query.count!;
    return query.count;
  }

  bool loading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController climbingduration = TextEditingController();

  bool outdoorBeforeY = false;
  bool kkbeforeY = false;
  bool injuryY = false;
  bool outdoorBeforeN = false;
  bool kkbeforeN = false;
  bool injuryN = false;
  bool topRopein = false;
  bool topRopeout = false;
  bool boulderin = false;
  bool boulderout = false;
  bool leadin = false;
  bool leadout = false;

  bool friends = false;
  bool facebook = false;
  bool Instagram = false;
  bool google = false;
  bool others = false;
  bool gyms = false;
  bool priceA = true;
  bool priceB = false;
  bool bank = true;
  bool cash = false;
  String selectedFile = '';

  // Uint8List? image;
  String imagepath = '';

  Uint8List? image;

  Future<void> _selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.any, allowMultiple: false);

    var fileBytes = result!.files.first.bytes;
    var fileName =
        "${firstName.text}${lastName.text}-${result.files.first.name}";

    // upload file
    await FirebaseStorage.instance
        .ref('uploads/$fileName')
        .putData(fileBytes!)
        .then((onValue) async {
      final url = await FirebaseStorage.instance
          .ref('uploads/$fileName')
          .getDownloadURL();
      sliplink = url;
      setState(() {
        print(url);
        image = fileBytes;
      });
    });
  }

  String sliplink = '';
  bool paymentState = false;

  // Function to validate inputs
  bool validateInputs() {
    print("First Name: ${firstName.text.isEmpty}");
    print("Last Name: ${lastName.text.isEmpty}");
    print("Age: ${age.text.isEmpty}");
    print("Email: ${email.text.isEmpty}");
    print("Phone Number: ${phoneNumber.text.isEmpty}");
    print("Climbing Duration: ${climbingduration.text.isEmpty}");
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        age.text.isEmpty ||
        email.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        climbingduration.text.isEmpty ||
        highestGrade.toLowerCase() == 'v0') {
      print("Nothing is empty");
      return false;
    }
    print("empty");
    return true;
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    age.dispose();
    email.dispose();
    phoneNumber.dispose();
    climbingduration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > 1200) {
      mobile = false;
      //  print("Desktop");
    } else {
      mobile = true;
      //   print("Mobile");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.black,
              // image: DecorationImage(
              //     image: AssetImage("assets/backgroundbk.jpg"),
              //     alignment: Alignment.topCenter,
              //     fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: mobile ? size.width * 0.95 : size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          // image: const DecorationImage(
                          //     image: AssetImage("assets/background.jpg"),
                          //     fit: BoxFit.fitWidth),
                        ),
                        // height: size.height,
                        // width: size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: BorderRadius.circular(20),
                                    // image: const DecorationImage(
                                    //     image: AssetImage("assets/background.jpg"),
                                    //     fit: BoxFit.cover),
                                  ),
                                  height: 5,
                                  width: size.width * 0.3,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: mobile
                                    ? size.width * 0.9
                                    : size.width * 0.55,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: mobile
                                            ? size.width * 0.9
                                            : size.width * 0.55,
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Last Man Standing – Kilter Board Competition",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Type:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  " Friendly Competition",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.blueGrey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
                                    "Event Information:",
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blueGrey),
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(4),
                                              child: const Icon(
                                                Icons.pin_drop_outlined,
                                                size: 20,
                                                color: Colors.white,
                                              )),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Location",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "Kilterboard at Stonegoat Climbing Gym, Bangkok",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      BorderRadius.circular(10),
                                                  color: Colors.blueGrey),
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.all(4),
                                              child: const Icon(
                                                Icons.calendar_month,
                                                size: 20,
                                                color: Colors.white,
                                              )),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "22 March 2025",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                    "Please Enter your details:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  width: mobile
                                      ? size.width * 0.9
                                      : size.width * 0.55,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: firstName,
                                            decoration: const InputDecoration(
                                                labelText: "First Name"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: lastName,
                                            decoration: const InputDecoration(
                                                labelText: "Last Name"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            controller: age,
                                            decoration: const InputDecoration(
                                                labelText: "Age"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: email,
                                            decoration: const InputDecoration(
                                                labelText: "Email"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            controller: phoneNumber,
                                            decoration: const InputDecoration(
                                                labelText: "Phone Number"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: mobile
                                        ? size.width * 0.9
                                        : size.width * 0.55,
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text(
                                      "Your climbing experiences:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mobile
                                        ? size.width * 0.9
                                        : size.width * 0.55,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            "Have you ever on the kilterboard before?:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: outdoorBeforeY,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        outdoorBeforeY =
                                                            !outdoorBeforeY;
                                                        if (outdoorBeforeY ==
                                                            true) {
                                                          outdoorBeforeN =
                                                              false;
                                                        }
                                                      });
                                                    }),
                                                const Text("Yes")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: outdoorBeforeN,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        outdoorBeforeN =
                                                            !outdoorBeforeN;
                                                        if (outdoorBeforeN ==
                                                            true) {
                                                          outdoorBeforeY =
                                                              false;
                                                        }
                                                      });
                                                    }),
                                                const Text("No")
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "What's your highest Kilterboard grade (V0-V17):",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Please do not leave at V0",
                                                  style: TextStyle(
                                                      color: Colors.red[900],
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.9,
                                                child: DropdownButton<String>(
                                                  isExpanded: true,
                                                  value: highestGrade,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      highestGrade = newValue!;
                                                    });
                                                  },
                                                  items: List.generate(18,
                                                      (index) => 'V$index').map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(8.0),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       const Text(
                                        //         "How many days a week do you climb on the Kilterboard:",
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 16),
                                        //       ),
                                        //       SizedBox(
                                        //         width: size.width * 0.9,
                                        //         child: DropdownButton<int>(
                                        //           isExpanded: true,
                                        //           value: climbingDays,
                                        //           onChanged: (int? newValue) {
                                        //             setState(() {
                                        //               climbingDays = newValue!;
                                        //             });
                                        //           },
                                        //           items: List.generate(
                                        //                   8, (index) => index)
                                        //               .map<
                                        //                       DropdownMenuItem<
                                        //                           int>>(
                                        //                   (int value) {
                                        //             return DropdownMenuItem<
                                        //                 int>(
                                        //               value: value,
                                        //               child: Text(
                                        //                   value.toString()),
                                        //             );
                                        //           }).toList(),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: mobile
                                                    ? size.width * 0.9
                                                    : size.width * 0.55,
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: const Text(
                                                  "How long have you been climbing:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: TextField(
                                                  controller: climbingduration,
                                                  decoration:
                                                      const InputDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            "Have you ever climbed at Stonegoat before?:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: kkbeforeY,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        kkbeforeY = !kkbeforeY;
                                                        if (kkbeforeY == true) {
                                                          kkbeforeN = false;
                                                        }
                                                      });
                                                    }),
                                                const Text("Yes")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: kkbeforeN,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        kkbeforeN = !kkbeforeN;
                                                        if (kkbeforeN == true) {
                                                          kkbeforeY = false;
                                                        }
                                                      });
                                                    }),
                                                const Text("No")
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: mobile
                                              ? size.width * 0.9
                                              : size.width * 0.55,
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            "Do you currently have any injuries?:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: injuryY,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        injuryY = !injuryY;
                                                        if (injuryY == true) {
                                                          injuryN = false;
                                                        }
                                                      });
                                                    }),
                                                const Text("Yes")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                    value: injuryN,
                                                    onChanged: (onChanged) {
                                                      setState(() {
                                                        injuryN = !injuryN;
                                                        if (injuryN == true) {
                                                          injuryY = false;
                                                        }
                                                      });
                                                    }),
                                                const Text("No")
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: mobile
                                    ? size.width * 0.9
                                    : size.width * 0.55,
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  "Where did you hear about the event:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: mobile
                                    ? size.width * 0.9
                                    : size.width * 0.55,
                                child: Wrap(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: friends,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                friends = !friends;
                                              });
                                            }),
                                        const Text("Friends")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: facebook,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                facebook = !facebook;
                                              });
                                            }),
                                        const Text("Facebook")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: Instagram,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                Instagram = !Instagram;
                                              });
                                            }),
                                        const Text("Instgram")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: google,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                google = !google;
                                              });
                                            }),
                                        const Text("Google")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: gyms,
                                            onChanged: (onChanged) {
                                              gyms = !gyms;
                                              setState(() {});
                                            }),
                                        const Text("Gyms")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: others,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                others = !others;
                                              });
                                            }),
                                        const Text("Others")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Payment for",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                                value: priceA,
                                                onChanged: (onChanged) {
                                                  setState(() {
                                                    priceA = !priceA;
                                                    if (priceA == true) {
                                                      priceB = false;
                                                    }
                                                  });
                                                }),
                                            const Text(
                                              "Entry Fee:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            const Text(
                                              "300 Baht",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.blueGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Text(
                                "(Does not include gym pass)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              Container(
                                width: mobile
                                    ? size.width * 0.9
                                    : size.width * 0.55,
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: bank,
                                            onChanged: (onChanged) {
                                              setState(() {
                                                paymentState = false;
                                                bank = !bank;
                                                if (bank == true) {
                                                  cash = false;
                                                }
                                              });
                                            }),
                                        const Text(
                                          "Bank Transfer Payment:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              cash
                                  ? const SizedBox()
                                  : Container(
                                      width: mobile
                                          ? size.width * 0.9
                                          : size.width * 0.55,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Column(
                                            children: [
                                              Text(
                                                "Account Details:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "183-141207-3",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "Vichaya t.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "krungsri bank",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            QRExapndPage(
                                                              "https://iili.io/2e5HsPn.jpg",
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: size.height * 0.2,
                                                    width: size.height * 0.2,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.blueGrey,
                                                      image: const DecorationImage(
                                                          image: NetworkImage(
                                                              "https://iili.io/2e5HsPn.jpg"),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  const Text("Tap to Exapnd")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),

                              cash
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: mobile
                                            ? size.width * 0.9
                                            : size.width * 0.55,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Please upload your payment slip",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            paymentState
                                                ? const Text(
                                                    "Payment Slip Uploaded",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: Colors.green),
                                                  )
                                                : const SizedBox(),
                                            paymentError
                                                ? const Text(
                                                    "Payment Error: Please try again",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Colors.red),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (image != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.memory(
                                          image!,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(selectedFile)
                                      ],
                                    ),
                                  ),
                                ),
                              cash
                                  ? const SizedBox()
                                  : Center(
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          _selectFile().then((v) {
                                            setState(() {
                                              uploaded = true;
                                              paymentState = true;
                                              loading = false;
                                            });
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            // image: const DecorationImage(
                                            //     image: AssetImage("assets/background.jpg"),
                                            //     fit: BoxFit.cover),
                                          ),
                                          height: mobile
                                              ? size.height * 0.06
                                              : size.height * 0.04,
                                          width: mobile
                                              ? size.width * 0.6
                                              : size.width * 0.3,
                                          child: const Text(
                                            "Upload",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                              // const SizedBox(
                              //   height: 20,
                              // ),

                              SizedBox(
                                height: size.height * 0.04,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // image: const DecorationImage(
                          //     image: AssetImage("assets/background.jpg"),
                          //     fit: BoxFit.cover),
                        ),
                        height: size.height * 0.08,
                        width: mobile ? size.width * 0.95 : size.width * 0.6,
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              int randomNumber = 1111 +
                                  (9999 - 1111) *
                                      (DateTime.now().millisecondsSinceEpoch %
                                          1000) ~/
                                      1000;
                              String package = '';
                              String paymentType = '';
                              String id = "UCK${randomNumber}";
                              print(id);
                              if (validateInputs() == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please fill in all the details"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else if (uploaded == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please Upload your payment slip"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              if (uploaded && validateInputs()) {
                                setState(() {
                                  loading = true;
                                });
                                if (cash == true) {
                                  paymentType = 'cash';
                                  paymentState = true;
                                  sliplink = 'In cash';
                                } else {
                                  paymentType = 'bank';
                                }
                                if (priceA == true) {
                                  package = 'Full Package';
                                } else {
                                  package = 'Treasure Hunt Only';
                                }

                                if (paymentState == true) {
                                  bool outdoorBefore = false;
                                  if (outdoorBeforeY == true) {
                                    outdoorBefore = true;
                                  } else {
                                    outdoorBefore = false;
                                  }
                                  bool kkbefore = false;
                                  if (kkbeforeY == true) {
                                    kkbefore = true;
                                  } else {
                                    kkbefore = false;
                                  }
                                  bool injury = false;
                                  if (injury == true) {
                                    injury = true;
                                  } else {
                                    injury = false;
                                  }
                                  var db = FirebaseFirestore.instance;
                                  db
                                      .collection("KilterboardUC")
                                      .doc(id + DateTime.timestamp().toString())
                                      .set({
                                    'Timestamp': DateTime.timestamp(),
                                    'usid':
                                        id + DateTime.timestamp().toString(),
                                    'registrationId': id,
                                    'information': {
                                      'firstname': firstName.text,
                                      'lastname': lastName.text,
                                      'age': age.text,
                                      'email': email.text,
                                      'phone': phoneNumber.text,
                                    },
                                    'experience': {
                                      'highestGrade': highestGrade ?? "v0",
                                      // 'frequency': climbingDays ?? 0,
                                      'kilterBefore:': outdoorBefore,
                                      'sgBefore': kkbefore,
                                      'duration': climbingduration.text,
                                      'injury': injury,
                                      // 'skills': {
                                      //   'topRopein': topRopein,
                                      //   'outRopein': topRopeout,
                                      //   'leadin': leadin,
                                      //   'leadout': leadout,
                                      //   'boulderin': boulderin,
                                      //   'boulderout': boulderout
                                      // }
                                    },
                                    'payment': {
                                      'paymenttype': paymentType,
                                      'payment': paymentState,
                                      'sliplink': sliplink,
                                      'type': package
                                    },
                                    'hear': {
                                      'Friends': friends,
                                      'Facebook': facebook,
                                      'Instagram': Instagram,
                                      'Google': google,
                                      'Gyms': gyms,
                                      'others': others
                                    }
                                  }).then((v) {
                                    // loading = true;
                                    setState(() {});
                                    Future.delayed(
                                        const Duration(milliseconds: 4000), () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompletedPage(
                                                      id: id,
                                                    )));
                                      });
                                    });
                                  });
                                } else {
                                  setState(() {
                                    paymentError = true;
                                  });
                                }
                              }
                            },
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: uploaded && validateInputs()
                                      ? Colors.grey.shade900
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(30),
                                  // image: const DecorationImage(
                                  //     image: AssetImage("assets/background.jpg"),
                                  //     fit: BoxFit.cover),
                                ),
                                height: size.height * 0.06,
                                width: mobile
                                    ? size.width * 0.8
                                    : size.width * 0.5,
                                child: const Text(
                                  "Complete",
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
                    ),
                  ],
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Center(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //         // image: const DecorationImage(
                //         //     image: AssetImage("assets/background.jpg"),
                //         //     fit: BoxFit.cover),
                //       ),
                //       height: size.height * 0.08,
                //       width: size.width,
                //       child: Center(
                //         child: Container(
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             color: Colors.grey.shade900,
                //             borderRadius: BorderRadius.circular(30),
                //             // image: const DecorationImage(
                //             //     image: AssetImage("assets/background.jpg"),
                //             //     fit: BoxFit.cover),
                //           ),
                //           height: size.height * 0.06,
                //           width: size.width * 0.8,
                //           child: const Text(
                //             "Complete",
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w300,
                //                 fontSize: 18,
                //                 color: Colors.white),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          loading ? const Splash() : const SizedBox()
        ],
      ),
    );
  }
}
