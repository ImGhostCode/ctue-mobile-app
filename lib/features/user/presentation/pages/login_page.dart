import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/auth/business/entities/login_entity.dart';
import 'package:ctue_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isButtonEnabled = false; // Add this variable

  String _password = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Đăng nhập',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/welcome', (route) => false);
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
                'Email',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                decoration: InputDecoration(
                  // errorText: failure ?? failure.errorMessage,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red.shade400)),

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
                onSaved: (value) {
                  _email = value!; // Save the entered name
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email của bạn';
                  } else if (!isEmailValid(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
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
                onSaved: (value) {
                  _password = value!; // Save the entered name
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Mật khẩu ít nhât 6 ký tự';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/reset-password');
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                  ),
                ],
              ),

              const Spacer(), // Add Spacer to push the button to the bottom
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  //     (Set<MaterialState> states) {
                  //       if (states.contains(MaterialState.disabled)) {
                  //         return Colors.grey; // Color for disabled state
                  //       } else {
                  //         return Theme.of(context)
                  //             .colorScheme
                  //             .primary; // Color for enabled state
                  //       }
                  //     },
                  //   ),
                  // ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save(); // Save the form data

                      // Call your authentication method
                      await Provider.of<AuthProvider>(context, listen: false)
                          .eitherFailureOrLogin(
                              email: _email,
                              password: _password,
                              fcmToken: 'test');

                      // Get the updated values
                      if (!context.mounted) return;

                      Failure? updatedFailure =
                          Provider.of<AuthProvider>(context, listen: false)
                              .failure;
                      LoginEntity? loginEntity =
                          Provider.of<AuthProvider>(context, listen: false)
                              .loginEntity;

                      if (updatedFailure != null) {
                        // Show a SnackBar with the failure message
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
                      } else if (loginEntity?.accessToken != null) {
                        // Navigate to the next screen
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                      }
                    }
                  },

                  child: Text(
                    'Đăng nhập',
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
                    'Bạn chưa có tài khoản?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/sign-up');
                        },
                        child: Text('Đăng ký',
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
}
