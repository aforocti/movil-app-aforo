import 'dart:async';

class Validators {


  final validarUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      sink.add(email);
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else {
        sink.addError('menos de 6 caracteres');
      }
    }
  );
}
