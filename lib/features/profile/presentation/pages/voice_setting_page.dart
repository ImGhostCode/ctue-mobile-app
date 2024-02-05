import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const List<String> list = <String>['Google US English', 'Google UK English'];

class VoiceSettingPage extends StatefulWidget {
  VoiceSettingPage({Key? key}) : super(key: key);
  @override
  State<VoiceSettingPage> createState() => _VoiceSettingPageState();
}

class _VoiceSettingPageState extends State<VoiceSettingPage> {
  String dropdownValue = list.first;
  double _currentSliderValue = 20;

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
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.rectangle),
                child: DropdownMenu<String>(
                  initialSelection: list.first,
                  width: MediaQuery.of(context).size.width - 32,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey.shade800),
                  menuStyle: const MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  dropdownMenuEntries:
                      list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Âm lượng',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(
                    Icons.volume_up,
                    size: 25,
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 5,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Tốc độ đọc',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(
                    Icons.mic,
                    size: 25,
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 5,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}
