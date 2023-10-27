import 'package:canchas_test_app/presentation/colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const subtitleStyle =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black);

  static InputDecoration datetimeInputDecoration = InputDecoration(
      suffixIcon: const Icon(
        Icons.calendar_month,
        color: AppColors.primaryColor,
      ),
      label: const Text("Fecha"),
      hintText: "DD/MM/AAAA",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)));
}
