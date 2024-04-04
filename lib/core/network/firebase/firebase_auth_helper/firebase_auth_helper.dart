import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../error/exceptions.dart';

class GoogleUserInfo extends Equatable{
  final String name;
  final String userId;
  final String email;
  const GoogleUserInfo({required this.email,required this.name,required this.userId});

  @override
  List<Object?> get props => [name,userId,email];
}

class FirebaseAuthHelper {


  Future<void> sendEmailVerification()async{
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      throw const AuthanticationException(message: "Failed At Send Email Verification, Please Try Again");
    }
  }

  Future<User>checkEmailVerification()async{
    try {
      await FirebaseAuth.instance.currentUser!.reload();
      return FirebaseAuth.instance.currentUser!;
    } catch (e) {
      
      throw const AuthanticationException(message: "Failed At Check Email Verification, Please Try Again");
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({required String email,required String password}) async{
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const AuthanticationException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw const AuthanticationException(message: 'The account already exists for that email.');
      }else{
        throw const AuthanticationException(message: "Failed At Sign Up, Please Try Again");
      }
    } catch (e) {
      throw const AuthanticationException(message: "Failed At Sign Up, Please Try Again");
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({required String email,required String password})async{
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const AuthanticationException(message: 'No user found for that email.' );
      } else if (e.code == 'wrong-password') {
        throw const AuthanticationException(message: 'Wrong password provided for that user.' );
      }
      throw const AuthanticationException(message: "Failed At Sign In, Please Try Again");
    }catch(ex){
      throw const AuthanticationException(message: "Failed At Sign In, Please Try Again");
    }
  }

  Future<GoogleUserInfo> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser!=null){
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
        User user=userCredential.user!;
        return GoogleUserInfo(email: user.email??"", name: user.displayName??"", userId: user.uid);
      }
      throw const AuthanticationException(message: "Failed At Sign In With Google, Please Try Again");
    } catch (e) {
      
      throw const AuthanticationException(message: "Failed Google Authantication, Please Try Again");
    }
  }

  Future<void> emailSignOut() async{
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw const AuthanticationException(message: "Failed Sign Out, Please Try Again");
    }
  }
  
  Future<void> googleSignOut()async {
    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      throw const AuthanticationException(message: "Failed Sign Out, Please Try Again");
    }
  }

  Future<void> deleteUserAccount()async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

}
