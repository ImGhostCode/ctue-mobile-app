import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Google US English', 'Google UK English'];

class VoiceSettingPage extends StatefulWidget {
  const VoiceSettingPage({Key? key}) : super(key: key);
  @override
  State<VoiceSettingPage> createState() => _VoiceSettingPageState();
}

class _VoiceSettingPageState extends State<VoiceSettingPage> {
  String dropdownValue = list.first;
  // double _currentSliderValue = 20;
  VoiceEntity? selectedVoice;

  @override
  void initState() {
    Provider.of<SpeechProvider>(context, listen: false)
        .eitherFailureOrGetVoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: Text(
            'Cài đặt giọng đọc',
            style: Theme.of(context).textTheme.titleMedium,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Giọng',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Consumer<SpeechProvider>(builder: (context, provider, child) {
                List<VoiceEntity> listUSVoices = provider.getUSVoices();
                // VoiceEntity selectedVoice;

                // provider.getSelectedVoice().then((value) => selectedVoice = value);

                bool isLoading = provider.isLoading;

                // Access the failure from the provider
                Failure? failure = provider.failure;

                if (failure != null) {
                  // Handle failure, for example, show an error message
                  return Text(failure.errorMessage);
                } else if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.rectangle),
                    child: DropdownMenu<VoiceEntity>(
                      initialSelection: provider.selectedVoice != null
                          ? listUSVoices.elementAt(listUSVoices
                              .map((e) => e.displayName)
                              .toList()
                              .indexOf(provider.selectedVoice!.displayName))
                          : provider.selectedVoice = listUSVoices.first,
                      width: MediaQuery.of(context).size.width - 32,
                      onSelected: (VoiceEntity? value) {
                        provider.setVoice(value!);
                      },
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey.shade800),
                      menuStyle: const MenuStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      dropdownMenuEntries: listUSVoices
                          .map<DropdownMenuEntry<VoiceEntity>>(
                              (VoiceEntity value) {
                        return DropdownMenuEntry<VoiceEntity>(
                            value: value,
                            label: value.displayName,
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)));
                      }).toList(),
                    ),
                  );
                }
              }),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   'Âm lượng',
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(12)),
              //   child: Row(children: [
              //     const Icon(
              //       Icons.volume_up,
              //       size: 25,
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: _currentSliderValue,
              //         max: 100,
              //         divisions: 5,
              //         label: _currentSliderValue.round().toString(),
              //         onChanged: (double value) {
              //           setState(() {
              //             _currentSliderValue = value;
              //           });
              //         },
              //       ),
              //     ),
              //   ]),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   'Tốc độ đọc',
              //   style: Theme.of(context).textTheme.labelMedium,
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(12)),
              //   child: Row(children: [
              //     const Icon(
              //       Icons.mic,
              //       size: 25,
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: _currentSliderValue,
              //         max: 100,
              //         divisions: 5,
              //         label: _currentSliderValue.round().toString(),
              //         onChanged: (double value) {
              //           setState(() {
              //             _currentSliderValue = value;
              //           });
              //         },
              //       ),
              //     ),
              // ]),
              // )
            ],
          ),
        ));
  }
}
