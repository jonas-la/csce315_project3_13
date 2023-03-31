import 'package:firebase_auth/firebase_auth.dart';

class login_helper{
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmailAndPassword(String user_email, String user_password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user_email,
        password: user_password,
      );
      // Handle successful login
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return false;
    }
  }


  Future<bool> is_signed_in() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("Signed in as: ");
      print(user.email);
    }else{
      print("Not logged in");
    }

    return user != null;
  }


  Future<bool> get_firebase_uid() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print("Signed in as: ");
      print(user.email);
    }else{
      print("Not logged in");
    }

    return user != null;
  }
}