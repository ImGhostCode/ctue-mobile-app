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
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.custom(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, crossAxisSpacing: 5, mainAxisSpacing: 5),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              int row = index ~/ ipaKeyboardLayout[0].length;
              int col = index % ipaKeyboardLayout[row].length;
              return IPAKeyButton(
                text: ipaKeyboardLayout[row][col],
                onTap: onTap,
              );
            },
            childCount: 48,
          ),
        ),
      ),
    );
  }
}

class IPAKeyButton extends StatelessWidget {
  final String text;
  final void Function(String) onTap;
  const IPAKeyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(text),
      child: Container(
        // padding: EdgeInsets.all(6),
        // margin: const EdgeInsets.all(3),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
            color: Colors.blueAccent.shade200,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: text == 'Backspace'
                ? const Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                  )
                : Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: 'DoulosSIL'),
                  )),
      ),
    );
  }
}
