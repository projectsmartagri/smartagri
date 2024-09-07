import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomPhoneFormField extends StatelessWidget {
  final PhoneController controller;
  final String? Function(PhoneNumber?)? validator;
  final ValueChanged<PhoneNumber?>? onChanged;

  const CustomPhoneFormField({
    required this.controller,
    this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      countrySelectorNavigator: const CountrySelectorNavigator.page(),
      enabled: true,
      isCountrySelectionEnabled: true,
      isCountryButtonPersistent: true,
      countryButtonStyle: const CountryButtonStyle(
        showDialCode: true,
        showIsoCode: true,
        showFlag: true,
        flagSize: 16,
      ),
    );
  }
}
