final List<Phoneme> vowels = [
  Phoneme(
      label: 'ɪ',
      tips: [
        'Đây là âm i ngắn, phát âm giống "i" của tiếng Việt nhưng ngắn hơn, bật nhanh.',
        'Môi hơi mở sang hai bên, lưỡi hạ thấp'
      ],
      type: Type.short,
      examples: ['ship ʃɪp', 'his hɪz', 'kid kɪd'],
      source: 'uk_phonetics_sound_ship_2023feb.mp3'),
  Phoneme(
      label: 'iː',
      tips: [
        'Là âm i dài, bạn đọc kéo dài âm "i", âm phát từ trong khoang miệng chứ không thổi hơi ra.',
        'Môi mở rộng hai bên như đang mỉm cười, lưỡi nâng cao lên'
      ],
      type: Type.long,
      examples: ['sheep ʃiːp', 'sea siː', 'green ɡriːn'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'e',
      tips: [
        'Tương tự như âm e tiếng Việt nhưng cách phát âm cũng ngắn hơn.',
        'Môi mở rộng sang ahia bên rộng hơn so với âm /ɪ/, lưỡi hạ thấp hơn /ɪ/'
      ],
      type: Type.short,
      examples: ['bed bed', 'head hed'],
      source: 'uk_phonetics_sound_head_2023feb.mp3'),
  Phoneme(
      label: 'ə',
      tips: [
        'Âm ơ ngắn, phát âm như ơ tiếng Việt nhưng ngắn và nhẹ hơn.',
        'Môi hơi mở rộng, lưỡi thả lỏng.'
      ],
      type: Type.short,
      examples: ['teacher ˈtiː.tʃə', 'banana bəˈnɑː.nə', 'kid ˈdɑːk.tə'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ɜː',
      tips: [
        'Âm ơ dài. Âm này đọc là âm ơ nhưng cong lưỡi.',
        'Bạn phát âm /ə/ rồi cong lưỡi lên, phát âm từ trong khoang miệng.',
        'Môi hơi mở rộng, lưỡi cong lên, lưỡi chạm vào vòm miệng khi kết thúc âm.'
      ],
      type: Type.long,
      examples: ['bird bɜːd', 'burn bɜːn', 'birthday ˈbɜːθ.deɪ'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ʊ',
      tips: [
        'Âm u ngắn, khá giống âm ư của tiếng Việt. Khi phát âm, không dùng môi mà đầy hơi rất ngắn từ cổ họng',
        'Môi hơi tròn, lưỡi hạ thấp'
      ],
      type: Type.short,
      examples: ['good ɡʊd', 'put pʊt'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'uː',
      tips: [
        'Âm u dài, phát âm ra từ khoang miệng nhưng không thổi hơi ra, kéo dài âm u ngắn.',
        'Môi tròn, lưỡi nâng cao lên'
      ],
      type: Type.long,
      examples: ['shoot ʃuːt', 'goose ɡuːs', 'school skuːl'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ɒ',
      tips: [
        'Âm o ngắn, tương tự âm o tiếng Việt nhưng phát âm ngắn hơn',
        'Môi hơi tròn, lưỡi hạ thấp'
      ],
      type: Type.short,
      examples: ['on ɒn', 'hot hɒt', 'box bɒks'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ɔː',
      tips: [
        'Phát âm như âm tiếng Việt nhưng rồi cong lưỡi lên, không phát âm từ khoang miệng',
        'Tròn môi, lưỡi cong lên chạm vào vòm miệng khi kết thúc âm.'
      ],
      type: Type.long,
      examples: ['door dɔːr', 'ball bɑːl', 'law lɑː'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ʌ',
      tips: [
        'Âm lai giữa âm ă và âm ơ của tiếng Việt, na ná âm ă hơn. Phát âm phải bật hơi ra.',
        'Miệng thu hẹp lại, lưỡi hơi nâng lên cao'
      ],
      type: Type.short,
      examples: ['up ʌp', 'come kʌm', 'love lʌv'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ɑː',
      tips: [
        'Âm a đọc kéo dài, âm phát ra từ khoang miệng.',
        'Môi mở rộng, lưỡi hạ thấp'
      ],
      type: Type.long,
      examples: ['far fɑːr', 'start stɑːt', 'father \'fɑːðə(r)'],
      source: 'us_phonetics_sound_father_2023feb.mp3'),
  Phoneme(
      label: 'æ',
      tips: [
        'Âm a bẹt, hơi giống âm a và e, âm có cảm giác bị nén xuống.',
        'Miệng mở rộng, môi dưới hạ thấp xuống. Lưỡi hạ rất thấp'
      ],
      type: Type.short,
      examples: ['cat kæt', 'trap træp', 'bad bæd'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
];

final List<Phoneme> diphthongs = [
  Phoneme(
      label: 'ɪə',
      tips: [
        'Nguyên âm đôi. Phát âm chuyển từ âm / v / rồi dần sang âm /ə/.',
        'Môi mở rộng dần nhưng không rộng quá. Lưỡi đẩy dần ra về phía trước'
      ],
      type: Type.diphthongs,
      examples: ['near nɪə(r)', 'here hɪə(r)'],
      source: 'uk_phonetics_sound_ear_2023feb.mp3'),
  Phoneme(
      label: 'eə',
      tips: [
        'Phát âm bằng cách đọc âm / e / rồi chuyển dần sang âm /ə/.',
        'Môi hơi thu hẹp. Lưỡi thụt dần về phía sau Âm dài hơi'
      ],
      type: Type.diphthongs,
      examples: ['hair heər'],
      source: 'uk_phonetics_sound_hair_2023feb.mp3'),
  Phoneme(
      label: 'eɪ',
      tips: [
        'Phát âm bằng cách đọc âm / e / rồi chuyển dần sang âm /1/.',
        'Môi dẹt dần sang hai bên. Lưỡi hướng dần lên trên'
      ],
      type: Type.diphthongs,
      examples: ['wait weɪt', 'face feɪs', 'day deɪ'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ɔɪ',
      tips: [
        'Phát âm bằng cách đọc âm / e / rồi chuyển dần sang âm /ə/.',
        'Môi hơi thu hẹp. Lưỡi thụt dần về phía sau Âm dài hơi'
      ],
      type: Type.diphthongs,
      examples: ['boy bɔɪ', 'choice tʃɔɪs'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'aɪ',
      tips: [
        'Phát âm bằng cách đọc âm / a: / rồi chuyển dần sang âm /ɪ/.',
        'Môi dẹt dần sang hai bên. Lưỡi nâng lên và hơi đẩy dần về trước',
        'Âm dài hơi'
      ],
      type: Type.diphthongs,
      examples: ['my maɪ', 'nice naɪs', 'try traɪ'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'əʊ',
      tips: [
        'Phát âm bằng cách đọc âm / ǝ/ rồi chuyển dần sang âm / ʊ /. Môi từ hơi mở đến hơi tròn. Lưỡi lùi dần về phía sau',
      ],
      type: Type.diphthongs,
      examples: [
        'show ʃəʊ',
        'goat ɡəʊt',
      ],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'aʊ',
      tips: [
        'Phát âm bằng cách đọc âm / a: / rồi chuyển dần sang âm /ʊ/.',
        'Môi tròn dần. Lưỡi hơi thụt về phía sau',
        'Âm dài hơi'
      ],
      type: Type.diphthongs,
      examples: ['mouth maʊθ', 'cow kaʊ'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
  Phoneme(
      label: 'ʊə',
      tips: [
        'Đọc như uo, chuyển từ âm sau /ʊ/ sang âm giữa /ǝ/. Khi bắt đầu, môi mở khá tròn, hơi bè, hướng ra ngoài, mặt lưỡi đưa vào phía trong khoang miệng và hướng lên gần ngạc trên Ngay sau đó, miệng hơi mở ra, đưa lưỡi lùi về giữa khoang miệng.'
      ],
      type: Type.diphthongs,
      examples: ['tourist ˈtʊə.rɪst', 'tour tʊər'],
      source: 'uk_phonetics_sound_sheep_2023feb.mp3'),
];

final List<Phoneme> consonants = [
  Phoneme(
      label: 'p',
      tips: [
        'Đọc gần giống âm P của tiếng Việt, hai môi chặn luồng không khí trong miệng sau đó bật ra. Cảm giác dây thanh quản rung nhẹ',
      ],
      type: Type.unvoiced,
      examples: ['pen pen', 'copy \'kɒp.i'],
      source: 'uk_phonetics_sound_pen_2023feb.mp3'),
  Phoneme(
      label: 'b',
      tips: [
        'Đọc tương tự âm B trong tiếng Việt. Để hai môi chặng không khí từ trong miệng sau đó bật ra. Thanh quản rung nhẹ.',
      ],
      type: Type.voiced,
      examples: ['back bæk', 'job dʒɒb'],
      source: 'us_phonetics_sound_book_2023feb.mp3'),
  Phoneme(
    label: 't',
    tips: [
      'Đọc gần giống âm T của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['top tɒp', 'cat kæt'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'd',
    tips: [
      'Đọc gần giống âm D của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['dog dɒɡ', 'bed bed'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'tʃ',
    tips: [
      'Đọc gần giống âm CH của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['chat tʃæt', 'church tʃɜːtʃ'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'dʒ',
    tips: [
      'Đọc gần giống âm GI của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['job dʒɒb', 'judge dʒʌdʒ'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'k',
    tips: [
      'Đọc gần giống âm C của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['cat kæt', 'back bæk'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'g',
    tips: [
      'Đọc gần giống âm G của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['go ɡəʊ', 'good ɡʊd'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'f',
    tips: [
      'Đọc gần giống âm PH của tiếng Việt, đưa môi chặn không khí trong miệng sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['fat fæt', 'off ɒf'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'v',
    tips: [
      'Đọc gần giống âm V của tiếng Việt, đưa môi chặn không khí trong miệng sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['very ˈver.i', 'love lʌv'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'θ',
    tips: [
      'Đọc gần giống âm TH của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['think θɪŋk', 'both bəʊθ'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'ð',
    tips: [
      'Đọc gần giống âm TH của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['this ðɪs', 'mother ˈmʌðə(r)'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 's',
    tips: [
      'Đọc gần giống âm S của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['sit sɪt', 'face feɪs'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'z',
    tips: [
      'Đọc gần giống âm S của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['zoo zuː', 'rose rəʊz'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'ʃ',
    tips: [
      'Đọc gần giống âm X của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['she ʃiː', 'fish fɪʃ'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'ʒ',
    tips: [
      'Đọc gần giống âm GI của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Thanh quản rung nhẹ',
    ],
    type: Type.voiced,
    examples: ['measure ˈmeʒə(r)', 'vision ˈvɪʒn'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'h',
    tips: [
      'Đọc gần giống âm H của tiếng Việt, không chặn luồng không khí trong miệng, thở ra khí qua mũi',
    ],
    type: Type.unvoiced,
    examples: ['hat hæt', 'behind bɪˈhaɪnd'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'm',
    tips: [
      'Đọc gần giống âm M của tiếng Việt, đưa môi chặn không khí trong miệng sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['me miː', 'home həʊm'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'n',
    tips: [
      'Đọc gần giống âm N của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['noʊ nəʊ', 'pen pen'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'ŋ',
    tips: [
      'Đọc gần giống âm NG của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['sing sɪŋ', 'song sɒŋ'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'l',
    tips: [
      'Đọc gần giống âm L của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['like laɪk', 'call kɔːl'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'r',
    tips: [
      'Đọc gần giống âm R của tiếng Việt, đưa đầu lưỡi đến phía trên răng trên, sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['red red', 'car kɑːr'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
  Phoneme(
    label: 'w',
    tips: [
      'Đọc gần giống âm V của tiếng Việt, đưa môi chặn không khí trong miệng sau đó bật ra. Không thở ra khí qua mũi',
    ],
    type: Type.voiced,
    examples: ['we wiː', 'swim swɪm'],
    source: 'us_phonetics_sound_book_2023feb.mp3',
  ),
];

enum Type {
  short,
  long,
  diphthongs,
  unvoiced,
  voiced,
}

class Phoneme {
  final String label;
  final List<String> tips;
  final Type type;
  final List<String> examples;
  final String source;

  Phoneme(
      {required this.label,
      required this.tips,
      required this.type,
      required this.examples,
      required this.source});
}
