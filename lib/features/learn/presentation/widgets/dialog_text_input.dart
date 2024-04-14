import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogTextInput extends StatefulWidget {
  final String title;
  final dynamic initialValue;
  final void Function(String) callback;
  const DialogTextInput(
      {super.key,
      required this.title,
      required this.initialValue,
      required this.callback});

  @override
  State<DialogTextInput> createState() => _DialogTextInputState();
}

class _DialogTextInputState extends State<DialogTextInput> {
  late TextEditingController _titleController;
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              controller: _titleController,
              decoration: InputDecoration(
                // errorText: failure ?? failure.errorMessage,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red.shade400)),

                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: 'Nhập tên bộ từ',
                alignLabelWithHint: true,
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              onChanged: (value) {
                setState(() {
                  // _titleController.text = value;
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
                              _titleController.text.isEmpty ? 0.7 : 1)),
                    ),
                    onPressed: _titleController.text.isNotEmpty
                        ? () {
                            widget.callback(_titleController.text);
                          }
                        : null,
                    child: Provider.of<VocaSetProvider>(context, listen: true)
                            .isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : const Text('Xác nhận')),
              ],
            ),
            // const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
