import 'package:flutter/foundation.dart';

const inputEmailValid = "Vui lòng nhập đúng email";
const inputPasswordLength = "Mật khẩu phải dài hơn 6 ký tự";
const passwordMaxLength = 6;
const inputPhoneValid = "Vui lòng đúng số điện thoại!";
const validationTextEmpty = "Vui lòng nhập";

const validEmail =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
const validPhone =
    r"^[+]?[(]?[0-9]{2,4}[)]?[-\s.]?[0-9]{3,}?[-\s.]?[0-9]{3,}?[-\s.*]?[0-9]{1,}$";

class Validation {
  static String validationEmail({@required String email}) {
    final messageValidEmpty = validationIsEmpty(value: email, label: "email");
    if (messageValidEmpty != null) return messageValidEmpty;
    final _reg = RegExp(validEmail).hasMatch(email);
    if (!_reg) return inputEmailValid;
    return null;
  }

  static String validationPassword({@required String password}) {
    final messageValidEmpty =
        validationIsEmpty(value: password, label: "mật khẩu");
    if (messageValidEmpty != null) return messageValidEmpty;
    if (password.length < 6) return inputPasswordLength;
    return null;
  }

  static String validationPhone({@required String phone}) {
    final messageValidEmpty =
        validationIsEmpty(value: phone, label: "số điện thoại");
    if (messageValidEmpty != null) return messageValidEmpty;
    final _reg = RegExp(validPhone).hasMatch(phone);
    if (!_reg) return inputPhoneValid;
    return null;
  }

  static String validationIsEmpty(
      {@required dynamic value, @required String label}) {
    if (value == null || value.isEmpty) return "$validationTextEmpty $label";
    return null;
  }

  static String validationLength(
      {@required String value, @required int length, @required String label}) {
    if (value == null || length == null || label == null) return null;
    if (value.length < length)
      return "${label.replaceRange(0, 1, label.substring(0, 1))} phải dài hơn $length ký tự ";
    return null;
  }
}
