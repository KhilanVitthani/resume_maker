import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:resume_maker/constants/color_constant.dart';
import 'package:resume_maker/constants/firebase_controller.dart';
import 'package:resume_maker/constants/sizeConstant.dart';
import 'package:resume_maker/main.dart';
import 'package:resume_maker/models/resumeModel.dart';
import 'package:resume_maker/utilities/buttons.dart';
import 'package:resume_maker/utilities/progress_dialog_utils.dart';
import 'package:resume_maker/utilities/text_field.dart';

import '../controllers/add_resume_screen_controller.dart';

class AddResumeScreenView extends GetView<AddResumeScreenController> {
  const AddResumeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddResumeScreenView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(8)),
            child: Form(
              key: controller.fromKey,
              child: Column(
                children: [
                  Spacing.height(10),
                  getImageView(),
                  Spacing.height(10),
                  getTextField(
                    labelText: "First Name",
                    textEditingController: controller.firstname_T,
                    hintText: "Enter your first name",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your first name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Last Name",
                    textEditingController: controller.lastname_T,
                    hintText: "Enter your last name",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your last name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Designation",
                    textEditingController: controller.designation_T,
                    hintText: "Enter your designation",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter designation";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "About",
                    textEditingController: controller.about_T,
                    hintText: "Enter About you",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter about you";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Address",
                    textEditingController: controller.address_T,
                    hintText: "Enter your address",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Contact",
                    textEditingController: controller.contact_T,
                    hintText: "Enter your contact no",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your contact no";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Email",
                    textEditingController: controller.email_T,
                    hintText: "Enter your Email",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Project",
                    textEditingController: controller.project,
                    hintText: "Enter your project",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your project";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Education",
                    textEditingController: controller.education_T,
                    hintText: "Enter your education",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your education";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getTextField(
                    labelText: "Experience",
                    textEditingController: controller.experience_T,
                    hintText: "Enter your experience",
                    validation: (value) {
                      if (isNullEmptyOrFalse(value)) {
                        return "Please enter your experience";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Spacing.height(10),
                  getMultiSelectTextFiled(),
                  Spacing.height(10),
                  InkWell(
                    onTap: () {
                      String uId = FirebaseFirestore.instance
                          .collection('resume')
                          .doc()
                          .id;

                      if (controller.fromKey.currentState!.validate()) {
                        if (!controller.ProfileImage.isNull) {
                          getIt<CustomDialogs>().showCircularDialog(context);

                          FireController()
                              .addData(
                                  resumeData: resumeModel(
                            firstName: controller.firstname_T.text.trim(),
                            lastName: controller.lastname_T.text.trim(),
                            about: controller.about_T.text.trim(),
                            address: controller.address_T.text.trim(),
                            contact: controller.contact_T.text.trim(),
                            designation: controller.designation_T.text.trim(),
                            education: controller.education_T.text.trim(),
                            email: controller.email_T.text.trim(),
                            experience: controller.experience_T.text.trim(),
                            exspertise: controller.selected_skills.join(","),
                            frame: 1,
                            image: controller.ProfileImage!.value.path,
                            project: controller.project.text.trim(),
                            skillList: controller.selected_skills,
                            uId: uId,
                          ))
                              .then((value) {
                            getIt<CustomDialogs>().hideCircularDialog(context);
                          });
                        } else {
                          getIt<CustomDialogs>().getDialog(
                              title: "Error", desc: "Please select image");
                        }
                      }
                    },
                    child: getButton(title: "Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getMultiSelectTextFiled() {
    return DropDownMultiSelect<String>(
      options: controller.skills,
      selectedValues: controller.selected_skills,
      whenEmpty: 'Skills',
      onChanged: (val) {
        controller.selected_skills = val.obs;
      },
    );
  }

  Widget getImageView() {
    return Center(
      child: InkWell(
          onTap: () async {
            FocusScope.of(Get.context!).unfocus();
            Get.dialog(Dialog(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.openCamera().then((value) {
                          controller.cropImage(
                            pickedFile: value,
                            context: Get.context!,
                          );
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: 60,
                              child: Icon(
                                Icons.camera,
                                color: appTheme.primaryTheme,
                                size: 60,
                              )),
                          Space.height(10),
                          Text(
                            "Camera",
                            style: TextStyle(
                              color: appTheme.primaryTheme,
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () async {
                        controller.openGallery().then((value) {
                          controller.cropImage(
                            pickedFile: value,
                            context: Get.context!,
                          );
                        }).catchError((error) {
                          print(error);
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              color: appTheme.primaryTheme,

                              //color: AppColors.kOrange,
                              size: 60,
                            ),
                          ),
                          Space.height(10),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              color: appTheme.primaryTheme,
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
          child: Obx(
            () => (controller.hasFrontImage.isTrue)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      MySize.getHeight(75),
                    ),
                    child: Image.file(controller.ProfileImage!.value,
                        fit: BoxFit.cover, height: MySize.getHeight(75)),
                  )
                : Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: MySize.getHeight(75),
                    ),
                  ),
          )),
    );
  }
}
