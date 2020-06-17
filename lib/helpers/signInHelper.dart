import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInHelper {
  static SignInHelper _signInHelper = SignInHelper._private();

  SignInHelper._private();

  static SignInHelper instance() {
    return _signInHelper; // singelethon design pattern
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  signIn(String emaill, String passwordd) async {
    auth
        .signInWithEmailAndPassword(email: emaill, password: passwordd)
        .then((oturumAcmisKullanici) {
      /* signInWithEmailAndPassword inputtan gelen email ve şifre 
      değerlerini alıp bize AuthResult tipinde kullanıcıyı döndürüyor. */
      var signUser = oturumAcmisKullanici
          .user; // oturumAcmisKullanici içindeki kullanıcı değerini alıp signUser değişkenine atıyoruz.
      if (signUser.isEmailVerified) {
         /* eğer email onaylaması yapıldı ise 
         kullanıcı başarılı bir şekilde kaydını gerçekleştiriyor. */
        debugPrint("Email onaylı kullanıcı giriş yapılıyor");
        debugPrint("uid : ${signUser.uid}");
      } else {
        debugPrint(
            "Emailinize aktivasyon postası gönderdik lütfen onaylayınız");
        signUser
            .sendEmailVerification(); 
            /*  eğer kullanıcı onaylı değilse emaile onaylama postası gönderilir. */
        auth.signOut();
      }
    }).catchError(
      (signInError) => debugPrint("E-mail yada şifre hatalı"),
    );
  }

  register(String email, String pass) async {
    var authResult = await auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .catchError((err) => debugPrint("Hata oluştu hata kodu : $err"));
     /* createUserWithEmailAndPassword inputtan gelen email ve şifre değişkenleriyle
      kayıt yapıyor ve geriye AuthResult tipinde kullanıcıyı dönüdüyor. */
    var firebaseUser = authResult
        .user; 
        /* authResult içindeki kullanıcı değerini alıp kullanıcının bilgilerine ve durumuna ulaşabilir olduk. */

    if (firebaseUser != null) {
      firebaseUser.sendEmailVerification().then((value) {
        /* kullanıcı kaydı yapıldıysa girdiği mail adresine doğrulama e-postası gönderilir. */
        auth.signOut();
        debugPrint(
            "E-mailinize aktivasyon e-postası gönderdik lütfen onaylayın");
      }).catchError((err) => debugPrint("Aktivasyon gönderirken hata çıktı"));
    } else {
      debugPrint("Bu e-mail kullanımda");
    }
  }

  forgotPass(String email) {
    auth.sendPasswordResetEmail(email: email).then((kullaniciPass) {
      /* text input içinden alınan emaili ile şifre sıfırlama bağlantısı gönderilir */
      debugPrint(
          "şifre güncelleme maili gönderildi lütfen e-mail  adresinizi kontol edin !");
      auth.signOut();
    }).catchError((e) => debugPrint(
        "Şifre güncellenirken hata çıktı ya da böyle bir e-posta adresi sistemimize kayıtlı değil"));
  }
}
