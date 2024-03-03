import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportIssuesView extends ConsumerStatefulWidget {
  const ReportIssuesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportIssuesViewState();
}

class _ReportIssuesViewState extends ConsumerState<ReportIssuesView> {
  var gap = const SizedBox(
    height: 20,
  );

  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 110, 110),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              gap,
              gap,
              gap,
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Report Issues',
                  style: TextStyle(
                    color: Color.fromARGB(255, 112, 110, 110),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              gap,
              TextFormField(
                controller: subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 120, 120, 120),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(7, 3, 12, 1), width: 2),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              gap,
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0, 100.0, 20.0, 10.0),
                  labelText: 'Message',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 120, 120, 120),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(7, 3, 12, 1), width: 2),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
              gap,
              gap,
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 112, 110, 110),
                  ),
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
