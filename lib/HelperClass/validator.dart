import 'dart:async';

class Validator {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){
      if (name.isEmpty) {
        sink.addError("nanme should not be empty");
      } else {
        sink.add(name);
      }
    }
  );

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink){
      if (phone.isEmpty) {
        sink.addError("Phone should not be empty");
      } else if (phone.length != 9) {
        sink.addError("Phone length should be 9 digit");
      } else {
        sink.add(phone);
      }
    }
  );

  final validateCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (code, sink){
      if (code.isEmpty) {
        sink.addError("verification code should not be empty");
      } else {
        sink.add(code);
      }
    }
  );
}