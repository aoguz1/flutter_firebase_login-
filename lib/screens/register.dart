import 'package:fluter_auth/helpers/signInHelper.dart';
import 'package:fluter_auth/screens/forgot_password.dart';
import 'package:fluter_auth/widgets/ext_floating.dart';
import 'package:fluter_auth/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kayıt Ol")),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextInputWidget("Lütfen E-mailinizi giriniz", email,
                          false, emailvalid),
                      TextInputWidget(
                          "Şifrenizi giriniz", pass, true, passvalid),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ExtendedFloatingBtn(
                              "kayıttt", onPressRegister, "Kayıt Ol"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

 

  String emailvalid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      /*  regex içinde olan değerler olmadığında 
     içeri girip ifadeyi return olarak döndürür. */
      return "Geçersiz e-mail";
    } else {
      return null;
    }
  }

  String passvalid(String valid) {
    if (valid.length <= 6) {
      return "Lütfen 6 karakterden fazla değer giriniz";
    } else {
      return null;
    }
  }

  onPressRegister() async {
    SignInHelper.instance().register(email.text, pass.text);
    // 
  }
}
