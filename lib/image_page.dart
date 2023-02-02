import 'dart:io';

import 'package:exif_sample/show_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:native_exif/native_exif.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  double? latitude;
  double? longitude;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                imageFile = await showPhotoAndPickImage(context);
                print('imageFile ${imageFile!.path}');
                if (imageFile?.path == null) {
                  print('null');
                } else {
                  final exif = await Exif.fromPath(imageFile!.path);
                  final latLong = await exif.getLatLong();
                  latitude = latLong?.latitude;
                  longitude = latLong?.longitude;
                  setState(() {});
                }
              },
              child: Text('Show Image Picker'),
            ),
            Text('latitude: ${latitude}'),
            Text('longitude: ${longitude}'),
            TextButton(
              onPressed: () async {
                final exif = await Exif.fromPath(imageFile!.path);
                await exif.writeAttributes(
                    {'GPSLatitude': '100', 'GPSLongitude': '100'});
                final fixedLatLong = await exif.getLatLong();
                latitude = fixedLatLong?.latitude;
                longitude = fixedLatLong?.longitude;

                final attributes = await exif.getAttributes();
                print('attributes ${attributes}');
                await exif.close();
                setState(() {});
              },
              child: Text('Change Location Latitude to 100, Longtitude to 100'),
            )
          ],
        ),
      ),
    );
  }
}
