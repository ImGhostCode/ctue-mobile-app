import 'dart:io';

import 'package:ctue_app/features/contribute/presentation/widgets/ipa_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WordDefinition {
  String? wordType;
  String? meaning;

  WordDefinition({this.wordType, this.meaning});
}

class VocaConForm extends StatefulWidget {
  VocaConForm({Key? key}) : super(key: key);

  @override
  _VocaConFormState createState() => _VocaConFormState();
}

class _VocaConFormState extends State<VocaConForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pronunciationController =
      TextEditingController();
  final TextEditingController _meaningController = TextEditingController();
  final TextEditingController _synonymController = TextEditingController();
  final TextEditingController _antonymController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<WordDefinition> _wordDefinitions = [];
  List<String> _examples = [];
  List<XFile> _selectedImages = [];
  List<Topic> _topics = [
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Doi song',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong1',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong6',
        isSeleted: false),
    Topic(
        id: 1,
        image: 'https://logowik.com/content/uploads/images/flutter5786.jpg',
        name: 'Thong thuong4',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong2',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong3',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'Thong thuong5',
        isSeleted: false),
    Topic(
        id: 1,
        image:
            'https://e7.pngegg.com/pngimages/122/14/png-clipart-life-skills-training-education-daily-life-miscellaneous-leaf-thumbnail.png',
        name: 'The thao',
        isSeleted: false)
  ];

  String? _selectedLevel;
  String? _selectedSpecializaiton;
  bool _isExpanded = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickMultiImage();

    if (pickedFile.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFile;
        // print(_selectedImages);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _handleButtonPress(String label) {
    if (label == 'Backspace') {
      if (_pronunciationController.text.isNotEmpty) {
        _pronunciationController.text = _pronunciationController.text
            .substring(0, _pronunciationController.text.length - 1);
      }
    } else {
      _pronunciationController.text += label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Từ mới',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng điền vào chỗ trống';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phiên âm',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'DoulosSIL',
                ),
                readOnly: true,
                // showCursor: true,
                controller: _pronunciationController,
                onTap: () {
                  _showPronunciationDialog(context);
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng điền vào chỗ trống';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Loại từ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              _buildWordDefinitionList(),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 40,
                child: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _addWordDefinition();
                  },
                ),
              ),
              Text(
                'Bậc của từ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                color: Colors.white,
                child: DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng chọn bậc của từ";
                    }
                    return null;
                  },
                  items: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel = value;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Chuyên ngành',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                color: Colors.white,
                child: DropdownButtonFormField<String>(
                  value: _selectedSpecializaiton,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng chọn chuyên ngành";
                    }
                    return null;
                  },
                  items: ['Xa hoi hoc', 'Cong nghe thong tin', 'Marketing']
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSpecializaiton = value;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Các câu ví dụ',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              _buildExampleList(),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 40,
                child: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _addExample();
                  },
                ),
              ),
              Text(
                'Các từ đồng nghĩa',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _synonymController,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  helperText: 'Viết cách nhau bởi dấy phẩy',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Các từ trái nghĩa',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: _antonymController,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  helperText: 'Viết cách nhau bởi dấy phẩy',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ghi chú',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                maxLines: 4,
                controller: _noteController,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Thêm ảnh minh họa',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                width: 125,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  child: const Row(
                    children: [
                      Icon(Icons.upload),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Tải lên')
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal),
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              File(_selectedImages[index].path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () => _removeImage(index),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: const EdgeInsets.all(0),
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _isExpanded = isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          'Chọn chủ đề',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      );
                    },
                    body: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(5),
                      child: Wrap(
                        spacing: 8.0, // Khoảng cách giữa các Chip
                        children: _topics.asMap().entries.map((entry) {
                          final topic = entry.value;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ActionChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25.0), // Set the border radius here
                                ),
                                side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5),
                                    width: 1.5),
                                backgroundColor: topic.isSeleted
                                    ? Colors.green.shade500
                                    : Colors.grey.shade100,
                                avatar: ClipOval(
                                  child: Image.network(
                                    topic.image,
                                    fit: BoxFit.fill,
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                                label: Text(
                                  topic.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: topic.isSeleted
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    topic.isSeleted = !topic.isSeleted;
                                  });
                                }),
                          );
                        }).toList(),
                      ),
                    ),
                    isExpanded: _isExpanded,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.validate();
                        },
                        child: Text(
                          'Gửi đóng góp',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPronunciationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Add your pronunciation input UI here
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Nhập phiên âm',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.teal),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'DoulosSIL',
                ),
                readOnly: true,
                showCursor: true,
                controller: _pronunciationController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập phiên âm';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: IPAKeyboard(
                  onTap: _handleButtonPress,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add logic when user submits pronunciation
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Xác nhận',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildExampleList() {
    return Column(
      children: _examples.asMap().entries.map((example) {
        final index = example.key;
        return _buildExampleRow(index);
      }).toList(),
    );
  }

  Widget _buildExampleRow(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            // controller: TextEditingController(text: wordDefinition.meaning),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              // hintText: 'Cau vi du',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            onChanged: (value) {
              setState(() {
                _examples[index] = value;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Vui long dien vao o trong';
              }
              return null;
            },
          )),
          IconButton(
              onPressed: () {
                _removeExample(index);
              },
              color: Colors.red,
              icon: const Icon(
                Icons.remove,
                color: Colors.red,
              )),
        ],
      ),
    );
  }

  Widget _buildWordDefinitionList() {
    return Column(
      children: _wordDefinitions.asMap().entries.map((entry) {
        final index = entry.key;
        final wordDefinition = entry.value;
        return _buildWordDefinitionRow(index, wordDefinition);
      }).toList(),
    );
  }

  Widget _buildWordDefinitionRow(int index, WordDefinition wordDefinition) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          DropdownButton<String>(
            value: wordDefinition.wordType,
            items: ['Noun', 'Verb', 'Adjective', 'Adverb']
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _wordDefinitions[index].wordType = value;
              });
            },
            hint: const Text('Loại từ'),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: TextFormField(
            // controller: TextEditingController(text: wordDefinition.meaning),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              // hintText: 'Nhập nghĩa của từ',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            onChanged: (value) {
              setState(() {
                _wordDefinitions[index].meaning = value;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Vui long nhap nghia';
              }
              return null;
            },
          )),
          IconButton(
              onPressed: () {
                _removeWordDefinition(index);
              },
              color: Colors.red,
              icon: const Icon(
                Icons.remove,
                color: Colors.red,
              ))
        ],
      ),
    );
  }

  void _removeWordDefinition(int index) {
    setState(() {
      _wordDefinitions.removeAt(index);
    });
  }

  void _addWordDefinition() {
    setState(() {
      _wordDefinitions.add(WordDefinition());
    });
  }

  void _addExample() {
    setState(() {
      _examples.add('');
    });
  }

  void _removeExample(int index) {
    setState(() {
      _examples.removeAt(index);
    });
  }
}

class Topic {
  int id;
  String image;
  String name;
  bool isSeleted;
  Topic(
      {required this.id,
      required this.image,
      required this.name,
      required this.isSeleted});
}
