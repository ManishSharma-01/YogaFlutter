import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

Widget cardView(
  String location,
  String title,
  String description,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      MotionToast.success(description: Text("$title is clicked")).show(context);
    },
    child: SizedBox(
      child: Card(
        elevation: 5,
        // color: const Color.fromARGB(255, 226, 223, 223),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  location,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      MotionToast.success(
                              description: Text("$title is bookmarked"))
                          .show(context);
                    },
                    child: const Icon(
                      Icons.bookmark_outline,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
