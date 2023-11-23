String? validateRequireField(String? val, String fieldName) {
  if (fieldName == ' ') {
    return val!.isEmpty || val == ' ' ? 'This field is required!' : null;
  }

  return val!.isEmpty || val == ' ' ? '$fieldName field is required!' : null;
}

String? validatePhone(String value) {
  if (value.isEmpty || value == ' ') {
    return 'Mobile Number is required!';
  } else if (value.length != 10) {
    return 'Mobile Number must be of 10 digit!';
  } else {
    return null;
  }
}

String? validateEmail(String value) {
  if (value.isEmpty || value == ' ') {
    return 'Mobile Number is required!';
  } else if (value.contains('@') == false) {
    return 'Please enter a valid email address!';
  } else {
    return null;
  }
}
