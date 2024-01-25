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
  final List<WordDefinition> _wordDefinitions = [];
  List<String> _examples = [];
  final TextEditingController _meaningController = TextEditingController();
  final TextEditingController _synonymController = TextEditingController();
  final TextEditingController _antonymController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  List<File> _selectedImages = [];

  String? _selectedLevel;
  String? _selectedSpecializaiton;

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
                  icon: Icon(Icons.add),
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
                  icon: Icon(Icons.add),
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
