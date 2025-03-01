import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/resources/color_manger/color_manger.dart';
import '../../shared/resources/font_manger.dart';
import '../../shared/resources/padding_manger.dart';
import '../../shared/resources/style_manger.dart';
import '../../shared/utils/utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiverId});

  final String receiverId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final _userController = Get.find<UserController>(tag: 'user_controller');

  final _messageController = TextEditingController();

  final _scrollController = ScrollController();  // Add a scroll controller


  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   await _userController.getMessages(receiverId: widget.receiverId);
    // });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard(context);
      },
      onVerticalDragDown: (details) {
        Utils.hideKeyboard(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        padding:const EdgeInsetsDirectional.all(PaddingManger.kPadding/2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(PaddingManger.kPadding/2),
                            color: ColorManger.kPrimary
                        ),
                        child:const Icon(Icons.arrow_back,color: Colors.white,),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chat Screen',
                      style: getMyMediumTextStyle(color: Colors.black,fontSize: FontSize.s20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: PaddingManger.kPadding,
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(20),
                    decoration: BoxDecoration(
                        color: ColorManger.kPrimary.withOpacity(0.5),
                        borderRadius: BorderRadiusDirectional.circular(20)),

                    child: SingleChildScrollView(
                      controller: _scrollController,

                      child: Column(
                        children: [
                        const  CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.message,color: ColorManger.kPrimary,size: 100,),
                          ),
                          const SizedBox(height: 20),
                          ListView.separated(
                              shrinkWrap: true,
                              physics:const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index%2==0) {
                                  return buildMessage();
                                } else {
                                  return buildMyMessage();
                                }
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 20,
                              ),
                              itemCount: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(start: 7),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // DoctorCubit.get(context).openGalaryToSendImage();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _messageController,
                          decoration: InputDecoration(
                              hintText: 'Write Your Message Here',
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        color: ColorManger.kPrimary,
                        height: 60,
                        width: 60,
                        child: IconButton(
                            onPressed: () {
                              if (_messageController.text.isNotEmpty) {
                                // _userController.sendMessage(
                                //     receiverId: widget.receiverId,
                                //     dateTime: DateTime.now().toString(),
                                //     text: _messageController.text,
                                //     profileImage: _userController
                                //         .userModel?.profileImage ??
                                //         '');
                                _messageController.clear();
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration:const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              } else {
                                Utils.myToast(title: 'Message is Requierd');
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessage() => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Row(
      mainAxisSize: MainAxisSize.min, // Make Row shrink to fit content
      children: [
     const   CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjDGMp734S91sDuUFqL51_xRTXS15iiRoHew&s'),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          // Ensure the container takes only necessary width based on content
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text(
                  'Hello',
                  style:  TextStyle(fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                   DateTime.now().toString(),
                  style: getMyLightTextStyle(
                      color: ColorManger.grey, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildMyMessage() => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Row(
      textDirection: TextDirection.rtl,
      mainAxisSize: MainAxisSize.min,
      children: [
      const  CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage('https://media.istockphoto.com/id/1347005975/photo/portrait-of-a-serious-muslim-young-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=mxRUDCuwDD3ML6-vMaUlTY7Ghqlj2R_LOhWWCB5CTXE='),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          // Ensure the container takes only necessary width based on content
          child: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration:const BoxDecoration(
              color: ColorManger.kPrimary,
              borderRadius:  BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Text(
                 'Hii',
                  style:  TextStyle(color: Colors.white, fontSize: 18),
                  overflow: TextOverflow.visible,
                  // Allow text to extend without clipping
                  softWrap: true, // Enable text wrapping
                ),
                Text(
                  DateTime.now().toString(),
                  style: getMyLightTextStyle(
                      color: Colors.white, fontSize: FontSize.s14),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
