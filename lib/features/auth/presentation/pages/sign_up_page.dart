import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;
  bool isButtonEnabled = false; // Add this variable
  bool isPasswordsMatch = false;
  final TextEditingController _passwordController = TextEditingController();
  String _name = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  List<TopicEntity> listWordTopics = [];
  List<TopicEntity> listSentenceTopics = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    listWordTopics = await Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);
    listSentenceTopics =
        await Provider.of<TopicProvider>(context, listen: false)
            .eitherFailureOrTopics(null, false, null);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tạo tài khoản',
          style: Theme.of(context).textTheme.titleLarge,
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
      ),
      body: Form(
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
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: 'Nhập tên của bạn',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên của bạn';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _name = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email của bạn',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: 'Nhập email của bạn',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email của bạn';
                  } else if (!isEmailValid(value)) {
                    return 'Email khong hop le';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _email = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Mật khẩu',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: 'Nhập mật khẩu',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      }),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Mật khẩu ít nhât 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nhập lại mật khẩu',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                obscureText: !isRePasswordVisible,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  hintText: 'Nhập mật khẩu',
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        isRePasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isRePasswordVisible = !isRePasswordVisible;
                        });
                      }),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Mật khẩu ít nhât 6 ký tự';
                  } else if (value != _passwordController.text) {
                    return 'Mật khẩu không trùng khớp';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Chủ đề yêu thích của bạn',
                style: Theme.of(context).textTheme.labelMedium,
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
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20))),
                    onPressed: () {
                      _dialogTopicBuilder(context);
                    },
                    child: Text(
                      'Chọn chủ đề',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: Provider.of<AuthProvider>(context, listen: true)
                          .isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save(); // Save the form data

                            // Call your authentication method
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .eitherFailureOrSignup(
                              name: _name,
                              email: _email,
                              password: _passwordController.text,
                              interestTopics: getSelectedTopics(
                                  listWordTopics, listSentenceTopics),
                            );

                            // // Get the updated values
                            // if (!context.mounted) return;

                            // ignore: use_build_context_synchronously
                            Failure? updatedFailure = Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .failure;
                            AccountEntity? updatedAccount =
                                // ignore: use_build_context_synchronously
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .accountEntity;

                            if (updatedFailure != null) {
                              // Show a SnackBar with the failure message
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    updatedFailure.errorMessage,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Colors.red, // You can customize the color
                                ),
                              );
                            } else if (updatedAccount != null) {
                              // Navigate to the next screen
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                    'Đăng ký tài khoản thành công',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Colors.red, // You can customize the color
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (_) => false);
                            }
                          }
                        },
                  child:
                      Provider.of<AuthProvider>(context, listen: true).isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Đăng ký',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn đã có tài khoản',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Đăng nhập',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogTopicBuilder(BuildContext context) {
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
}

List<int>? getSelectedTopics(
    List<TopicEntity> listWordTopics, List<TopicEntity> listSentenceTopics) {
  List<int> selectedTopics = [];
  for (var element in listWordTopics) {
    if (element.isSelected) {
      selectedTopics.add(element.id);
    }
  }
  for (var element in listSentenceTopics) {
    if (element.isSelected) {
      selectedTopics.add(element.id);
    }
  }
  return selectedTopics.isNotEmpty ? selectedTopics : null;
}
