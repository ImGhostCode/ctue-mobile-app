import 'dart:io';

import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/manage/presentation/pages/voca_set_management.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:ctue_app/features/specialization/presentation/providers/spec_provider.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:provider/provider.dart';

class CreateVocabularySet extends StatefulWidget {
  const CreateVocabularySet({super.key});

  @override
  State<CreateVocabularySet> createState() => _CreateVocabularySetState();
}

class _CreateVocabularySetState extends State<CreateVocabularySet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  MultipleSearchController controller = MultipleSearchController();
  int numOfLines = 0;
  List<WordEntity> selectedWords = [];
  int? _selectedSpecializaiton;
  String? _specError = '';
  String? _topicError = '';
  String? _imageError = '';
  XFile? _selectedImage;
  int? selectedTopic;

  bool _isExpanded = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
        // print(_selectedImages);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  void initState() {
    Provider.of<SpecializationProvider>(context, listen: false)
        .eitherFailureOrGetSpecializations();
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CreateVocaSetArgument;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tạo bộ từ mới',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
        ),
        actions: [
          if (_titleController.text.isNotEmpty && selectedWords.isNotEmpty)
            TextButton(
              onPressed: () async {
                setState(() {
                  _specError = null;
                  _topicError = null;
                  _imageError = null;
                });

                // List<dynamic> selectedTopics =
                //     Provider.of<TopicProvider>(context, listen: false)
                //         .getSelectedTopics();

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate() && _validateForm()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                  List<int> wordIds = selectedWords.map((e) => e.id).toList();

                  if (args.isAdmin) {
                    await Provider.of<VocaSetProvider>(context, listen: false)
                        .eitherFailureOrCreVocaSet(
                            _titleController.text,
                            selectedTopic,
                            _selectedSpecializaiton,
                            _selectedImage,
                            wordIds);
                  } else {
                    await Provider.of<VocaSetProvider>(context, listen: false)
                        .eitherFailureOrCreVocaSet(
                            _titleController.text, null, null, null, wordIds);
                  }

                  // ignore: use_build_context_synchronously
                  if (Provider.of<VocaSetProvider>(context, listen: false)
                          .statusCode ==
                      201) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          // ignore: use_build_context_synchronously
                          Provider.of<VocaSetProvider>(context, listen: false)
                              .message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            Colors.green, // You can customize the color
                      ),
                    );
                    // ignore: use_build_context_synchronously
                  } else if (Provider.of<VocaSetProvider>(context,
                              listen: false)
                          .failure !=
                      null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          // ignore: use_build_context_synchronously
                          Provider.of<VocaSetProvider>(context, listen: false)
                              .message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            Colors.red, // You can customize the color
                      ),
                    );
                  }
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Provider.of<VocaSetProvider>(context, listen: true)
                      .isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : const Text(
                      'LƯU',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tên bô từ',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      hintText: 'Nhập tên bộ từ',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 2))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                args.isAdmin
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chuyên ngành',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          _buildSpecializaitons(context),
                          _specError != null
                              ? Text(
                                  _specError!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Text(
                  'Danh sách từ',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                selectedWords.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(8),
                        child: Wrap(children: [
                          ...List.generate(selectedWords.length, (index) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(right: 5, bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.lightBlueAccent.shade100
                                    .withOpacity(0.6),
                                border:
                                    Border.all(color: Colors.lightBlueAccent),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedWords[index].content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.blue.shade800),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.blue.shade800,
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          selectedWords.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                        ]),
                      )
                    : const SizedBox.shrink(),
                TextField(
                  controller: _searchController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Nhập từ để tìm kiếm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onChanged: (value) async {
                    await Provider.of<WordProvider>(context, listen: false)
                        .eitherFailureOrLookUpDic(value);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<WordProvider>(builder: (context, provider, child) {
                  Iterable<WordEntity> filterdResults = provider.lookUpResults
                      .where((word) =>
                          !selectedWords.map((e) => e.id).contains(word.id));

                  if (filterdResults.isEmpty ||
                      _searchController.text.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    // height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(6)),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // horizontalTitleGap: 0,
                            titleAlignment: ListTileTitleAlignment.center,
                            // minVerticalPadding: 0,
                            // contentPadding: const EdgeInsets.symmetric(
                            //     horizontal: 8, vertical: 0),
                            title: Text(
                              filterdResults.elementAt(index).content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              setState(() {
                                selectedWords
                                    .add(filterdResults.elementAt(index));
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: filterdResults.length),
                  );
                }),
                const SizedBox(
                  height: 8,
                ),
                args.isAdmin
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopics(context),
                          const SizedBox(
                            height: 8,
                          ),
                          _topicError != null
                              ? Text(
                                  _topicError!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                args.isAdmin
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thêm ảnh minh họa',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_selectedImage != null)
                            Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                              ),
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(_selectedImage!.path),
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
                                        onPressed: () => _removeImage(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 150,
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
                            height: 10,
                          ),
                          _imageError != null
                              ? Text(
                                  _imageError!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red),
                                )
                              : const SizedBox.shrink(),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    bool isValid = true;
    if (_selectedSpecializaiton == null) {
      setState(() {
        _specError = 'Vui lòng chọn chuyên ngành của từ';
      });
      isValid = false;
    }

    if (_selectedImage == null) {
      setState(() {
        _imageError = 'Vui lòng thêm hình ảnh minh họa';
      });
      isValid = false;
    }

    if (Provider.of<TopicProvider>(context, listen: false)
        .getSelectedTopics()
        .isEmpty) {
      setState(() {
        _topicError = 'Vui lòng chọn chủ đề';
      });
      isValid = false;
    }
    return isValid;
  }

  Container _buildSpecializaitons(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
          Consumer<SpecializationProvider>(builder: (context, provider, child) {
        return DropdownButtonFormField<int>(
          style: Theme.of(context).textTheme.bodyMedium,
          value: _selectedSpecializaiton =
              provider.listSpecializations.isNotEmpty
                  ? provider.listSpecializations[0].id
                  : null,
          validator: (int? value) {
            if (value == null) {
              return "Vui lòng chọn chuyên ngành";
            }
            return null;
          },
          items: provider.listSpecializations
              .map<DropdownMenuItem<int>>(
                  (SpecializationEntity specialization) => DropdownMenuItem(
                        value: specialization.id,
                        child: Text(specialization.name),
                      ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedSpecializaiton = value;
            });
          },
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              )),
        );
      }),
    );
  }

  ExpansionPanelList _buildTopics(BuildContext context) {
    return ExpansionPanelList(
      elevation: 2,
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
                'Thêm chủ đề',
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
            child: Consumer<TopicProvider>(builder: (context, provider, child) {
              List<TopicEntity> listTopics = provider.listTopicEntity;

              bool isLoading = provider.isLoading;

              // Access the failure from the provider
              Failure? failure = provider.failure;

              if (failure != null) {
                return Text(failure.errorMessage);
              } else if (isLoading) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // or show an empty state message
              } else if (listTopics.isEmpty) {
                // Handle the case where topics are empty
                return const Center(child: Text('Không có dữ liệu'));
              } else {
                return Wrap(
                  spacing: 8.0, // Khoảng cách giữa các Chip
                  children: listTopics.map((topic) {
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
                                  .withOpacity(0.7),
                              width: 2),
                          backgroundColor: topic.isSelected
                              ? Colors.green.shade500
                              : Colors.grey.shade100,
                          avatar: ClipOval(
                            child: topic.image.isNotEmpty
                                ? Image.network(
                                    topic.image,
                                    fit: BoxFit.fill,
                                    width: 60.0,
                                    height: 60.0,
                                  )
                                : Container(),
                          ),
                          label: Text(
                            topic.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: topic.isSelected
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          onPressed: () {
                            for (var element in listTopics) {
                              if (element.id != topic.id) {
                                element.isSelected = false;
                              } else {
                                topic.isSelected = !topic.isSelected;
                                if (topic.isSelected) {
                                  selectedTopic = topic.id;
                                } else {
                                  selectedTopic = null;
                                }
                              }
                            }
                            setState(() {});
                          }),
                    );
                  }).toList(),
                );
              }
            }),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
