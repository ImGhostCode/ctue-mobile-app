import 'package:ctue_app/features/profile/presentation/widgets/gradient_border_container.dart';
import 'package:flutter/material.dart';

class SpacedRepetitionDetail extends StatelessWidget {
  const SpacedRepetitionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 250,
                    child: Image.asset(
                      'assets/images/spaced-repetition.png',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Text(
                  'Spaced Repetition là gì?',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Phương phát lặp lại ngắt quãng được đặt nền tảng bởi Hermann Ebbinghaus, người đã đưa ra giả thyết rằng viêc mất thông tin theo thời gian tuân theo một đường cong lãng quên, nhưng viêc quên đó có thể được điều chỉnh bằng sự lặp lại dựa trên khả năng ghi nhớ môt cách chủ động.',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(
                    'Lặp lại ngắt quãng là một phương pháp mà đối tượng được yêu cầu ghi nhớ một sự việc nhất định với khoảng thời gian tăng dần mỗi khi sự việc đó được trình bài hoặc nói ra. Nếu đối tượng có thể nhớ lại thông tin một cách chính xác, thời gian sẽ được nhân đôi giúp họ giữ thông tin luôn mới trong tâm trí để nhớ lại trong tương lai.(*)',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Các cấp độ nhớ',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'Chúng tôi chia cấp độ nhớ thành 6 cấp độ, từ cấp 1 cho đến Nhớ sâu. Để nâng được cấp độ nhớ, bạn cần phải học lại và nhớ từ sau mỗi khoảng thời gian như bảng dưới đây. Đừng lo, Chúng tôi sẽ nhắc bạn thời điểm cần hoc lại.',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 5,
                ),
                _buildTable(context),
                const SizedBox(
                  height: 20,
                ),
                Text('(*) https://en.wikipedia.org/wiki/Spaced_repetition',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(
                  height: 50,
                ),
              ]),
        ),
      ),
    );
  }

  Table _buildTable(BuildContext context) {
    return Table(
      // border: TableBorder(borderRadius: BorderRadius.circular(15)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.blue.shade50,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Cấp độ nhớ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Thời gian ôn tập',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12)),
            color: Colors.grey.shade50,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.orange,
                            borderColor2: Colors.grey.shade300,
                            stop1: 0.167,
                            stop2: 0.168,
                            percent: 1,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cấp độ 1',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 2 giờ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12)),
            color: Colors.grey.shade200,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.yellow.shade700,
                            borderColor2: Colors.grey.shade300,
                            stop1: 0.34,
                            stop2: 0.35,
                            percent: 2,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cấp độ 2',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 1 ngày',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12)),
            color: Colors.grey.shade50,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.green.shade400,
                            borderColor2: Colors.grey.shade300,
                            stop1: 0.51,
                            stop2: 0.52,
                            percent: 3,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cấp độ 3',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 2 ngày',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12)),
            color: Colors.grey.shade200,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.green.shade700,
                            borderColor2: Colors.grey.shade300,
                            stop1: 0.667,
                            stop2: 0.668,
                            percent: 4,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cấp độ 4',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 3 ngày',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12)),
            color: Colors.grey.shade50,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.blue,
                            borderColor2: Colors.grey.shade300,
                            stop1: 0.835,
                            stop2: 0.836,
                            percent: 5,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cấp độ 5',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 5 ngày',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: Colors.grey.shade200,
          ),
          children: <Widget>[
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientBorderContainer(
                            diameter: 20,
                            borderWidth: 0.12,
                            borderColor1: Colors.blue.shade900,
                            borderColor2: Colors.grey.shade300,
                            stop1: 1,
                            stop2: 1,
                            percent: 6,
                            fontSize: 12),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Nhớ sâu',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ))),
            TableCell(
                child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      'Sau 8 ngày',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    ))),
          ],
        ),
      ],
    );
  }
}
