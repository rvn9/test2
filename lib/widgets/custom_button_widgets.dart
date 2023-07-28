import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  const CustomButtonWidget(
      {super.key, required this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onClick,
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }
}
