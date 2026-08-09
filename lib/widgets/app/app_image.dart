import 'package:flutter/material.dart';
import 'package:shom_gn/services/assets_manager.dart';

class AppImage extends StatelessWidget {
  final num? heightScale;
  final num? widthScale;

  const AppImage({super.key, this.heightScale=0.1, this.widthScale=0.5}); 
  
  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width * widthScale!, 
              height: MediaQuery.of(context).size.height * heightScale!,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  image: AssetImage(
                    AssetsManager.logo,
                  ),
                  fit: BoxFit.fill, // covers entire container
                ),
              ),
            );
  }
  
}