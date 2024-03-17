import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogNumberInput extends StatefulWidget {
  final String title;
  final dynamic initialValue;
  final void Function(int) callback;
  const DialogNumberInput(
      {super.key,
      required this.title,
      required this.initialValue,
      required this.callback});

  @override
  State<DialogNumberInput> createState() => _DialogNumberInputState();
}

class _DialogNumberInputState extends State<DialogNumberInput> {
  late TextEditingController _numberController;
  String? error;
  @override
  void initState() {
    _numberController =
        TextEditingController(text: widget.initialValue.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _numberController,

              decoration: InputDecoration(
                // errorText: failure ?? failure.errorMessage,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red.shade400)),
                errorText: error ?? error,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: 'Nhập số câu',
                helperText: 'Tối thiểu 5 câu, tối đa 50 câu',
                alignLabelWithHint: true,
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  // _numberController.text = value;
                });
              },
              // keyboardType: TextInputType.number,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly
              // ], // Only numbers can be entered
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.secondary.withOpacity(
                              _numberController.text.isEmpty ? 0.7 : 1)),
                    ),
                    onPressed: _numberController.text.isNotEmpty
                        ? () {
                            int value = int.parse(_numberController.text);
                            if (value < 5 || value > 50) {
                              setState(() {
                                error = 'Tối thiểu 5 câu, tối đa 50 câu';
                              });
                              return;
                            }
                            widget.callback(value);
                          }
                        : null,
                    child: const Text('Xác nhận')),
              ],
            ),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
