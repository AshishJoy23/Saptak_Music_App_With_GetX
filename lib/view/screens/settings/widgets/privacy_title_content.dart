import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class PrivacyPolicyTitleAndContent extends StatelessWidget {
  const PrivacyPolicyTitleAndContent({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final width1 = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width1 * 0.04,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(width1 * 0.03),
          child: ReadMoreText(
            message,
            trimLines: 5,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            lessStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            moreStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            style:
                const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
