import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';

class CategoryDropdownFormField extends StatelessWidget {
  // final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<String> categories = [
    'Furniture',
    'Footwear',
    'Safety Gear',
    'Bags',
  ];
  CategoryDropdownFormField({
    super.key,
    // required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // initialValue: value,
      validator: validator,
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(15.r),
      dropdownColor: AppConstants.primaryColor,

      iconEnabledColor: AppConstants.primaryColor,

      decoration: InputDecoration(
        label: const Text('Category', style: TextStyle(color: Colors.black)),
        hint: Text(
          'Not Selected',
          style: TextStyle(color: AppConstants.whiteColorP5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.tertiaryColor),
        ),
      ),
      // items: const [
      //   DropdownMenuItem(
      //     value: 'male',
      //     child: Text(
      //       'Male',
      //       style: TextStyle(color: AppConstants.accentColor),
      //     ),
      //   ),
      //   DropdownMenuItem(
      //     value: 'female',
      //     child: Text('Female', style: TextStyle(color: Colors.pinkAccent)),
      //   ),
      //   DropdownMenuItem(
      //     value: 'other',
      //     child: Text('Other', style: TextStyle(color: Colors.yellowAccent)),
      //   ),
      // ],
      items: categories
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
    );
  }
}
