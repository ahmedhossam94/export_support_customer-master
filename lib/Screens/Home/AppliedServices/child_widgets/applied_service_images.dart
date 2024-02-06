import 'dart:io';

import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AppliedServiceImages extends StatefulWidget {
  AppliedServiceImages({Key? key, required this.onSelectImage})
      : super(key: key);

  final Function(List<File>) onSelectImage;

  @override
  _AppliedServiceImagesState createState() => _AppliedServiceImagesState();
}

class _AppliedServiceImagesState extends State<AppliedServiceImages> {
  final double diminsions = (Screen.screenWidth) * 0.15;
  final Color imageBackgroundColor = AppColor.darkGray;
  File? imageFile;
  List<File> imageFileList = [];
  AppLocalizations? _localizations;

  _onImageTapped(int imageIndex) {
    Common.instance.showPhotoModal(
        context: context,
        onCameraTap: () {
          _onSelectImage(imageIndex: imageIndex, source: ImageSource.camera);
        },
        onPhotoTap: () {
          _onSelectImage(imageIndex: imageIndex, source: ImageSource.gallery);
        });
  }

  _onSelectImage({required int imageIndex, required ImageSource source}) async {
    Common.instance.loading(context);
    bool isGranted =
        await checkAndRequestImageStatusPermissions(source: source);

    if (isGranted) {
      XFile? selectedImagePickedFile =
          await ImagePicker().pickImage(source: source);
      setState(() {
        if (selectedImagePickedFile != null) {
          imageFileList[imageIndex] = File(selectedImagePickedFile.path);
        }
      });
      widget.onSelectImage(imageFileList);
      Common.instance.dismiss(context);
    } else {
      Common.instance.dismiss(context);

      String message;
      if (source == ImageSource.camera) {
        message =
            _localizations!.translate(LocalizedKey.notAllowCameraAlertMessage);
      } else if (source == ImageSource.gallery) {
        message =
            _localizations!.translate(LocalizedKey.notAllowPhotoAlertMessage);
      } else {
        message = _localizations!
            .translate(LocalizedKey.unknowImageSourceAlertMessage);
      }

      Alert().warning(
          context: context,
          message: message,
          onPressed: () {
            Common.instance.dismiss(context);
          });
    }
  }

  Future<bool> checkAndRequestImageStatusPermissions(
      {required ImageSource source}) async {
    Permission? permission;

    if (source == ImageSource.camera) {
      permission = Permission.camera;
    } else if (source == ImageSource.gallery) {
      permission = Permission.photos;
    }

    if (permission != null) {
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionsStatusRequested =
            await permission.request();
        return permissionsStatusRequested == PermissionStatus.granted;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  _getImageWidget(imageFile) {
    return imageFile == null
        ? Image(
            image: AssetImage(ImageName.addCamera),
            height: diminsions,
            width: diminsions,
          )
        : Image.file(
            imageFile,
            height: diminsions,
            width: diminsions,
            fit: BoxFit.contain,
          );
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            _localizations!.translate(LocalizedKey.imagesSectionTitle),
            style: TextStyle(
                fontSize: Screen.fontSize(size: 24), color: AppColor.darkRed),
          ),
          Container(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    _onImageTapped(0);
                  },
                  child: _getImageWidget(imageFileList[0])),
              Container(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    _onImageTapped(1);
                  },
                  child: _getImageWidget(imageFileList[1])),
              Container(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    _onImageTapped(2);
                  },
                  child: _getImageWidget(imageFileList[2])),
              Container(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    _onImageTapped(3);
                  },
                  child: _getImageWidget(imageFileList[3])),
              Container(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    _onImageTapped(4);
                  },
                  child: _getImageWidget(imageFileList[4])),
            ],
          ),
        ],
      ),
    );
  }
}
