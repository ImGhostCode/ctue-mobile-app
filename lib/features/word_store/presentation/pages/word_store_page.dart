import 'package:ctue_app/features/word_store/presentation/pages/spaced_repetition_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WordStorePage extends StatefulWidget {
  const WordStorePage({Key? key}) : super(key: key);

  @override
  State<WordStorePage> createState() => _WordStorePageState();
}

class _WordStorePageState extends State<WordStorePage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  final List<VocabularySet> _vocabularySets = [
    VocabularySet(
        title: 'Default',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBO6Wl5_gZWvGZN_-cJJzEVLhJo9Y0uauwnw&usqp=CAU'),
    VocabularySet(
        title: 'Figures of speech',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBO6Wl5_gZWvGZN_-cJJzEVLhJo9Y0uauwnw&usqp=CAU')
  ];

  @override
  void initState() {
    data = [
      _ChartData('1', 1, Colors.orange),
      _ChartData('2', 2, Colors.yellow.shade700),
      _ChartData('3', 3, Colors.green.shade400),
      _ChartData('4', 4, Colors.green.shade800),
      _ChartData('5', 5, Colors.blue.shade500),
      _ChartData('Nhớ sâu', 6, Colors.blue.shade900)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Image.asset(
              'assets/images/ctue-high-resolution-logo-transparent2.png',
              fit: BoxFit.fill,
              width: 150),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 28,
                ))
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.blue.shade600,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SpacedRepetitionDetail()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Text(
                            'Học ít - Nhớ sâu từ vựng với phương phát khoa học',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                        const Text('Spaced Repetition ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                color: Colors.white)),
                        const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 390,
                ),
                _buildChart(context)
              ],
            ),
          ),
          _buildReminder(context),
          _buildVocabularySetManagement(context),
          const SizedBox(
            height: 10,
          ),
        ])),
      ],
    ));
  }

  Positioned _buildChart(BuildContext context) {
    return Positioned(
      top: 60, // Center vertically
      left: 16,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 320,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Đã học',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            RichText(
              text: TextSpan(
                text: '3',
                style: Theme.of(context).textTheme.titleLarge,
                children: <TextSpan>[
                  TextSpan(
                    text: '/',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: ' 2',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Text(
              'Cấp độ nhớ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(
                    isVisible: false,
                  ),
                  enableAxisAnimation: true,

                  // tooltipBehavior: _tooltip,
                  series: <CartesianSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        pointColorMapper: (_ChartData data, _) => data.color,
                        name: 'Gold',
                        color: Color.fromRGBO(8, 142, 255, 1),
                        dataLabelMapper: (_ChartData data, _) =>
                            '${data.y!.toInt()} từ',
                        width: 0.5,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,

                          // Positioning the data label
                          // useSeriesColor: true,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)))
                  ]),
            )
          ]),
        ),
      ),
    );
  }

  Container _buildReminder(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: Container(
          margin: EdgeInsets.all(16),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue.shade50,
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)]),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đã đến lúc ôn tập',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '3 từ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.red),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Ôn tập ngay'))
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/note.png',
                        fit: BoxFit.fill,
                      )))
            ],
          ),
        ));
  }

  Container _buildVocabularySetManagement(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bộ từ của bạn',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none)),
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {},
                  child: Row(children: [
                    const Icon(
                      Icons.create_new_folder_rounded,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Tạo bộ từ mới',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    )
                  ]),
                ),
              )),
              Expanded(
                  child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none)),
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {},
                  child: Row(children: [
                    const Icon(
                      Icons.library_books,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Tải bộ từ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    )
                  ]),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildListVocabularySets()
        ],
      ),
    );
  }

  SizedBox _buildListVocabularySets() {
    return SizedBox(
      height: 500,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 3,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _vocabularySets.length,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.white, // Set the background color here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.white,
                leading: _vocabularySets[index].title == 'Default'
                    ? Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          // color: const Color(0xff7c94b6),
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.folder,
                          color: Colors.blue,
                          size: 30,
                        ),
                      )
                    : Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          // color: const Color(0xff7c94b6),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                title: Text(_vocabularySets[index].title),
                trailing: _vocabularySets[index].title != 'Default'
                    ? const Icon(Icons.more_vert)
                    : null,
              ));
        },
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}

class VocabularySet {
  final String? image;
  final String title;

  VocabularySet({this.image, required this.title});
}
