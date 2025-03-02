import 'package:flutter/material.dart';

class RuleBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Last Man Standing'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: size.width,
                  height: size.height * 0.55,
                  child: Image.network(
                    'https://iili.io/3dlP50P.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width * 0.9,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Competition Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: mobile ? size.width * 0.9 : size.width * 0.55,
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "Time: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "12:00 PM – 6:00 PM\n"),
                        TextSpan(
                            text: "Registration: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "Opens at 11:00 AM (Participants are required to be on time).\n"),
                        TextSpan(
                            text: "Event Format:\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "This competition will be held on a Kilter Board set at a 30-degree angle. Participants will begin with a V1 route, progressing through increasingly difficult climbs in an elimination format until the Last Man Standing is determined.\n\n"),
                        TextSpan(
                            text: "Prize Distribution Rule:\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "• If you bust out at a certain placement, you will receive all the prizes from your tier and everything from the tiers below.\n"),
                        TextSpan(
                            text:
                                "• Example: If you finish in the Top 10, you will receive a Vola Pinch Block plus all the prizes from Top 15, Top 20, Top 25, and Participation levels."),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          "Competition Format – Last Man Standing",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          ListTile(
                            title: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "1. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:
                                        "Turn-Based Climbing: Each participant is given 1 minute to attempt their climb when it is their turn. However, once the competition reaches the top 10 climbers, each remaining participant is granted 1 minute and 30 seconds per turn.",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "2. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "3. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "4. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "5. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "6. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "7. ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          "Placements & Prizes",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          _buildAwardTable(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAwardTable(context) {
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
            _buildTableRow("Participation", "Sticker", context),
            _buildTableRow("Top 25", "Keychain + Sticker", context),
            _buildTableRow("Top 20", "Skin file + Keychain + Sticker", context),
            _buildTableRow(
                "Top 15",
                "Last Man Standing event T-shirt + Skin file + Keychain + Sticker",
                context),
            _buildTableRow(
                "Top 10",
                "Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker",
                context),
            _buildTableRow(
                "3rd Place",
                "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker",
                context),
            _buildTableRow(
                "2nd Place",
                "Evolv Zenist + 500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker",
                context),
            _buildTableRow(
                "1st Place (Winner)",
                "Evolv Phantom + 1,500 Baht + Vola Pinch Block + Last Man Standing event T-shirt + Skin file + Keychain + Sticker",
                context),
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

  Widget _buildTableRow(String placement, String prize, context) {
    return Column(
      children: [
        Row(
          children: [
            _buildTableCell(placement, context),
            Container(
              // margin: EdgeInsets.only(bottom: 20),
              color: Colors.black,
              height: 100,
              width: 0.08,
            ),
            _buildTableCell2(prize, context),
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

  Widget _buildTableCell(String text, context) {
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

  Widget _buildTableCell2(String text, context) {
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
