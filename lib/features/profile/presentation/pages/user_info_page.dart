import 'dart:io';

import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
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
  bool _dataInitialized = false; // Flag to track initialization
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEdited = false;
  bool isEditedTopic = false;
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  String newName = '';

  List<TopicEntity> listWordTopics = [];
  List<TopicEntity> listSentenceTopics = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void initializeData() async {
    listWordTopics = await Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);
    listSentenceTopics =
        await Provider.of<TopicProvider>(context, listen: false)
            .eitherFailureOrTopics(null, false, null);

    UserEntity? userEntity =
        Provider.of<UserProvider>(context, listen: false).userEntity;

    if (userEntity != null) {
      List<int>? interestIdTopics =
          userEntity.interestTopics?.map((e) => e.id).toList();
      for (var element in listWordTopics) {
        element.isSelected = interestIdTopics?.contains(element.id) ?? false;
      }
      for (var element in listSentenceTopics) {
        element.isSelected = interestIdTopics?.contains(element.id) ?? false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataInitialized) {
      initializeData();
      _dataInitialized = true;
    }
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
                              List<int>? selectedTopics = getSelectedTopics(
                                  listWordTopics, listSentenceTopics);
                              await userProvider.eitherFailureOrUpdateUser(
                                userDetail!.id,
                                pickedImage,
                                newName,
                                selectedTopics,
                              );

                              Navigator.pop(context);

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
                            await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

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
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/broken-image.png',
                                            color: Colors.grey.shade300,
                                            fit: BoxFit.cover,
                                          ),
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
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Chủ đề yêu thích của bạn',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            // side: MaterialStatePropertyAll(
                                            //     BorderSide(color: Colors.green, width: 3)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    (Provider.of<TopicProvider>(
                                                                    context,
                                                                    listen:
                                                                        true)
                                                                .isLoading ||
                                                            isLoading)
                                                        ? Colors.grey.shade300
                                                        : Colors.blue),
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 20))),
                                        onPressed: Provider.of<TopicProvider>(
                                                    context,
                                                    listen: true)
                                                .isLoading
                                            ? null
                                            : () {
                                                _dialogTopicBuilder(
                                                    context, userDetail, () {
                                                  setState(() {
                                                    isEditedTopic = true;
                                                  });
                                                });
                                              },
                                        child: Text(
                                          'Chọn chủ đề',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ]))),
                  ]),
            ),
          ),
        );
      }
    });
  }

  Future<void> _dialogTopicBuilder(
      BuildContext context, UserEntity? user, VoidCallback callback) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: const EdgeInsets.all(16),
            title: Text(
              'Chọn chủ đề',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.blue),
            ),
            content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Từ vựng',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        children: listWordTopics
                            .map((topic) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      topic.isSelected = !topic.isSelected;
                                      callback();
                                    });
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: topic.isSelected
                                              ? Colors.green.shade500
                                              : Colors.grey.shade100,
                                          width: 2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: topic.image.isNotEmpty
                                              ? Image.network(
                                                  topic.image,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/broken-image.png',
                                                    color: Colors.grey.shade300,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  width: 60.0,
                                                  height: 60.0,
                                                )
                                              : Container(),
                                        ),
                                        Text(
                                          topic.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Câu giao tiếp',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: listSentenceTopics
                            .map(
                              (topic) => ActionChip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // Set the border radius here
                                  ),
                                  side: BorderSide(
                                      color: topic.isSelected
                                          ? Colors.green.shade500
                                          : Colors.grey.shade100,
                                      width: 2),
                                  // backgroundColor: topic.isSelected
                                  //     ? Colors.green.shade500
                                  //     : Colors.white,
                                  label: Text(
                                    topic.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      topic.isSelected = !topic.isSelected;
                                      callback();
                                    });
                                  }),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                )),
            actions: <Widget>[
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.grey.shade400,
              //     textStyle: Theme.of(context).textTheme.labelLarge,
              //   ),
              //   child: const Text('Đóng'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Xác nhận'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool canUpdate(BuildContext context) {
    // bool areImagesEqual(XFile? newImage) {
    //   // Add the missing function
    //   // Compare the paths of the old and new images
    //   return pickedImage != null &&
    //       newImage != null &&
    //       pickedImage!.path == newImage.path;
    // }

    return !Provider.of<UserProvider>(context, listen: true).isLoading &&
        (isEdited ||
            (newName.isNotEmpty || pickedImage != null) ||
            (newName.isEmpty && pickedImage != null) ||
            (newName != Provider.of<UserProvider>(context).userEntity!.name) ||
            !areImagesEqual(pickedImage) ||
            isEditedTopic);
  }

  bool areImagesEqual(XFile? newImage) {
    // Compare the paths of the old and new images
    return pickedImage != null &&
        newImage != null &&
        pickedImage!.path == newImage.path;
  }
}
