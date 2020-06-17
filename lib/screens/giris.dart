import 'package:fluter_auth/helpers/signInHelper.dart';
import 'package:fluter_auth/screens/forgot_password.dart';
import 'package:fluter_auth/screens/register.dart';
import 'package:fluter_auth/widgets/ext_floating.dart';
import 'package:fluter_auth/widgets/text_input.dart';
import 'package:flutter/material.dart';

class GirisView extends StatelessWidget {
  var formkey = GlobalKey<FormState>(); 
  // formumuzdaki olayları yönetebilmemizi sağlar
  var emailcontroller = TextEditingController(); 
  var passcontroller = TextEditingController(); 
  // inputardaki verileri almamızı sağlayan değilken
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yap"),
      ),
      body: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    TextInputWidget(
                      "Lütfen E-Mailinizi giriniz",
                      emailcontroller,
                      false,
                      emailvalid,
                    ),
                    TextInputWidget(
                      "Şifrenizi Giriniz",
                      passcontroller,
                      true,
                      passvalid,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ExtendedFloatingBtn("Giriş", singIn, "Giriş Yap"),
                        ExtendedFloatingBtn("Register", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                          );
                        }, "Kayıt Ol"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPass(),
                            ),
                          );
                        },
                        child: Text("Şifremi Unuttum"),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  singIn() {
    formkey.currentState.validate();
    SignInHelper.instance().signIn(emailcontroller.text, passcontroller.text);
    // Singe
  }

  String passvalid(String valid) {
    if (valid.length <= 6) {
      return "Lütfen 6 karakterden fazla değer giriniz";
    } else {
      return null;
    }
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
}
