import 'package:flutter/material.dart';

class WordDetailInVocaSet extends StatefulWidget {
  const WordDetailInVocaSet({super.key});

  @override
  State<WordDetailInVocaSet> createState() => _WordDetailInVocaSetState();
}

class _WordDetailInVocaSetState extends State<WordDetailInVocaSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text('B1',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'test',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
              ],
            ),
            Text(
              '/tɛst/',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.normal, fontFamily: 'DoulosSIL'),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://cdn-blog.novoresume.com/articles/career-aptitude-test/bg.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: 5),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: 'Nghĩa của từ ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'test',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  // TextSpan(text: ' world!'),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ...List.generate(
                2,
                (index) => Row(
                      children: [
                        Text(
                          'Danh từ.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '- thử nghiệm, thử, kiểm tra',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal),
                        ),
                      ],
                    )),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Câu ví dụ:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            ...List.generate(
                2,
                (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                              'The class are doing/having a spelling test today. dddd ddd ddd dd',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                        )
                      ],
                    )),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thuộc chuyên ngành: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Text(
                    'Công nghệ thông tin (Information Technology)',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Từ đồng nghĩa: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Text(
                    'experiment, try, prove',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Từ trái nghĩa: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                // Flexible(
                //   child: Text(
                //     'Công nghệ thông tin (Information Technology)',
                //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //         color: Colors.black87, fontWeight: FontWeight.normal),
                //   ),
                // ),
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Ghi chú: ',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            //     ),
            //     Flexible(
            //       child: Text(
            //         'không có',
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //             color: Colors.black87, fontWeight: FontWeight.normal),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'Chủ đề: ',
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium!
            //       .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            // ),
            // Container(
            //   // height: 200,
            //   // width: MediaQuery.of(context).size.width - 32,
            //   padding: const EdgeInsets.all(8),
            //   child: Wrap(
            //     spacing: 4, // Adjust the spacing between items as needed
            //     runSpacing: 5,
            //     children: List.generate(
            //       _topics.length,
            //       (index) => Chip(
            //         avatar: ClipOval(
            //           child: Image.network(
            //             _topics[index].picture,
            //             fit: BoxFit.cover,
            //             width: 60.0,
            //             height: 60.0,
            //           ),
            //         ),
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //         shape: RoundedRectangleBorder(
            //           side: BorderSide(
            //             color: Colors.tealAccent.shade200,
            //           ),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         label: Text(_topics[index].title),
            //         backgroundColor: Colors.white,
            //         labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               fontWeight: FontWeight.normal,
            //               color: Theme.of(context).colorScheme.primary,
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(),
          ]),
    );
  }
}
