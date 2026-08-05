import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/widgets/input/input_name_widget.dart';


class MyProfileHeaderUpdateName extends StatelessWidget{

  final TextEditingController nameController;
  final FocusNode nameFocusNode;
  final Future<void> Function(String?) onNameUpdate;
  

   const MyProfileHeaderUpdateName({super.key, required this.nameController, required this.nameFocusNode, required this.onNameUpdate});

  @override
  Widget build(BuildContext context) {
   return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputNameWidget(
                        nameController: nameController,
                        nameFocusNode: nameFocusNode,
                        hinterText:
                            AppLocalizations.of(context)!.input_hint_first_name,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        onNameUpdate(nameController.text);
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        child: Icon(
                          IconlyLight.send,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        nameController.clear();
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        child: Icon(
                          Icons.cancel,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
            
              );
  }
}