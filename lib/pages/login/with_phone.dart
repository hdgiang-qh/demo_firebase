import 'package:demo_firebase/home/home_scr.dart';
import 'package:flutter/material.dart';

import "package:firebase_auth/firebase_auth.dart";

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Gửi mã OTP
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onError,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Tự động xác thực trên Android
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage = 'Đã xảy ra lỗi';
          if (e.code == 'invalid-phone-number') {
            errorMessage = 'Số điện thoại không hợp lệ';
          }
          onError(errorMessage);
        },
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      onError('Đã xảy ra lỗi khi gửi mã OTP');
    }
  }

  // Xác thực OTP
  Future<String?> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      return null; // Thành công
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-verification-code':
          return 'Mã OTP không đúng';
        default:
          return 'Lỗi xác thực: ${e.message}';
      }
    }
  }
}

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneAuthService = PhoneAuthService();

  String? _verificationId;
  bool _isLoading = false;
  bool _codeSent = false;

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await _phoneAuthService.sendOTP(
        phoneNumber: '+84${_phoneController.text.trim().substring(1)}',
        onCodeSent: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            _codeSent = true;
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đã gửi mã OTP')),
          );
        },
        onError: (String errorMessage) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        },
      );
    }
  }

  Future<void> _verifyOTP() async {
    if (_verificationId == null) return;

    setState(() {
      _isLoading = true;
    });

    final error = await _phoneAuthService.verifyOTP(
      verificationId: _verificationId!,
      smsCode: _otpController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    } else {
      // Xác thực thành công
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập với số điện thoại'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_codeSent) ...[
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    hintText: '0xxxxxxxxx',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (value.length != 10) {
                      return 'Số điện thoại phải có 10 chữ số';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendOTP,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Gửi mã OTP'),
                ),
              ] else ...[
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    labelText: 'Mã OTP',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mã OTP';
                    }
                    if (value.length != 6) {
                      return 'Mã OTP phải có 6 chữ số';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: _isLoading ? null : _sendOTP,
                      child: const Text('Gửi lại mã'),
                    ),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _verifyOTP,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Xác nhận'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}

