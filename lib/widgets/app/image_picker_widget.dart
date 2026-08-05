import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/responsive.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? webImage;
  final File? pickedImage;
  final double width;
  final double height;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;
  final Color bgColor;

  const ImagePickerWidget({
    super.key,
    required this.webImage,
    required this.pickedImage,
    required this.onPickImage,
    required this.onRemoveImage,
    this.bgColor = const Color.fromARGB(90, 158, 158, 158),
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize =
        Responsive.isDesktop(context)
            ? WidgetConstants.buttonFonsize
            : WidgetConstants.buttonFonsize *
                WidgetConstants.buttonFontSizeZoomFactor;

    final bool hasImage = webImage != null || pickedImage != null;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(WidgetConstants.sepWidgetHeight),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child:
          hasImage
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          webImage != null
                              ? Image.memory(
                                webImage!,
                                width: width * 0.8,
                                height: height * 0.6,
                                fit: BoxFit.cover,
                              )
                              : pickedImage != null
                              ? Image.file(
                                pickedImage!,
                                width: width * 0.8,
                                height: height * 0.6,
                                fit: BoxFit.cover,
                              )
                              : const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: onRemoveImage,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: onPickImage,
                        icon: const Icon(Icons.change_circle),
                      ),
                    ],
                  ),
                ],
              )
              : Center(
                child: IconButton(
                  onPressed: onPickImage,
                  icon: const Icon(Icons.image_outlined, size: 40),
                ),
              ),
    );
  }
}
