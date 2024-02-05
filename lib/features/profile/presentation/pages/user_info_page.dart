import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEdited = false;
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: isEdited
                  ? () {
                      if (_formKey.currentState!.validate()) {}
                    }
                  : null,
              child: Text(
                'Cập nhật',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isEdited
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey),
              ))
        ],
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onTap: () async {
              final XFile? newImage =
                  await picker.pickImage(source: ImageSource.gallery);
              print(newImage);

              if (newImage != null) {
                setState(() {
                  isEdited = true;
                  pickedImage = newImage;
                });
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.teal, // Set background color as needed
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
                        : Image.network(
                            'https://logowik.com/content/uploads/images/flutter5786.jpg',
                            fit: BoxFit.cover,
                          ),
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
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextFormField(
                          initialValue: 'Liem',
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintText: 'Nhập tên của bạn',
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
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
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.labelMedium,
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            hintText: 'Nhập email của bạn',
                            alignLabelWithHint: true,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
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
    );
  }
}
