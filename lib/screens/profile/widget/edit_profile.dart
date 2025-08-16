import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/apps/utils/image_util.dart';
import 'package:instagram_flutter/dto/update_user_dto.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserResponseDto? user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;

  late TextEditingController _fullNameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;

  bool _hasChanges = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.user?.fullName ?? "",
    );
    _usernameController = TextEditingController(
      text: widget.user?.username ?? "",
    );
    _bioController = TextEditingController(text: widget.user?.bio ?? "");

    // lắng nghe thay đổi
    _fullNameController.addListener(_checkChanges);
    _usernameController.addListener(_checkChanges);
    _bioController.addListener(_checkChanges);
  }

  void _checkChanges() {
    final changed =
        _fullNameController.text != (widget.user?.fullName ?? "") ||
        _usernameController.text != (widget.user?.username ?? "") ||
        _bioController.text != (widget.user?.bio ?? "") ||
        _imageFile != null;

    if (changed != _hasChanges) {
      setState(() {
        _hasChanges = changed;
      });
    }
  }

  Future<void> _onPickImage() async {
    final file = await ImageUtil.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _imageFile = file;
        _hasChanges = true;
      });
    }
  }

  Future<void> _updateUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dto = UpdateUserDto(
        fullName: _fullNameController.text,
        username: _usernameController.text,
        bio: _bioController.text,
      );

      String? errorMessage = await Provider.of<UserProvider>(
        context,
        listen: false,
      ).updateUserProfile(dto, avatarFile: _imageFile);

      if (errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      } else {
        // trả về true báo cho màn trước biết là có update
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Cập nhật thất bại: $e")));
    } finally {
      setState(() {
        _isLoading = false;
        _hasChanges = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                if (_hasChanges && !_isLoading)
                  TextButton(
                    onPressed: _updateUser,
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
              leading: IconButton(
                icon: Icon(CupertinoIcons.back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : (widget.user?.avatarUrl != null
                                    ? NetworkImage(widget.user!.avatarUrl!)
                                          as ImageProvider
                                    : const AssetImage("images/avt.jpg")),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: _onPickImage,
                          child: Text(
                            "Change profile picture",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Full Name
                  TextField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Username
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Bio
                  TextField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: "Bio",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Add link",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Add banners",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Gender dropdown
                  DropdownButtonFormField<String>(
                    value: "Male",
                    decoration: InputDecoration(
                      labelText: "Gender",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (value) {
                      // update gender
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),

        if (_isLoading)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          ),
      ],
    );
  }
}
