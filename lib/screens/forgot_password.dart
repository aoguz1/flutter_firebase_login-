import 'package:fluter_auth/helpers/signInHelper.dart';
import 'package:fluter_auth/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPass extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parolamı Unuttum"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          TextInputWidget(
              "E-mail adresinizi giriniz", controller, false, emailvalid),
          SizedBox(
              width: MediaQuery.of(context).size.width * 3 / 4,
              child: RaisedButton(
                onPressed: forgotOnPress,
                color: Colors.green.shade200,
                child: Text("Şifre sıfırlama isteği gönder"),
              ))
        ],
      )),
    );
  }

  String emailvalid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      //regex içinde olan değerler olmadığında içeri girip ifadeyi return olarak döndürür.
      return "Geçersiz e-mail";
    } else {
      return null;
    }
  }

  void forgotOnPress() {
 SignInHelper.instance().forgotPass(emailController.text);
  }
}
