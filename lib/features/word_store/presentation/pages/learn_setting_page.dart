import 'package:flutter/material.dart';

class LearnSettingPage extends StatefulWidget {
  const LearnSettingPage({Key? key}) : super(key: key);

  @override
  State<LearnSettingPage> createState() => _LearnSettingPageState();
}

class _LearnSettingPageState extends State<LearnSettingPage> {
  bool random = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Cài đặt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.grey.shade50,
          // title: Text(
          //   args.titleAppBar,
          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          // ),
          // centerTitle: true,
          elevation: 2,
          shadowColor: Colors.grey.shade100,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // width: double.infinity,
            // height: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TỪ MỚI',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                Text(
                  'Cài đặt cách học cho các từ mới, chưa lên cấp độ 1',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildListSettings(context),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'TỪ ÔN LẠI',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                Text(
                  'Cài đặt cách học cho các từ được nhắc ôn lại, các từ có cấp độ 1 trở lên',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildListSettings(context),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'CHUNG',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildListGeneralSettings(context),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  Column _buildListGeneralSettings(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 30,
          // width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số từ tối đa một lần học',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              Switch(
                // This bool value toggles the switch.
                value: random,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    random = value;
                  });
                },
              )
            ],
          ),
        ),
        Container(
          // height: 30,
          // width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tự động phát âm',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              Switch(
                // This bool value toggles the switch.
                value: random,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    random = value;
                  });
                },
              )
            ],
          ),
        ),
        Container(
          // height: 30,
          // width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hiện thị hình ảnh',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              Switch(
                // This bool value toggles the switch.
                value: random,
                activeColor: Colors.blue,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    random = value;
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Column _buildListSettings(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4)))),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black87),
          ),
          onPressed: () => _showDialogChooseNumber(
              context, 'Số từ tối đa', [5, 10, 15, 20, 30]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số từ tối đa một lần học',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              const Text('5', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black87),
          ),
          onPressed: () => _showDialogChooseNumber(context,
              'Số câu hỏi dạng Viết khi học', [0, 1, 2, 3, 4, 5, 6, 7]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Viết',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              const Text('1', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black87),
          ),
          onPressed: () => _showDialogChooseNumber(context,
              'Số câu hỏi dạng Nghe khi học', [0, 1, 2, 3, 4, 5, 6, 7]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nghe',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              const Text('1', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black87),
          ),
          onPressed: () => _showDialogChooseNumber(context,
              'Số câu hỏi dạng Chọn từ khi học', [0, 1, 2, 3, 4, 5, 6, 7]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chọn từ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              const Text('1', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ElevatedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4)))),
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black87),
          ),
          onPressed: () => _showDialogChooseNumber(context,
              'Số câu hỏi dạng Chọn nghĩa khi học', [0, 1, 2, 3, 4, 5, 6, 7]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chọn nghĩa',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
              ),
              const Text('1', style: TextStyle(color: Colors.blue)),
            ],
          ),
        )
      ],
    );
  }

  Future<String?> _showDialogChooseNumber(
      BuildContext context, String title, List<int> values) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 15),
              ...values.map((e) => SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      // style: ButtonStyle(),
                      onPressed: () {},
                      child: Text(
                        '$e',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
