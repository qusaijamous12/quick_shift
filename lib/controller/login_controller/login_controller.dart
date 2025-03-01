import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';
import '../../shared/utils/utils.dart';
import '../../view/admin_screen/main_admin_screen.dart';
import '../../view/company_owner_scrceens/company_home_screen.dart';
import '../../view/login_screen/login_screen.dart';
import '../../view/user_home_screen/tab_bar.dart';

class LoginController extends GetxController{

  final _isLoading=RxBool(false);
  final _firebaseAuth=FirebaseAuth.instance;
  final _userModel=Rxn<UserModel>();
  final _firebaseInstance=FirebaseFirestore.instance;
  final  genderItems =RxList([  'Male',
    'Female',]);
  final selectedValue=RxnString(null);

  final _allCompanies=RxList<UserModel>([]);

  final _adsImage=Rxn<File>(null);
  final _imagePicker=ImagePicker();

  final _allMyJobs=RxList<JobModel>([]);
  final _allMyAds=RxList<JobModel>([]);
  final _allJobs=RxList<JobModel>([]);
  final _allAds=RxList<JobModel>([]);



  Future<void> login({required String email, required String password}) async {
    _isLoading(true);
    try {
      final result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (result.user != null) {
        await getUserData(uid: result.user!.uid);

        print('sssss${_userModel.value?.status}');

        print('user model is is is ${_userModel.value?.status} and name is is s ${_userModel.value?.companyName}');
        if(_userModel.value!=null){
          print('kokoko');
          if (_userModel.value?.status == 0) {
            print('ok ok 0 ');

            Get.offAll(()=>const TabBarScreen());
            Utils.myToast(title: 'Login Success');
          }
          else if (_userModel.value?.status == 1) {
            print('ok ok1 ');

            print('yes admin !');
            Get.offAll(() => const MainAdminScreen());
            Utils.myToast(title: 'Login Success');
          }
          else if(_userModel.value?.status==2){
            print('ok ok2 ');
            Get.offAll(()=>const CompanyHomeScreen());

          }
        }
      }
      else {
        Utils.myToast(title: 'Login Failed');
      }
    } catch (e) {
      print('there is an error in login $e');
      Utils.myToast(title: 'Login Failed');
    }
    _isLoading(false);
  }

  Future<void> createAccount({required String email, required String name, required String password, required String phoneNumber,
    int status = 0,
    required String age,
    required String description,
    required String major,
    required String gender}) async {
    _isLoading(true);
    try {
      final auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (auth.user != null) {
        await saveDataToFireStore(
            email: email,
            name: name,
            phone: phoneNumber,
            uid: auth.user!.uid,
            status: status,
            age: age,
            description: description,
            major: major,
            gender: gender);

        Get.offAll(() => const LoginScreen());
      } else {
        Utils.myToast(title: 'Register Failed');
      }
    } catch (e) {
      print('there is an error $e');
      Utils.myToast(title: 'Register Failed');
    }
    _isLoading(false);
  }

  Future<void> forgetPassword({required String email})async{
    _isLoading(true);
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value){
      Utils.myToast(title: 'Please Check Your Email 1');
    }).catchError((error){
      Utils.myToast(title: 'Check Your Internet');
    });
    _isLoading(false);


  }

  Future<void> saveDataToFireStore(
      {required String email,
        required String name,
        required String phone,
        required String uid,
        dynamic status,
        required String description,
        required String age,
        required String major,
        required String gender}) async {
    try {
      final store =
      await _firebaseInstance.collection('users').doc(uid).set({
        'email': email,
        'user_name': name,
        'mobile_number': phone,
        'uid': uid,
        'status': 0, //1 FOR ADMIN AND 0 USER AND 2 FOR COMPANY
        'age': age,
        'description': description,
        'major': major,
        'gender': gender,
        'profile_image': gender == 'Male'
            ? 'https://static.vecteezy.com/system/resources/thumbnails/051/948/045/small_2x/a-smiling-man-with-glasses-wearing-a-blue-sweater-poses-warmly-against-a-white-background-free-photo.jpeg'
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRC6R4Gt9B7p36ZaS8rhWwq-yF4iUpakWPCWA&s'
      });
      Utils.myToast(title: 'Register Success');
    } catch (e) {
      print('There is an error in saveDataToFireStore method ');
    }
  }

  Future<void> getUserData({required String uid}) async {
    try {
      final result =
      await _firebaseInstance.collection('users').doc(uid).get();
      if (result.data() != null) {
        _userModel(UserModel.fromJson(result.data()!));
      } else {
        _userModel(null);
        Utils.myToast(title: 'Please Check your network!');
      }
    } catch (e) {
      print('there is an error in get user Data $e');
    }
  }

  Future<void> updateUserData(
      {required String name, required String phone}) async {
    _isLoading(true);
    await _firebaseInstance
        .collection('users')
        .doc(_userModel.value?.uid)
        .update({'mobile_number': phone, 'user_name': name}).then(
            (value) async {
          await getUserData(uid: _userModel.value!.uid!);
          Utils.myToast(title: 'Update Success');
        }).catchError((error) {
      print('there is an error in update $error');
    });
    _isLoading(false);
  }

  Future<void> createCompanyOwnerAccount({required String companyName,required String companyOwnerName,required String email,required String password,required String mobileNumber, String?companyUrl,required String industry,required String subCategory,required String description,required double latitude,required double longitude })async{
    _isLoading(true);
    final result=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if(result.user!=null){

      await _firebaseInstance.collection('users').doc(result.user?.uid).set({
        'company_name':companyName,
        'company_owner_name':companyOwnerName,
        'email':email,
        'mobile_number':mobileNumber,
        'company_url':companyUrl??'',
        'industry':industry,
        'sub_category':subCategory,
        'description':description,
        'latitude':latitude,
        'uid':result.user?.uid,
        'status':2,
        'profile_image':'https://static.vecteezy.com/system/resources/thumbnails/051/948/045/small_2x/a-smiling-man-with-glasses-wearing-a-blue-sweater-poses-warmly-against-a-white-background-free-photo.jpeg',
        'longitude':longitude
      }).then((value){
        Utils.myToast(title: 'Create Account Success');
        Get.offAll(()=>const MainAdminScreen());

      }).catchError((error){
        print('there is an error when save data to fire store ${error.toString()}');
      });


    }else{
      Utils.myToast(title: 'Register Failed');
    }


    _isLoading(false);

  }

  Future<void> getAllCompanies()async{
    _isLoading(true);
    await _firebaseInstance.collection('users').get().then((value){
      value.docs.forEach((element){
        if(element['status']==2){
          _allCompanies.add(UserModel.fromJson(element.data()));
        }
      });

    }).catchError((error){
      print('there is an error whn get all companies ! ${error.toString()}');
    });

    _isLoading(false);

  }

  Future<void> uploadImage({bool isGallery=true})async{
    final image=await _imagePicker.pickImage(source: isGallery?ImageSource.gallery:ImageSource.camera);
    if(image!=null){
      _adsImage(File(image.path));
    }
    else{
      Utils.myToast(title: 'Please select image !');
    }

  }


  Future<void> addAds({required String title,required String description}) async {
    _isLoading(true);
    try {
      print('addAds method started');

      if (_adsImage.value == null) {
       Utils.myToast(title: 'No Image Selected !');
        return;
      } else {
        print('Image selected: ${_adsImage.value!.path}');
      }

      String filePath = 'ads/${Uri.file(_adsImage.value!.path).pathSegments.last}';
      print('Uploading image to Firebase Storage at path: $filePath');

      TaskSnapshot taskSnapshot;
      try {
        taskSnapshot = await FirebaseStorage.instance.ref().child(filePath).putFile(_adsImage.value!);
        print('Image uploaded successfully');
      } catch (e) {
        print('Error uploading image: $e');
        return;
      }

      // Get the download URL
      String downloadUrl;
      try {
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print('Image download URL: $downloadUrl');
      } catch (e) {
        print('Error fetching download URL: $e');
        return;  // Stop execution if URL fetching fails
      }

      try {
        DocumentReference docRef = await FirebaseFirestore.instance.collection('ads').add({
          'ads_image': downloadUrl
        });
        print('Ad added to Firestore with ID: ${docRef.id}');


        await docRef.update({
          'uid': _userModel.value?.uid,
          'company_name':_userModel.value?.companyName,
          'company_owner_name':_userModel.value?.companyOwnerName,
          'email':_userModel.value?.email,
          'industry':_userModel.value?.industry,
          'sub_category':_userModel.value?.subCategory,
          'title':title,
          'description':description,
          'mobile_number':_userModel.value?.mobileNumber,
          'latitude':_userModel.value?.latitude,
          'longitude':_userModel.value?.longitude

        });

      } catch (e) {
        print('Error adding document to Firestore: $e');
        return;  // Stop execution if Firestore operation fails
      }

      // Show success toast or message
      _adsImage.value=null;
      Utils.myToast(title: 'Add Success');

    } catch (error) {
      print('Error during ads upload: $error'); // Log the error
      Utils.myToast(title: 'Failed to add ad');
      _adsImage.value=null;
      _isLoading(false);

    }
    _adsImage.value=null;
    _isLoading(false);

  }

  Future<void> addJob({required String requirements,required String description,required String jobName}) async {
    _isLoading(true);
    try {
      print('addJob method started');

      if (_adsImage.value == null) {
        Utils.myToast(title: 'No Image Selected !');
        return;
      } else {
        print('Image selected: ${_adsImage.value!.path}');
      }

      String filePath = 'jobs/${Uri.file(_adsImage.value!.path).pathSegments.last}';
      print('Uploading image to Firebase Storage at path: $filePath');

      TaskSnapshot taskSnapshot;
      try {
        taskSnapshot = await FirebaseStorage.instance.ref().child(filePath).putFile(_adsImage.value!);
        print('Image uploaded successfully');
      } catch (e) {
        print('Error uploading image: $e');
        return;
      }

      // Get the download URL
      String downloadUrl;
      try {
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print('Image download URL: $downloadUrl');
      } catch (e) {
        print('Error fetching download URL: $e');
        return;
      }

      try {
        DocumentReference docRef = await FirebaseFirestore.instance.collection('jobs').add({
          'job_image': downloadUrl
        });
        print('job added to Firestore with ID: ${docRef.id}');


        await docRef.update({
          'uid': _userModel.value?.uid,
          'company_name':_userModel.value?.companyName,
          'company_owner_name':_userModel.value?.companyOwnerName,
          'email':_userModel.value?.email,
          'industry':_userModel.value?.industry,
          'sub_category':_userModel.value?.subCategory,
          'description':description,
          'mobile_number':_userModel.value?.mobileNumber,
          'latitude':_userModel.value?.latitude,
          'longitude':_userModel.value?.longitude,
          'requirements':'requirements'

        });

      } catch (e) {
        print('Error adding document to Firestore: $e');
        return;  // Stop execution if Firestore operation fails
      }


      _adsImage.value=null;
      Utils.myToast(title: 'Add Success');

    } catch (error) {
      print('Error during ads upload: $error'); // Log the error
      Utils.myToast(title: 'Failed to add ad');
      _adsImage.value=null;
      _isLoading(false);

    }
    _adsImage.value=null;
    _isLoading(false);

  }

  Future<void> getAllJobs()async{
    _allJobs.clear();
    _isLoading(true);
   await  _firebaseInstance.collection('jobs').get().then((value){
     value.docs.forEach((element){
       _allJobs.add(JobModel.fromJson(element.data()));
     });
   });
   _isLoading(false);
  }
  Future<void> getAllAds()async{
    _allAds.clear();
    _isLoading(true);
    await  _firebaseInstance.collection('ads').get().then((value){
      value.docs.forEach((element){
        _allAds.add(JobModel.fromJson(element.data()));
      });
    });
    _isLoading(false);
  }

  Future<void> getMyJobs()async{
    _allMyJobs.clear();
    _isLoading(true);
    await _firebaseInstance.collection('jobs').get().then((value){
      value.docs.forEach((element){
        if(element['uid']==_userModel.value?.uid){
          _allMyJobs.add(JobModel.fromJson(element.data()));
        }
      });
    });
    _isLoading(false);
  }

  Future<void> getMyAds()async{
    _allMyAds.clear();
    _isLoading(true);
    await _firebaseInstance.collection('ads').get().then((value){
      value.docs.forEach((element){
        if(element['uid']==_userModel.value?.uid){
          _allMyAds.add(JobModel.fromJson(element.data()));
        }
      });
    });
    _isLoading(false);
  }



  bool get isLoading=>_isLoading.value;
  UserModel ?get userModel=>_userModel.value;
  File ?get adsImage=>_adsImage.value;
  List<JobModel> get allMyJobs=>_allMyJobs;
  List<JobModel> get allMyAds=>_allMyAds;
  List<JobModel> get allJons=>_allJobs;
  List<JobModel> get allAds=>_allAds;






}