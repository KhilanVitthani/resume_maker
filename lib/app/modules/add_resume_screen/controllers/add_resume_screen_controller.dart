import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/color_constant.dart';
import '../../../../constants/sizeConstant.dart';

class AddResumeScreenController extends GetxController {
  Rx<File>? ProfileImage;
  TextEditingController firstname_T = new TextEditingController();
  TextEditingController lastname_T = new TextEditingController();
  TextEditingController designation_T = new TextEditingController();
  TextEditingController about_T = new TextEditingController();
  TextEditingController contact_T = new TextEditingController();
  TextEditingController project = new TextEditingController();
  TextEditingController address_T = new TextEditingController();
  TextEditingController email_T = new TextEditingController();
  TextEditingController education_T = new TextEditingController();
  TextEditingController experience_T = new TextEditingController();
  final fromKey = GlobalKey<FormState>();
  RxList<String> selected_skills = <String>[].obs;
  Rx<File>? imgFile;
  final imgPicker = ImagePicker();

  List<String> skills = [
    "Flutter",
    "Unity",
    "Android",
    "Node Js",
    "React Js",
    "C#",
    "C++",
    "Java",
    "Photoshop"
  ];
  RxBool isEmpty = false.obs;
  RxBool frame1 = false.obs;
  RxBool frame2 = false.obs;
  RxBool frame3 = false.obs;
  RxString frame = "".obs;
  RxBool hasFrontImage = false.obs;
  String? imgFileName;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<File?> openCamera() async {
    String? imgCamera;
    await imgPicker.pickImage(source: ImageSource.camera).then((value) {
      imgCamera = value!.path;
      print(imgCamera);
      imgFile = File(imgCamera!).obs;
      return imgFile!.value;
    }).catchError((error) {
      print(error);
    });

    return (isNullEmptyOrFalse(imgFile!.value)) ? null : imgFile!.value;
  }

  Future<File?> openGallery() async {
    String? imgGallery;
    await imgPicker.pickImage(source: ImageSource.gallery).then((value) {
      imgGallery = value!.path;

      imgFile = File(imgGallery!).obs;
      print(imgFile);
      imgFile!.refresh();
    });

    return (isNullEmptyOrFalse(imgFile!.value)) ? null : imgFile!.value;
  }

  Future<void> cropImage({
    File? pickedFile,
    BuildContext? context,
  }) async {
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        // cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: appTheme.primaryTheme,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: true,
          ),
          WebUiSettings(
            context: Get.context!,
          ),
        ],
      );
      if (croppedFile != null) {
        Get.back();

        ProfileImage = File(croppedFile.path).obs;
        hasFrontImage.value = true;
        ProfileImage!.refresh();
        hasFrontImage.refresh();

        imgFileName = p.basename(croppedFile.path);

        update();
      } else {
        // controller.profile =
        //     File(image.path).obs;
        // controller.imgFileName = p
        //     .basename(image.path);
      }
    }
  }
}
