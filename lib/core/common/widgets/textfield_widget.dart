
import 'package:flutter/material.dart';

Widget customTextField(TextEditingController controller, String text) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
    validator: (String? value) {
      if (value!.isEmpty) {
        return 'This field is required';
      }
      return null;
    },
  );
}

//-----------------------
  //  TextFormField(
  //                     style: const TextStyle(
  //                       color: Colors.black,
  //                     ),
  //                     controller: usernameController,
  //                     decoration: const InputDecoration(
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)),
  //                       ),
  //                       labelStyle: TextStyle(color: Colors.black),
  //                       labelText: 'Username',
  //                       filled: true,
  //                       fillColor: Color.fromARGB(255, 208, 190, 190),
  //                     ),
  //                   ),
