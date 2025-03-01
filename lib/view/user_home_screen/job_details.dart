import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_app_bar.dart';
import '../../shared/widgets/my_button.dart';
import 'chat_screen.dart';

class JobDetails extends StatelessWidget {
  final JobModel model;
  const JobDetails({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: PaddingManger.kPadding,
          children: [
            Padding(
              padding: const EdgeInsets.all(PaddingManger.kPadding),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            padding: const EdgeInsetsDirectional.all(
                                PaddingManger.kPadding / 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    PaddingManger.kPadding / 2),
                                color: ColorManger.kPrimary),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=> const ChatScreen(receiverId: ''),transition: Transition.rightToLeft,curve: Curves.linear,duration:const Duration(milliseconds: 500));

                        },
                        child: const CircleAvatar(
                         radius: 25,
                         backgroundColor: ColorManger.kPrimary,
                         child:  Icon(Icons.message,color: Colors.white,),

                                             ),
                      ),
                      const SizedBox(
                        width: PaddingManger.kPadding/2,
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHVzZXJ8ZW58MHx8MHx8fDA%3D'),
                      ),

                    ],
                  ),
                  Text(
                    'Hello, Qusai Jamous the ${model.companyName} is hiring a ${model.subCategory}',
                    style: getMyMediumTextStyle(color: ColorManger.grey),
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(
                            PaddingManger.kPadding / 2),
                        color: ColorManger.grey.withOpacity(0.1)),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(
                                    PaddingManger.kPadding / 2)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                                model.jobImage??'')),
                        const SizedBox(
                          width: PaddingManger.kPadding / 3,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.subCategory,
                              style: getMyMediumTextStyle(color: Colors.black),
                            ),
                            Text(
                              model.companyName,
                              style: getMyRegulerTextStyle(
                                  color: ColorManger.grey,
                                  fontSize: FontSize.s12),
                            ),
                            Text(
                              'Company Location :',
                              style: getMyRegulerTextStyle(
                                  color: ColorManger.grey,
                                  fontSize: FontSize.s12),
                            ),
                          ],
                        ),
                        const Spacer(),
                         GestureDetector(
                           onTap: (){

                           },
                             child: const Icon(Icons.location_on_outlined,color: ColorManger.kPrimary,size: 40,))

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius:const BorderRadiusDirectional.vertical(top: Radius.circular(PaddingManger.kPadding*2.5)),
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        const EdgeInsetsDirectional.all(PaddingManger.kPadding),
                    decoration: BoxDecoration(
                        color: ColorManger.grey.withOpacity(0.1),
                        borderRadius: const BorderRadiusDirectional.only(
                            topStart: Radius.circular(PaddingManger.kPadding * 2.5),
                            topEnd: Radius.circular(PaddingManger.kPadding * 2.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: PaddingManger.kPadding,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: ColorManger.grey,
                                  borderRadius: BorderRadiusDirectional.circular(
                                      PaddingManger.kPadding)),
                            )
                          ],
                        ),
                        Text(
                          'Job Description',
                          style: getMyBoldTextStyle(color: Colors.black),
                        ),
                        Text(
                          'We are seeking a dedicated and friendly Customer Support Specialist to join our team. The ideal candidate will provide exceptional service to our customers, assist with inquiries, and resolve any issues in a timely manner. The role involves interacting with customers via phone, email, and chat, ensuring they have a positive experience with our products and services. ',
                          textAlign: TextAlign.justify,
                          style: getMyRegulerTextStyle(color: Colors.black),
                        ),
                        Text(
                          'Job Requirements',
                          style: getMyBoldTextStyle(color: Colors.black),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index)=>buildJobRequirement(),
                            separatorBuilder: (context,index)=>const SizedBox(
                              height: PaddingManger.kPadding/2,
                            ),
                            itemCount: 6)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: MyButton(title: 'Apply', onTap: (){}, btnColor: ColorManger.kPrimary, textColor: Colors.white),
      ),
    );
  }

  Widget buildJobRequirement() => Container(
        padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 8,
              backgroundColor: ColorManger.kPrimary,
            ),
            const SizedBox(
              width: PaddingManger.kPadding / 1.5,
            ),
            Expanded(
              child: Text(
                'Strong responsive web design experience',
                style: getMyMediumTextStyle(
                    color: Colors.black, fontSize: FontSize.s14),
              ),
            )
          ],
        ),
      );

}
