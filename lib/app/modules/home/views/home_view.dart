import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:resume_maker/constants/color_constant.dart';
import 'package:resume_maker/constants/firebase_controller.dart';
import 'package:resume_maker/models/resumeModel.dart';

import '../../../../constants/sizeConstant.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: (true)
          ? Frame1(
              data: resumeModel.fromJson({
                "About": "11",
                "Address": "1",
                "Contact": "11",
                "Education": "1",
                "Email": "1",
                "Experience": "11",
                "designation": "11",
                "exspertise": "Android",
                "first_name": "11",
                "frame": 1,
                "image":
                    "https://firebasestorage.googleapis.com/v0/b/resumemaker-3624b.appspot.com/o/image_cropper_1678963584548.jpg%2Ffile?alt=media&token=8abf99f6-f81b-40b5-833e-152aaf3bb8ce",
                "last_name": "11",
                "project": "1",
                "skillList": ["Android"],
                "uId": "grIAWMqFKGWhLX7i5zhE"
              }),
              context: context)
          : StreamBuilder<QuerySnapshot>(
              stream: FireController().getResumeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var ResumeAllData = snapshot.data;
                  if (ResumeAllData!.docs.isNotEmpty) {
                    List<resumeModel> data = ResumeAllData.docs
                        .map((e) => resumeModel
                            .fromJson(e.data()! as Map<String, dynamic>))
                        .toList();
                    return gridWidget(data: data);
                  } else
                    return Center(
                      child: Text(
                        "No Data found",
                        style: TextStyle(
                          fontSize: MySize.getHeight(12),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                } else {
                  return SizedBox();
                }
              },
            ),
    );
  }

  gridWidget({required data}) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Get.toNamed(Routes.FULL_VIEW,
              //     arguments: {ArgumentConstant.userData: data[index]});
            },
            child: gridScreenIndex(
                data: data[index], context: context, index: data[index].frame),
          ),
        );
      },
    );
  }

  gridScreenIndex(
      {required int index,
      required BuildContext context,
      required resumeModel data}) {
    return (index == 0)
        ? Frame1(data: data, context: context)
        : (index == 1)
            ? Frame2(data: data, context: context)
            : Frame1(data: data, context: context);
  }

  Widget Frame1({required resumeModel data, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 8,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.1))
      ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MySize.getHeight(175),
              child: Stack(
                children: [
                  Container(
                    width: MySize.safeWidth,
                    height: MySize.getHeight(125),
                    color: appTheme.resume1,
                    child: Padding(
                      padding: EdgeInsets.only(right: MySize.getWidth(25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            data.firstName!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(25),
                            ),
                          ),
                          Text(
                            data.lastName!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: MySize.getHeight(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MySize.getHeight(0),
                    left: MySize.getWidth(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: getImageByLink(
                        url: data.image!,
                        height: 125,
                        width: 125,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Frame2({required data, required BuildContext context}) {
    return Container();
  }

  Widget Frame3({required data, required BuildContext context}) {
    return Container();
  }
}
