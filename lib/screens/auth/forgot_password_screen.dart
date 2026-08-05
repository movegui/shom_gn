import 'package:flutter/material.dart';
import 'package:shom_gn/consts/widget_constants.dart';
import 'package:shom_gn/responsive.dart';
import 'package:shom_gn/widgets/app/app_image.dart';
import 'package:shom_gn/widgets/app/separator_widget.dart';
import 'package:shom_gn/widgets/auth/login_forget_password_page.dart';




class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key,});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }



  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }


    @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
        });
      },
      child: Scaffold(
        body: Responsive.isDesktop(context) ? buildDeskop() : buildMobil(),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget buildMobil() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(heightScale: 0.20,),
              SeparatorWidget(height: WidgetConstants.sepWidgetHeight,),
              LoginForgetPasswordPage(),
           
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeskop() {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(width: 10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }




/*
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      

      
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              // Section 1 - Header
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.forgotPassword,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const TitlesTextWidget(
                label: 'Forgot password',
                fontSize: 22,
              ),
              const SubtitleTextWidget(
                label:
                    'Please enter the email address you\'d like your password reset information sent to',
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'youremail@email.com',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(IconlyLight.message),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.send),
                  label: const Text(
                    "Request link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    _forgetPassFCT();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  */
}
