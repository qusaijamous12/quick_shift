import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_field.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _phoneController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _majorController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(PaddingManger.kPadding),
          child: Column(
            spacing: PaddingManger.kPadding,
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
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile screen',
                    style: getMyMediumTextStyle(
                        color: Colors.black, fontSize: FontSize.s20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjDGMp734S91sDuUFqL51_xRTXS15iiRoHew&s'),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorManger.kPrimary,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: PaddingManger.kPadding,
              ),
              MyTextField(
                  controller: _nameController,
                  labelText: 'User Name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: ColorManger.kPrimary,
                  )),
              MyTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  enabled: false,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: ColorManger.kPrimary,
                  )),
              MyTextField(
                  controller: _emailController,
                  labelText: 'Phone',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: ColorManger.kPrimary,
                  )),
              MyTextField(
                  controller: _emailController,
                  labelText: 'Description',
                  prefixIcon: const Icon(
                    Icons.description,
                    color: ColorManger.kPrimary,
                  )),
              MyTextField(
                  controller: _majorController,
                  labelText: 'Major',
                  prefixIcon: const Icon(
                    Icons.work,
                    color: ColorManger.kPrimary,
                  )),
              const SizedBox(
                height: PaddingManger.kPadding,
              ),
              Row(
                spacing: PaddingManger.kPadding / 2,
                children: [
                  Expanded(
                      child: MyButton(
                          title: 'Update',
                          onTap: (){},
                          btnColor: ColorManger.kPrimary,
                          textColor: Colors.white)),
                  Expanded(
                      child: MyButton(
                          title: 'LogOut',
                          onTap: (){
                            Get.offAll(()=>const LoginScreen());
                          },
                          btnColor: Colors.white,
                          textColor: ColorManger.kPrimary)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
