import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListScreenWidget extends StatelessWidget {
  final String message;
  const EmptyListScreenWidget({
    super.key,
    required  this.message,
  });

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: height1 * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie_animation/empty_state.json',
                width: width1 * 0.6,
                height: height1 * 0.25,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      );
  }
}