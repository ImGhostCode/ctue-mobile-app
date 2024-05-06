import 'dart:async';

import 'package:ctue_app/features/user/presentation/pages/reset_password_page.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _countdownSeconds = 60;
  Timer? _countdownTimer;
  int? pin_1;
  int? pin_2;
  int? pin_3;
  int? pin_4;
  int? pin_5;
  int? pin_6;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _startCountdown();
    super.initState();
  }

  void _startCountdown() {
    const oneSec = Duration(seconds: 1);
    _countdownTimer = Timer.periodic(oneSec, (Timer timer) {
      if (_countdownSeconds == 0) {
        setState(() {
          timer.cancel();
          _countdownTimer?.cancel();
        });
      } else {
        setState(() {
          _countdownSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResetPasswordArgs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Nhập mã',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nhập mã gồm 6 chữ số được gửi đến email của bạn',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_1 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                              } else {
                                pin_1 = null;
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {
                              // print('pin1............. $pin1');
                            },
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_2 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                pin_2 = null;
                                FocusScope.of(context).previousFocus();
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {},
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_3 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                pin_3 = null;
                                FocusScope.of(context).previousFocus();
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {},
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_4 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                pin_4 = null;
                                FocusScope.of(context).previousFocus();
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {},
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_5 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                pin_5 = null;
                                FocusScope.of(context).previousFocus();
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {},
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 40,
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin_6 = int.parse(value);
                                FocusScope.of(context).nextFocus();
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty) {
                                pin_6 = null;
                                FocusScope.of(context).previousFocus();
                              }
                              setState(() {});
                            },
                            onSaved: (pin1) {},
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Center(
                child: TextButton(
                  onPressed: Provider.of<UserProvider>(context, listen: true)
                              .isLoading ||
                          _countdownTimer!.isActive
                      ? null
                      : () async {
                          Provider.of<UserProvider>(context, listen: false)
                              .eitherFailureOrGetVerifyCode(args.email);
                          _countdownSeconds = 60;
                          _startCountdown();
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Gửi lại OTP cho tôi',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color:
                                Provider.of<UserProvider>(context, listen: true)
                                            .isLoading ||
                                        _countdownSeconds != 0
                                    ? Colors.black
                                    : Theme.of(context).colorScheme.secondary),
                      ),
                      const Text(' '),
                      _countdownSeconds != 0
                          ? Text(
                              _formatDuration(
                                  Duration(seconds: _countdownSeconds)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(canClick()
                          ? Colors.tealAccent.shade700
                          : Colors.tealAccent.shade700.withOpacity(0.2))),
                  onPressed: Provider.of<UserProvider>(context, listen: true)
                          .isLoading
                      ? null
                      : () async {
                          // _formKey.currentState!.save();
                          if (canClick()) {
                            await Provider.of<UserProvider>(context,
                                    listen: false)
                                .eitherFailureOrResetPassword(
                                    int.parse(
                                        '$pin_1$pin_2$pin_3$pin_4$pin_5$pin_6'),
                                    args.email,
                                    args.newPassword);

                            // ignore: use_build_context_synchronously
                            if (Provider.of<UserProvider>(context,
                                        listen: false)
                                    .statusCode ==
                                200) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    // ignore: use_build_context_synchronously
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .message!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors
                                      .green, // You can customize the color
                                ),
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            } else {
                              setState(() {
                                pin_1 = pin_2 =
                                    pin_3 = pin_4 = pin_5 = pin_6 = null;
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    // ignore: use_build_context_synchronously
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .failure!
                                        .errorMessage,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Colors.red, // You can customize the color
                                ),
                              );
                            }
                          }
                        },
                  child:
                      Provider.of<UserProvider>(context, listen: true).isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Xác nhận',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                ),
              ),
            ]),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  bool canClick() {
    return pin_1 != null &&
        pin_2 != null &&
        pin_3 != null &&
        pin_4 != null &&
        pin_5 != null &&
        pin_6 != null;
  }
}
