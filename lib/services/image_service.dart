import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/error/message_widget.dart';


class ImageService {

     Future<String?> uploadImage({
    required File? file,
    required Uint8List? webBytes,
    required String collectionName,
  }) async {
    final storage = FirebaseStorage.instance;
    final fileName = '$collectionName/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = storage.ref().child(fileName);

    UploadTask task;

    if (kIsWeb && webBytes != null) {
      task = ref.putData(
        webBytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else if (file != null) {
      task = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else {
      return null;
    }

    return await (await task).ref.getDownloadURL();
  }


    static Future<Map<String?, dynamic>?>pickAnImage() async {
   
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if(image == null) {
        return null;
      } else if(kIsWeb){
        final bytes = await image.readAsBytes();
        return {
          "webImage": bytes,
          "file": File('a')
        };
      }else {
              return {
        "webImage": null,
        "file": File(image.path),
      };
      }

  }

   static Future<void> onPressedCategoryImage(
    BuildContext context,
    String routeName,
    String title,
    bool enabled,
  ) async {
    if (enabled) {
      context.push(routeName);
    } else {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    }
  }

  


}