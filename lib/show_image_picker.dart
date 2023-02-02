import 'dart:io';

import 'package:exif_sample/show_photo_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showPhotoAndCropBottomSheet(
  BuildContext context, {
  String? title,
}) async {
  final result = await showPhotoBottomSheet(context, title: title);
  if (result == PhotoType.camera) {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) {
      return null;
    }
    return File(file.path);
  } else if (result == PhotoType.album) {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    return File(file.path);
  }
  return null;
}

Future<File?> showPhotoAndPickImage(
  BuildContext context, {
  String? title,
}) async {
  final result = await showPhotoBottomSheet(context, title: title);
  if (result == PhotoType.camera) {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) {
      return null;
    }
    return File(file.path);
  } else if (result == PhotoType.album) {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }

    return File(file.path);
  }
  return null;
}
