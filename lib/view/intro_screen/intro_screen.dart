import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PaddingManger.kPadding),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset('assets/images/login_image.svg'),
              const Spacer(),
              
              Text(
                'Lets Create Account And Start Lookings for A job ',
                textAlign: TextAlign.center,
                style: getMyMediumTextStyle(color: ColorManger.grey),
              ),
              const SizedBox(
                height: 60,
              ),

              MyButton(title: 'Login', onTap: (){
                Get.offAll(()=>const LoginScreen());
              }, btnColor: ColorManger.kPrimary, textColor: Colors.white),
              const SizedBox(
                height: 20,
              ),
              MyButton(title: 'Register', onTap: (){
                Get.offAll(()=>const RegisterScreen());

              }, btnColor:Colors.white, textColor: ColorManger.kPrimary),
              const Spacer(),
              const Spacer(),


            ],
          ),
        ),
      ),
    );
  }
}
