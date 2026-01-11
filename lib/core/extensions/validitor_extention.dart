import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension Validator on GlobalKey<FormBuilderState> {
  bool validate() {
    currentState?.validate();
    currentState?.save();
    return currentState?.isValid ?? false;
  }

  dynamic fieldValue(String fieldName) {
    return currentState?.value[fieldName];
  }

  void callIfValid(void Function() callback) {
    if (validate()) callback();
  }
}