import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:raymondrealty/apis/controllers/existing_user_check_controller.dart';
import 'package:raymondrealty/ui/cp_pages/auth/login_page.dart';
import 'package:raymondrealty/ui/cp_pages/bottom_nav/bottom_nav_bar_cp.dart';
import 'package:raymondrealty/ui/dealer_pages/auth/login_page.dart';
import 'package:raymondrealty/ui/dealer_pages/bottom_nav/bottom_nav_bar.dart';
import '../../ui/cp_pages/auth/remaining_reg_google_cp.dart';
import '../../ui/dealer_pages/auth/remaining_register_google.dart';


class AuthService{
  bool googleHaveData = false;
  UserCheckController userCheckController = UserCheckController.to;
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print('has data');
            if(userCheckController.haveAccount == true){
              return BottomNavPage(index: 0);
            }else{
              return RemainingRegister();
            }
          } else {
            print('data not stored');
            return const LoginPage();
          }
        });
  }
  handleAuthStateForCP() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if(userCheckController.haveAccount == true){
              return CPBottomNavPage(index: 0);
            }else{
              return RemainingRegGoogleCP();
            }
          } else {
            return const CPLoginPage();
          }
        });
  }
  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle(String type) async {
      await signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
          scopes: <String>["email"]
      ).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    print( googleAuth.accessToken);
    print( 'my token id :${googleAuth.idToken}');

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await userCheckController.checkUser(googleUser.email,type, googleUser.displayName.toString());
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  signOut() async {
    if(FirebaseAuth.instance.currentUser == null ){
      print('no google account');
      print(FirebaseAuth.instance.currentUser);
     // print(googleSignIn.currentUser!.email.toString());
    }else{
    print('logging out');
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    }
  }
}