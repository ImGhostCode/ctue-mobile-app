import 'package:flutter/material.dart';

class IPAKeyboard extends StatelessWidget {
  final void Function(String) onTap;
  IPAKeyboard({super.key, required this.onTap});

  final List<List<String>> ipaKeyboardLayout = [
    ['ɪ', 'iː', 'e', 'ə', 'ɜː', 'u', 'uː', 'ɒ', 'ɔː', 'Backspace'],
    ['ʌ', 'ɑː', 'æ', 'ɪə', 'eə', 'eɪ', 'ɔɪ', 'aɪ', 'əʊ', 'aʊ'],
    ['ʊə', 'p', 'b', 't', 'd', 'tʃ', 'dʒ', 'k', 'g', 'f', 'v'],
    ['ð', 'θ', 's', 'z', 'ʃ', 'ʒ', 'm', 'n', 'ŋ', 'h'],
    ['l', 'r', 'w', 'j', '.', '\'', ',']
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade100, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, crossAxisSpacing: 5, mainAxisSpacing: 5),
          itemCount: 48,
          itemBuilder: (context, index) {
            int row = index ~/ ipaKeyboardLayout[0].length;
            int col = index % ipaKeyboardLayout[row].length;
            return IPAKeyButton(
                text: ipaKeyboardLayout[row][col], onTap: onTap);
          },
        ),
      ),
    );
  }
}

class IPAKeyButton extends StatelessWidget {
  final String text;
  final void Function(String) onTap;
  IPAKeyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(text),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: text == 'Backspace'
                ? const Icon(Icons.keyboard_backspace)
                : Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        fontFamily: 'DoulosSIL'),
                  )),
      ),
    );
  }
}
