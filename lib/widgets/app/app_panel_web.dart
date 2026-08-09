import 'package:flutter/material.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/widgets/input/subtitle_text.dart';

class AppPanelWeb extends StatelessWidget {
  final List<Widget> childrens;
  final String subtitle;
  final String? imageUrl;
  final String title;

  const AppPanelWeb({
    super.key,
    required this.childrens,
    required this.subtitle,
    required this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Logo à gauche
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    imageUrl ?? 'assets/icons/shom-logo.jpg',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Titre centré
                              Column(
                                children: [
                                  Center(
                                    child: SubtitleTextWidget(
                                      label: title,
                                      fontSize:
                                          WidgetConstants.subTitleFontSize * 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    subtitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ...childrens,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
