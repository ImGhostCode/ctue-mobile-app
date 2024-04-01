import 'package:ctue_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class ActionBox extends StatefulWidget {
  final List<WordEntity> words;
  final int vocabularySetId;
  final DateTime? reviewAt;

  const ActionBox(
      {super.key,
      this.words = const [],
      required this.vocabularySetId,
      this.reviewAt});

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateRemainingTime(); // Start updating immediately
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer
    super.dispose();
  }

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.error_outline_sharp,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Flexible(
                        child: Text(
                          widget.vocabularySetId == -1
                              ? 'Bắt đầu học để ghi nhớ từ trong kho từ vựng của bạn nhé'
                              : widget.reviewAt != null
                                  ? 'Bạn có ${widget.words.length} từ vựng cần ôn tập sau ${getRemainingTime()}'
                                  : 'Bắt đầu học để ghi nhớ từ trong kho từ vựng của bạn nhé',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   '3 từ',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .copyWith(color: Colors.red),
                  // ),
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
                                MaterialStatePropertyAll(Colors.blue.shade600)),
                        onPressed: widget.words.isEmpty
                            ? () {
                                Provider.of<SelectedPageProvider>(context,
                                        listen: false)
                                    .changePage(1);
                              }
                            : widget.reviewAt != null &&
                                    DateTime.now().isAfter(widget.reviewAt!)
                                ? () {
                                    Navigator.of(context).pushNamed('/learn',
                                        arguments: LearnringArguments(
                                            words: widget.words,
                                            vocabularySetId:
                                                widget.vocabularySetId));
                                  }
                                : () {
                                    if (Provider.of<SelectedPageProvider>(
                                                context,
                                                listen: false)
                                            .selectedPage !=
                                        1) {
                                      Provider.of<SelectedPageProvider>(context,
                                              listen: false)
                                          .changePage(1);
                                    } else {
                                      // TODO: filter words to learn, excepted user learned words

                                      Navigator.of(context).pushNamed('/learn',
                                          arguments: LearnringArguments(
                                              words: widget.words,
                                              vocabularySetId:
                                                  widget.vocabularySetId));
                                    }
                                  },
                        child: Text(
                            // ''
                            getTextAction()),
                      ))
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

  void _updateRemainingTime() {
    if (widget.reviewAt != null) {
      Duration remainingTime = widget.reviewAt!.difference(DateTime.now());
      if (remainingTime <= Duration.zero) {
        _timer?.cancel();
        setState(() {}); // Update UI if review time is past
      } else {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {}); // Update the UI every second
        });
      }
    }
  }

  String getTextAction() {
    // if (widget.reviewAt != null) {
    //   print(DateTime.now().isBefore(widget.reviewAt!));
    // }

    if (widget.words.isEmpty) {
      return 'Học từ vựng';
    } else if (widget.reviewAt != null &&
        DateTime.now().isAfter(widget.reviewAt!)) {
      return 'Ôn tập ngay';
    } else if (widget.reviewAt != null) {
      // Duration remainingTime = DateTime.parse(widget.reviewAt!
      //         .toString()
      //         .substring(0, widget.reviewAt.toString().length - 1))
      //     .difference(DateTime.now());

      // if (remainingTime <= Duration.zero) {
      //   return 'Ôn tập ngay'; // It's due
      // }

      // // Format remaining time
      // String twoDigits(int n) => n.toString().padLeft(2, '0');
      // String twoDigitMinutes = twoDigits(remainingTime.inMinutes.remainder(60));
      // String twoDigitSeconds = twoDigits(remainingTime.inSeconds.remainder(60));
      // return "${remainingTime.inHours}h:${twoDigitMinutes}m:${twoDigitSeconds}s";
      return 'Học từ mới';
    } else {
      return 'Học từ vựng'; // If reviewAt is null
    }
  }

  String getRemainingTime() {
    Duration remainingTime = DateTime.parse(widget.reviewAt!
            .toString()
            .substring(0, widget.reviewAt.toString().length - 1))
        .difference(DateTime.now());

    if (remainingTime <= Duration.zero) {
      return 'Ôn tập ngay'; // It's due
    }

    // Format remaining time
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(remainingTime.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(remainingTime.inSeconds.remainder(60));
    return "${remainingTime.inHours}h:${twoDigitMinutes}m:${twoDigitSeconds}s";
  }
}

class LearnringArguments {
  List<WordEntity> words = [];
  int vocabularySetId;
  LearnringArguments({required this.words, required this.vocabularySetId});
}
