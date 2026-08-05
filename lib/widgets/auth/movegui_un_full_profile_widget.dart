import 'dart:io';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movegui/consts/app_colors.dart';
import 'package:movegui/consts/route_contants.dart';
import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/l10n/app_localizations.dart';
import 'package:movegui/models/button_item.dart';
import 'package:movegui/responsive.dart';
import 'package:movegui/services/my_app_functions.dart';
import 'package:movegui/widgets/app/app_image.dart';
import 'package:movegui/widgets/app/image_picker_widget.dart';
import 'package:movegui/widgets/error/message_widget.dart';
import 'package:movegui/widgets/movegui/movegui_mobile_image_widget.dart';
import 'package:movegui/widgets/movegui/movegui_text_widget.dart';
import 'package:movegui/widgets/person/birthdate_picker.dart';
import 'package:movegui/widgets/person/gender_picker.dart';
import 'package:movegui/widgets/person/personal_base_info_widget.dart';
import 'package:movegui/widgets/util/button_widget.dart';

class MoveguiUnFullProfileWidget extends StatefulWidget {
  final Future<void> Function() imagePicker;
  final File? pickedImage;
  final Uint8List? webImage;
  final VoidCallback removeImage;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<DateTime?>? onBirthDateChanged;
  final String? selectedGender;

  const MoveguiUnFullProfileWidget({
    super.key,
    required this.imagePicker,
    this.pickedImage,
    this.webImage,
    required this.removeImage,
    required this.onGenderChanged,
    this.onBirthDateChanged,
    this.selectedGender,
  });

  @override
  State<StatefulWidget> createState() => MoveguiProfileScreenState();
}

class MoveguiProfileScreenState extends State<MoveguiUnFullProfileWidget> {
  FirebaseAuth? auth;
  XFile? _pickedImage;
  File? pickedImage;
  Uint8List? webImage;

  late String gender;
  late DateTime birthdate;

  late final TextEditingController _phoneNumberController,
      _nameController,
      _prenomController,
      _adressController;
  late final FocusNode _phoneNumberFocusNode,
      _nameFocusNode,
      _prenomFocusNode,
      _adressFocusNode;

  final _formkey = GlobalKey<FormState>();

  Future<void> localImagePicker(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      },
      galleryFCT: () async {
        final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file == null) return;
        final bytes = await file.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      },
      removeFCT: () {
        setState(() {
          webImage = null;
        });
      },
    );
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _prenomController = TextEditingController();
    _adressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _phoneNumberFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _prenomFocusNode = FocusNode();
    _adressFocusNode = FocusNode();
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _phoneNumberController.dispose();
      _phoneNumberFocusNode.dispose();
    }
    super.dispose();
  }

  _registerFCT(BuildContext context, ButtonItem item) {
    if (!item.enabled) {
      MessageWidget.errorMessage(
        context,
        AppLocalizations.of(context)!.deactivate_button_title,
        AppLocalizations.of(context)!.deactivate_button_message,
        Icon(Icons.error, color: AppColors.error),
        FlushbarPosition.TOP,
      );
    } else{
        context.push(item.routeName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {});
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDesktop() : buildMobil(),
      ),
    );
  }

  Widget buildMobil() {
    var Size = MediaQuery.of(context).size;
    return auth?.currentUser != null
        ? Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(heightScale: 0.10),

                  Padding(
                    padding: const EdgeInsets.all(
                      WidgetConstants.sepWidgetHeight,
                    ),
                    child: ImagePickerWidget(
                      webImage: widget.webImage,
                      pickedImage: widget.pickedImage,
                      onPickImage: widget.imagePicker,
                      onRemoveImage: widget.removeImage,
                      width: Size.width * 0.40,
                      height: Size.height * 0.20,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: WidgetConstants.sepWidgetHeight,
                      left: WidgetConstants.sepWidgetHeight,
                    ),
                    child: GenderPicker(
                      onGenderChanged: (value) {
                        widget.onGenderChanged(value);
                      },
                      gender: widget.selectedGender,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: WidgetConstants.sepWidgetHeight,
                      left: WidgetConstants.sepWidgetHeight,
                    ),
                    child: BirthdatePicker(
                      onBirthDateChanged: (value) {
                        widget.onBirthDateChanged?.call(value);
                      },
                    ),
                  ),

                  PersonalBaseInfoWidget(
                    firstNameController: _nameController,
                    lastNameController: _prenomController,
                    addressController: _adressController,
                    firstNameFocus: _nameFocusNode,
                    lastnameFocus: _prenomFocusNode,
                    addressFocus: _adressFocusNode,
                  ),
                ],
              ),
            ),
          ),
        )
        : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MoveguiMobileImageWidget(),
              MoveguiTextWidget(),
              ButtonWidget(
                onPressed: (context, buttomItem) async {
                  _registerFCT(context, buttomItem);
                },
                buttonItem: ButtonItem(
                  AppLocalizations.of(context)!.label_login,
                  AppLocalizations.of(context)!.tooltip_sign_in,
                  true,
                  routeName: RouteContants.LOGIN_ROUTE,
                  fontSize: WidgetConstants.buttonFonsize * 1.5,
                ),
                icon: Ionicons.person,
                fontSize: 32,
              ),
            ],
          ),
        );
  }

  Widget buildDesktop() {
    return Center(
      child: Container(
        width: 500,
        //   height: 500,
        decoration: BoxDecoration(
          color: AppColors.textColor,
          border: Border.all(color: AppColors.backgroundColor, width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [AppImage()],
        ),
      ),
    );
  }
}
