import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/contribution_params.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/presentation/providers/type_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SentenceForm extends StatefulWidget {
  final SentenceEntity? initData;
  final String titleBtnSubmit;
  final bool isLoading;
  final void Function(dynamic) callback;
  const SentenceForm(
      {super.key,
      this.initData,
      required this.titleBtnSubmit,
      required this.isLoading,
      required this.callback});

  @override
  State<SentenceForm> createState() => _SentenceFormState();
}

class _SentenceFormState extends State<SentenceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedType;
  bool _isExpanded = false;
  String? _topicError = '';
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    Provider.of<TypeProvider>(context, listen: false)
        .eitherFailureOrGetTypes(false);
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, false, null);

    if (widget.initData != null) {
      _contentController.text = widget.initData!.content;
      _meaningController.text = widget.initData!.meaning;
      _selectedType = widget.initData!.typeId;
      _noteController.text = widget.initData!.note ?? '';
    }
    super.initState();
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
                        'Nhập câu bằng tiếng Anh',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _contentController,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
                        'Nhập nghĩa của câu',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: _meaningController,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
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
                        'Ghi chú',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        maxLines: 4,
                        controller: _noteController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Loại câu',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      _buildTypesOfSen(),
                      const SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: widget.isLoading
                                  ? null
                                  : () async {
                                      setState(() {
                                        _topicError = null;
                                      });

                                      // print(_contentController.text);
                                      // print(_pronunciationController.text);
                                      // print(_wordDefinitions);
                                      // print(_selectedLevel);
                                      // print(_selectedSpecializaiton);
                                      // print(_examples);
                                      // print(_synonymController.text);
                                      // print(_antonymController.text);
                                      // print(_noteController.text);
                                      // print(_selectedImages);
                                      // print(
                                      //     Provider.of<TopicProvider>(context, listen: false)
                                      //         .getSelectedTopics());

                                      List<dynamic> selectedTopics =
                                          Provider.of<TopicProvider>(context,
                                                  listen: false)
                                              .getSelectedTopics();

                                      Content content = Content(
                                        topicId: selectedTopics,
                                        typeId: _selectedType,
                                        content: _contentController.text,
                                        meaning: _meaningController.text,
                                        note: _noteController.text.isNotEmpty
                                            ? _noteController.text.trim()
                                            : null,
                                      );

                                      if (_formKey.currentState!.validate() &&
                                          _validateForm()) {
                                        widget.callback({typeConSen, content});
                                      }
                                    },
                              child: widget.isLoading
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      widget.titleBtnSubmit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.white),
                                    )),
                        ],
                      ),
                    ]))));
  }

  Consumer<TypeProvider> _buildTypesOfSen() {
    return Consumer<TypeProvider>(builder: (context, provider, child) {
      return DropdownButtonFormField<int>(
        alignment: Alignment.centerLeft,
        focusColor: Colors.white,
        style: Theme.of(context).textTheme.bodyMedium!,
        value: _selectedType =
            provider.listTypes.isNotEmpty ? provider.listTypes[0].id : null,
        validator: (int? value) {
          if (value == null) {
            return "Vui lòng chọn loại câu";
          }
          return null;
        },
        items: provider.listTypes
            .map<DropdownMenuItem<int>>(
                (TypeEntity type) => DropdownMenuItem<int>(
                      value: type.id,
                      child: Text(type.name),
                    ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedType = value;
          });
        },
        hint: const Text('Loại từ'),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            )),
      );
    });
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
              // color: Colors.grey.shade100
            ),
            margin: const EdgeInsets.only(bottom: 10),
            // padding: const EdgeInsets.all(8),
            child: Consumer<TopicProvider>(builder: (context, provider, child) {
              List<TopicEntity> listTopics = provider.listTopicEntity;

              if (widget.initData != null) {
                List<int> selectedId =
                    widget.initData!.topics!.map((e) => e.id).toList();
                for (var element in listTopics) {
                  if (selectedId.contains(element.id)) {
                    element.isSelected = true;
                  }
                }
              }

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
                  runSpacing: 8.0,
                  children: listTopics.map((topic) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ActionChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Set the border radius here
                          ),
                          side: BorderSide(
                              color: topic.isSelected
                                  ? Colors.green.shade500
                                  : Colors.grey.shade100,
                              width: 2),
                          // backgroundColor: topic.isSelected
                          //     ? Colors.green.shade500
                          //     : Colors.white,
                          label: Text(
                            topic.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              topic.isSelected = !topic.isSelected;
                            });
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

  bool _validateForm() {
    bool isValid = true;

    if (Provider.of<TopicProvider>(context, listen: false)
        .getSelectedTopics()
        .isEmpty) {
      setState(() {
        _topicError = 'Vui lòng chọn ít nhất 1 chủ đề';
      });
      isValid = false;
    }
    return isValid;
  }
}
