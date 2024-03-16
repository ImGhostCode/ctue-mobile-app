import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  const Reminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue.shade100,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)]),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đã đến lúc ôn tập',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '3 từ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue.shade800)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/learn');
                        },
                        child: const Text('Ôn tập ngay')),
                  )
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/note.png',
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }
}
