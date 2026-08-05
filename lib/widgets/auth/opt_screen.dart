import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId, required ConfirmationResult? confirmationResult});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  int resendSeconds = 60;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    Future.doWhile(() async {
      if (resendSeconds == 0) return false;
      await Future.delayed(const Duration(seconds: 1));
      setState(() => resendSeconds--);
      return true;
    });
  }

  Future<void> verifyCode() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Success → user is signed in (StreamBuilder will react)
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "Invalid code";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void resendCode() {
    // You’ll need to pass phone number + resendToken from previous screen
    print("Resend not implemented yet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Enter the 6-digit code sent to your phone",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "OTP Code",
                counterText: "",
              ),
            ),

            const SizedBox(height: 10),

            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : verifyCode,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Verify"),
            ),

            const SizedBox(height: 20),

            resendSeconds > 0
                ? Text("Resend code in $resendSeconds s")
                : TextButton(
                    onPressed: resendCode,
                    child: const Text("Resend Code"),
                  ),
          ],
        ),
      ),
    );
  }
}