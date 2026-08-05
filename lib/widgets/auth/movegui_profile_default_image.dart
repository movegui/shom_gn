import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';


class MyProfileDefaultImage extends StatelessWidget {
  final File? pickedImage;
  final Uint8List? webImage;
  final Future<void> Function() onPickImage;

  const MyProfileDefaultImage({
    super.key,
    required this.pickedImage,
    required this.webImage,
    required this.onPickImage,
  });
  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                webImage != null
                    ? MemoryImage(webImage!)
                    : (pickedImage != null
                        ? FileImage(pickedImage!)
                        : const AssetImage(
                              'assets/images/profile/default_avatar.jpg',
                            )
                            as ImageProvider),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onPickImage,
              child: const CircleAvatar(
                radius: 16,
                child: Icon(Icons.camera_alt, size: 16,),
              ),
            ),
          ),
        ],
    
    );
  }
}
