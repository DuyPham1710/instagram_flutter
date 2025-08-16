import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/login_dto.dart';
import 'package:instagram_flutter/providers/auth_provider.dart';
import 'package:instagram_flutter/screens/auth/otp_screen.dart';
import 'package:instagram_flutter/screens/auth/register_screen.dart';
import 'package:instagram_flutter/screens/bottom_navigation/bottom_navigation.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 96.w, height: 100.h),
            Center(child: Image.asset('images/logo.jpg')),
            SizedBox(height: 120.h),
            Textfild(email, email_F, 'Email', Icons.email),
            SizedBox(height: 15.h),
            Textfild(password, password_F, 'Password', Icons.lock),
            SizedBox(height: 15.h),
            forget(),
            SizedBox(height: 15.h),
            login(),
            SizedBox(height: 15.h),
            signUp(),
          ],
        ),
      ),
    );
  }

  Widget signUp() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have account?  ",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Text(
              "Sign up ",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });

                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );

                    final loginDto = LoginDto(
                      email: email.text,
                      password: password.text,
                    );

                    final errorMessage = await authProvider.login(loginDto);

                    final token = authProvider.token;

                    setState(() {
                      _isLoading = false;
                    });

                    if (errorMessage == null) {
                      print("Login successful with token: $token");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      );
                    } else {
                      final isNotActivated = errorMessage.contains(
                        "not activated",
                      );

                      showDialog(
                        context: context,
                        builder: (context) {
                          bool isDialogLoading = false;
                          return StatefulBuilder(
                            builder: (context, setDialogState) {
                              return AlertDialog(
                                title: Text('Login Failed'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(errorMessage),
                                    if (isDialogLoading) ...[
                                      SizedBox(height: 16),
                                      CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ],
                                  ],
                                ),
                                actions: [
                                  if (isNotActivated)
                                    TextButton(
                                      onPressed: () async {
                                        setDialogState(
                                          () => isDialogLoading = true,
                                        );

                                        await authProvider.resendOtp(
                                          email.text,
                                        );

                                        setDialogState(
                                          () => isDialogLoading = false,
                                        );

                                        Navigator.pop(context); // đóng dialog
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OtpScreen(email: email.text),
                                          ),
                                        );
                                      },
                                      child: Text('Activate Now'),
                                    ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    }
                  },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.4),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Padding forget() {
    return Padding(
      padding: EdgeInsets.only(left: 230.w),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Padding Textfild(
    TextEditingController controll,
    FocusNode focusNode,
    String typename,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controll,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typename,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.w, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 2.w, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
