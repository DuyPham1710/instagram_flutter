import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/create_user_dto.dart';
import 'package:instagram_flutter/providers/auth_provider.dart';
import 'package:instagram_flutter/screens/auth/otp_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final fullName = TextEditingController();
  FocusNode fullName_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  @override
  void dispose() {
    email.dispose();
    email_F.dispose();
    fullName.dispose();
    fullName_F.dispose();
    username.dispose();
    username_F.dispose();
    password.dispose();
    password_F.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 96.w, height: 80.h),
              Center(child: Image.asset('images/logo.jpg')),
              SizedBox(height: 14.h),
              Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                'Sign up to see photos and videos from your friends.',
                style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
              ),
              SizedBox(height: 24.h),
              Textfield(
                controller: email,
                focusNode: email_F,
                typename: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: 12.h),
              Textfield(
                controller: fullName,
                focusNode: fullName_F,
                typename: 'Full Name',
                icon: Icons.person,
              ),
              SizedBox(height: 12.h),
              Textfield(
                controller: username,
                focusNode: username_F,
                typename: 'Username',
                icon: Icons.person,
              ),
              SizedBox(height: 12.h),
              Textfield(
                controller: password,
                focusNode: password_F,
                typename: 'Password',
                icon: Icons.lock,
              ),
              SizedBox(height: 20.h),
              SignUp(),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Text(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  'By signing up, you agree to our Terms & Privacy Policy.',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
              ),
              Spacer(),
              Login(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Have an account?  ",
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Log in",
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

  Padding SignUp() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: _isLoading ? null : _handleSignUp,

            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Sign Up',
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
                color: Colors.black.withOpacity(0.4),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Padding Textfield({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String typename,
    required IconData icon,
  }) {
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
          controller: controller,
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

  Future<void> _handleSignUp() async {
    setState(() => _isLoading = true);

    final dto = CreateUserDto(
      fullName: fullName.text.trim(),
      email: email.text.trim(),
      username: username.text.trim(),
      password: password.text.trim(),
    );

    final authProvider = context.read<AuthProvider>();

    final errorMessage = await authProvider.register(dto);

    if (!mounted) return;

    if (errorMessage == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OtpScreen(email: dto.email)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    setState(() => _isLoading = false);
  }
}
