import 'package:flutter/material.dart';

class SenConForm extends StatefulWidget {
  const SenConForm({super.key});

  @override
  State<SenConForm> createState() => _SenConFormState();
}

class _SenConFormState extends State<SenConForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedType;
  bool _isExpanded = false;

  List<Topic> _topics = [
    Topic(id: 1, name: 'Giao tiếp thông dụng', isSeleted: false),
    Topic(id: 1, name: 'Chào hỏi', isSeleted: false),
    Topic(id: 1, name: 'Du lịch - phương hướng', isSeleted: false),
    Topic(id: 1, name: 'Con số - tiền bạc', isSeleted: false),
    Topic(id: 1, name: "Địa điểm", isSeleted: false),
    Topic(id: 1, name: 'Thời gian, ngày tháng', isSeleted: false),
    Topic(id: 1, name: 'Điện thoại - Internet - Thư', isSeleted: false),
    Topic(id: 1, name: 'Chỗ ăn ở', isSeleted: false),
    Topic(id: 1, name: 'Mua sắm', isSeleted: false)
  ];

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
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
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
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
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
                        // controller: _noteController,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
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
                      Container(
                        color: Colors.white,
                        child: DropdownButtonFormField<String>(
                          value: _selectedType,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Vui lòng chọn loại câu";
                            }
                            return null;
                          },
                          items: ['Cau hoi', 'Cau cam than', 'Cau cau khien']
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10),
                              )),
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
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
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
                              child: Wrap(
                                spacing: 8.0, // Khoảng cách giữa các Chip
                                children: _topics.asMap().entries.map((entry) {
                                  final topic = entry.value;
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
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
                        height: 5,
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
                    ]))));
  }
}

class Topic {
  int id;
  String name;
  bool isSeleted;
  Topic({required this.id, required this.name, required this.isSeleted});
}
