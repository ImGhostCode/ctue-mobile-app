import 'dart:io';

import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEdited = false;
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  String newName = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      // Access the list of topics from the provider
      UserEntity? userDetail = userProvider.userEntity;

      bool isLoading = userProvider.isLoading;

      // Access the failure from the provider
      Failure? failure = userProvider.failure;

      if (failure != null) {
        // Handle failure, for example, show an error message
        return Text(failure.errorMessage);
      } else if (!isLoading && userDetail == null) {
        // Handle the case where topics are empty
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
          enabled: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Thông tin cá nhân',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.navigate_before,
                    size: 32,
                  )),
              actions: [
                TextButton(
                    onPressed: canUpdate(context)
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              await userProvider.eitherFailureOrUpdateUser(
                                userDetail?.id ?? 0,
                                pickedImage,
                                newName,
                              );

                              if (failure != null) {
                                // Show a SnackBar with the failure message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(
                                      failure.errorMessage,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors
                                        .red, // You can customize the color
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(
                                      'Cập nhật thông tin thành công',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors
                                        .green, // You can customize the color
                                  ),
                                );
                              }

                              Navigator.of(context).pop();
                            }
                          }
                        : null,
                    child: Text(
                      'Cập nhật',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: canUpdate(context)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey),
                    ))
              ],
            ),
            body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final XFile? newImage =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (newImage != null) {
                          setState(() {
                            isEdited = true;
                            pickedImage = newImage;
                          });
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            Colors.white, // Set background color as needed
                        radius: 40,
                        // Set border properties
                        // foregroundColor: Colors.teal, // Border color
                        child: Stack(alignment: Alignment.center, children: [
                          ClipOval(
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: pickedImage != null
                                  ? Image.file(
                                      File(pickedImage!.path),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Provider.of<UserProvider>(context)
                                              .userEntity!
                                              .avt !=
                                          null
                                      ? Image.network(
                                          userDetail?.avt ?? '',
                                          fit: BoxFit.cover,
                                        )
                                      : const FlutterLogo(),
                            ),
                          ),
                          const Positioned(
                              bottom: 2,
                              child: Icon(
                                Icons.camera_alt,
                              ))
                        ]),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Tên tài khoản',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    initialValue: userDetail?.name,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                      hintText: 'Nhập tên của bạn',
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập tên của bạn';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        isEdited = true;
                                        newName = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Email',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  TextFormField(
                                    initialValue: 'test@gmail.com',
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey
                                          .shade300, // Set your desired background color
                                      filled: true,
                                      enabled: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                      hintText: 'Nhập email của bạn',
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400)),
                                    ),
                                    validator: (String? value) {
                                      // if (value == null || value.isEmpty) {
                                      //   return 'Vui lòng nhập email của bạn';
                                      // } else if (!isEmailValid(value)) {
                                      //   return 'Email khong hop le';
                                      // }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ])))
                  ]),
            ),
          ),
        );
      }
    });
  }

  bool canUpdate(BuildContext context) {
    return !Provider.of<UserProvider>(context, listen: true).isLoading &&
        isEdited &&
        (newName.isNotEmpty || pickedImage != null) &&
        (newName != Provider.of<UserProvider>(context).userEntity!.name ||
            !areImagesEqual(pickedImage));
  }

  bool areImagesEqual(XFile? newImage) {
    // Compare the paths of the old and new images
    return pickedImage != null &&
        newImage != null &&
        pickedImage!.path == newImage.path;
  }
}
