class UserModel {
  final String ?userName;
  final String ?email;
  final String ?uid;
  final String ?phoneNumber;
  final int ?status;
  final String ?age;
  final String ?description;
  final String ?major;
  final String ?sendUid;
  final String ?gender;
  final String ?profileImage;
  final String ?companyName;
  final String ?companyOwnerName;
  final String ?companyUrl;
  final String ?industry;
  final double ?latitude;
  final double ? longitude;
  final String ?mobileNumber;
  final String ?subCategory;


  UserModel({
    this.uid,
    this.phoneNumber,
    this.email,
    this.userName,
    this.status,
    this.age,
    this.description,
    this.major,
    this.sendUid,
    this.gender,
    this.profileImage,
    this.companyOwnerName,
    this.companyUrl,
    this.longitude,
    this.latitude,
    this.companyName,
    this.mobileNumber,
    this.industry,
    this.subCategory

  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        uid: json['uid'],
        phoneNumber: json['mobile_number'] ?? '',
        email: json['email'] ?? '',
        status: json['status'] ?? '',
        userName: json['user_name'] ?? '',
        age: json['age'] ?? '',
        description: json['description'] ?? '',
        major: json['major'] ?? '',
        sendUid: json['send_uid'] ?? '',
        gender: json['gender'] ?? '',
        profileImage: json['profile_image'] ?? '',
        companyName: json['company_name'],
        companyOwnerName: json['company_owner_name'],
        companyUrl: json['company_url'],
        industry: json['industry'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        mobileNumber: json['mobile_number'],
        subCategory: json['sub_category']


    );
  }

}

// class CompanyModel {
//   final String companyName;
//   final String companyOwnerName;
//   final String ?companyUrl;
//   final String description;
//   final String ?uid;
//
//   final String email;
//   final String industry;
//   final double latitude;
//   final double longitude;
//   final String mobileNumber;
//   final int status;
//   final String sub_category;
//
//   CompanyModel({
//     required this.industry,
//     required this.mobileNumber,
//     required this.email,
//     required this.companyName,
//     required this.latitude,
//     required this.longitude,
//     this.companyUrl,
//     required this.uid,
//     required this.companyOwnerName,
//     required this.description,
//     required this.status,
//     required this.sub_category
//   });
//
//   factory CompanyModel.fromJson(Map<String, dynamic> json){
//     return CompanyModel(
//         industry: json['industry'],
//         mobileNumber: json['mobile_number'],
//         email: json['email'],
//         companyName: json['company_name'],
//         latitude: json['latitude'],
//         longitude: json['longitude'],
//         companyOwnerName: json['company_owner_name'],
//         description: json['company_owner_name'],
//         status: json['status'],
//         sub_category: json['sub_category'],
//         uid: json['uid']);
//   }
//
//
// }


class JobModel {
  final String companyName;
  final String companyOwnerName;
  final String description;
  final String email;
  final String industry;
  final double latitude;
  final double longitude;
  final String mobileNumber;
  final String ?requirements;
  final String subCategory;
  final String uid;
  final String ?jobImage;
  final String ?adsImage;

  JobModel({
    required this.description,
    required this.companyName,
    required this.companyOwnerName,
    required this.longitude,
    required this.latitude,
    required this.mobileNumber,
    required this.subCategory,
    required this.industry,
    required this.email,
    required this.uid,
     this.requirements,
     this.jobImage,
     this.adsImage

  });


  factory JobModel.fromJson(Map<String, dynamic> json){
    return JobModel
      (description: json['description'],
        companyName: json['company_name'],
        companyOwnerName: json['company_owner_name'],
        longitude: json['longitude'],
        latitude: json['latitude'],
        mobileNumber: json['mobile_number'],
        subCategory: json['sub_category'],
        industry: json['industry'],
        email: json['email'],
        uid: json['uid'],
        jobImage: json['job_image']??'',
        adsImage: json['ads_image']??'',
        requirements: json['requirements']??'');
  }
}

