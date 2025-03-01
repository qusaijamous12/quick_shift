import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../controller/login_controller/login_controller.dart';
import '../../model/user_model.dart';
import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_text_field.dart';
import 'job_details.dart';

class SeeAllScreen extends StatefulWidget {
  final bool isForAds;
  const SeeAllScreen({super.key,required this.isForAds});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final _searchController = TextEditingController();
  final _loginController=Get.find<LoginController>(tag: 'login_controller');

  @override
  void initState() {
    if(widget.isForAds){
      Future.delayed(Duration.zero,()async{
        await _loginController.getAllAds();
      });
    }else{
      Future.delayed(Duration.zero,()async{
        await _loginController.getAllJobs();
      });

    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>LoadingOverlay(isLoading: _loginController.isLoading, child: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsetsDirectional.all(
                        PaddingManger.kPadding / 2),
                    decoration: BoxDecoration(
                        color: ColorManger.kPrimary,
                        borderRadius: BorderRadiusDirectional.circular(
                            PaddingManger.kPadding / 2)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              MyTextField(
                  controller: _searchController,
                  labelText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: ColorManger.kPrimary,
                  )),
              if(widget.isForAds)...[
                if(_loginController.allAds.isNotEmpty)...[
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>buildAdsItem(_loginController.allAds[index]),
                        separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                        itemCount: _loginController.allAds.length),
                  )
                ]
                else...[
                  Expanded(
                    child:  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: PaddingManger.kPadding/2,
                        children: [
                          Text(
                            'There is no ads',
                            style: getMyMediumTextStyle(color: ColorManger.lightGrey,fontSize: FontSize.s20),
                          ),
                          const   Icon(Icons.ads_click,color: ColorManger.kPrimary,size: 150,)


                        ],
                      ),
                    ),
                  )
                ]
              ]
              else...[
                if(_loginController.allJons.isNotEmpty)...[
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context,index)=>buildWorkItem(_loginController.allJons[index]),
                        separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                        itemCount: _loginController.allJons.length),
                  )
                ]
                else...[
                  Expanded(
                    child:  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: PaddingManger.kPadding/2,
                        children: [
                          Text(
                            'There is no jobs',
                            style: getMyMediumTextStyle(color: ColorManger.lightGrey,fontSize: FontSize.s20),
                          ),
                          const   Icon(Icons.ads_click,color: ColorManger.kPrimary,size: 150,)


                        ],
                      ),
                    ),
                  )
                ]

              ]


            ],
          ),
        ),
      ),
    ),progressIndicator:const CircularProgressIndicator(color: ColorManger.kPrimary,),));
  }

  Widget buildWorkItem(JobModel model) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.to(() =>  JobDetails(model: model,));
        },
        child: Container(
          padding: const EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadiusDirectional.circular(PaddingManger.kPadding / 2),
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
                  child: Image.network(model.jobImage??'')),
              const SizedBox(
                width: PaddingManger.kPadding / 3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.companyName,
                      style: getMyMediumTextStyle(color: Colors.black),
                    ),
                    Text(
                      model.description,
                      style: getMyRegulerTextStyle(
                          color: ColorManger.grey, fontSize: FontSize.s12),
                    ),
                    Text(
                      model.subCategory,
                      style: getMyRegulerTextStyle(
                          color: ColorManger.grey, fontSize: FontSize.s12),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      );
  Widget buildAdsItem(JobModel model) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      // Get.to(() => const JobDetails());
    },
    child: Container(
      padding: const EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
          borderRadius:
          BorderRadiusDirectional.circular(PaddingManger.kPadding / 2),
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
              child: Image.network(model.adsImage??'')),
          const SizedBox(
            width: PaddingManger.kPadding / 3,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.companyName,
                  style: getMyMediumTextStyle(color: Colors.black),
                ),
                Text(
                  model.description,
                  style: getMyRegulerTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s12),
                ),
                Text(
                  model.subCategory,
                  style: getMyRegulerTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s12),
                )
              ],
            ),
          ),

        ],
      ),
    ),
  );

}
