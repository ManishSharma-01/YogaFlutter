import 'package:fitbit/features/home/presentation/view/bottom_view/report_issues_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportView extends ConsumerStatefulWidget {
  const SupportView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SupportViewState();
}

class _SupportViewState extends ConsumerState<SupportView> {
  var gap = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                gap,
                gap,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 110, 110),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                gap,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Customer Support, Feedbacks, FAQs',
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 110, 110),
                      fontSize: 18,
                    ),
                  ),
                ),
                gap,
                const Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookMessenger,
                    ),
                    Text('  Manish Sharma (Facebook, Messenger)')
                  ],
                ),
                gap,
                const Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.whatsapp,
                    ),
                    Text('  9810081542'),
                    Text(
                      '  (WhatsApp - Chat Only)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    ),
                  ],
                ),
                gap,
                const Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.viber,
                    ),
                    Text('  9863493234'),
                    Text(
                      '  (Viber - Chat Only)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    ),
                  ],
                ),
                gap,
                const Row(
                  children: [
                    Icon(
                      Icons.email,
                    ),
                    Text('  manish@gmail.com'),
                    Text(
                      '  (Email)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    )
                  ],
                ),
                gap,
                const Row(
                  children: [
                    Icon(
                      Icons.phone,
                    ),
                    Text('  9865784578'),
                    Text(
                      '  (Phone Number)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 110, 110),
                      ),
                    )
                  ],
                ),
                gap,
                gap,
                const Divider(
                  color: Colors.black,
                ),
                gap,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportIssuesView()),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              size: 35,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Report Issues',
                                  style: TextStyle(
                                    fontSize: 21,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '        We would love to hear from you',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 112, 110, 110),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
