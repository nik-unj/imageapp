import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

RxInt selectedIndexBottomBar = 0.obs;
RxString userId = ''.obs;
Rxn<UserCredential> userData = Rxn<UserCredential>();
