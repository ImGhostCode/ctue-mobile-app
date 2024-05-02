import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:flutter/material.dart';

class VocabularyPackItem extends StatelessWidget {
  final VocaSetEntity item;
  const VocabularyPackItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/vocabulary-set-detail',
            arguments: VocabularySetArguments(id: item.id));
      },
      child: Container(
        // height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.picture ?? '',
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/broken-image.png',
                    color: Colors.grey.shade300,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              // flex: 2,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black87),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.list_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      '${item.words.length}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 11),
                    )
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.download_rounded,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      '${item.downloads}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 11),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
