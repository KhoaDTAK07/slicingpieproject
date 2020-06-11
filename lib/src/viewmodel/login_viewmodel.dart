import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:slicingpieproject/src/helper/validation.dart';

class LoginViewModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  var emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      sink.add(Validation.validateEmail(email));
    }
  );

  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (pass, sink){
        sink.add(Validation.validatePass(pass));
      }
  );

  Stream<String> get emailStream => _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  LoginViewModel() {
    Observable.combineLatest2(_emailSubject, _passwordSubject, (email, pass) {
      return Validation.validateEmail(email) == null && Validation.validatePass(pass) == null;
    }).listen((enable) {
          btnSink.add(enable);
    });
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }

}