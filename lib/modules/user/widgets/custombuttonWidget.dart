import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
   CustomButtonWidget({super.key,required this.text, required this.action});
   String text;
  void Function() action;





  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
            backgroundColor: const Color(0xff53B175),
            fixedSize: const Size(364,67)
        ),
        onPressed: action,
        child: Center(
          child: Text(text,
            style: const TextStyle(color: Colors.white,fontSize: 18),),
        )
    );
  }
}
