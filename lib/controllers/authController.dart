import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/constants/controllers.dart';
import 'package:untitled/constants/firebase.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/screens/authentication/auth.dart';
import 'package:untitled/screens/home/home.dart';
import 'package:untitled/utils/helpers/showLoading.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAll(() => AuthenticationScreen());
    } else {
      userModel.bindStream(listenToUser());
      //_initializeUserModel(user.uid);
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    try {
      showLoading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
      showLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _addUserToFirestore(_userId);
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "${e.toString()}");
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set(
        {"name": name.text.trim(), "id": userId, "email": email.text.trim(),
        "cart":[]
        });
  }

  _initializeUserModel(String userId) async {
    userModel.value = await firebaseFirestore
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
    print("Last value ${userModel.value}");
  }

  void updateUserData(Map<String,dynamic> data){
    logger.i("UPDATED ${userModel.value.cart}");
    firebaseFirestore.collection(usersCollection).doc(firebaseUser.value.uid)
        .update(data);

  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));


  _clearControllers(){
    name.clear();
    email.clear();
    password.clear();
  }
}
