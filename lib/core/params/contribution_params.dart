import 'package:image_picker/image_picker.dart';

class CreateWordConParams {
  final String type;
  final Content content;
  final String accessToken;
  CreateWordConParams(
      {required this.type, required this.content, required this.accessToken});
}

class Content {
  final List<int> topicId;
  final int levelId;
  final int specializationId;
  final String content;
  final List<WordMeaning> meanings;
  final String? note;
  final String phonetic;
  final List<String> examples;
  final List<String> synonyms;
  final List<String> antonyms;
  final List<XFile> pictures;

  Content(
      {required this.topicId,
      required this.levelId,
      required this.specializationId,
      required this.content,
      required this.meanings,
      required this.phonetic,
      required this.examples,
      required this.antonyms,
      required this.synonyms,
      required this.note,
      required this.pictures});
}

class WordMeaning {
  final int typeId;
  final String meaning;

  WordMeaning({required this.typeId, required this.meaning});
}

/*
class WordMeaning {
  // @ApiProperty()
  // @IsNumber()
  // wordId: number

  @ApiProperty()
  @IsNumber()
  typeId: number


  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  @MaxLength(CONSTANTS_MAX.WORD_MEAN_LEN)
  meaning: string
}


class Content {

  @ApiProperty()
  @IsNotEmpty()
  @IsArray()
  @Transform((params: TransformFnParams) => {
    return params.value.map((item) => parseInt(item, 10));
  })
  @IsNumber({}, { each: true })
  topicId?: number[];

  @ApiProperty()
  // @IsOptional()
  @IsNumber()
  levelId?: number;

  @ApiProperty()
  // @IsOptional()
  @IsNumber()
  specializationId?: number;

  @ApiProperty()
  // @IsNotEmpty()
  @IsString()
  @MaxLength(CONSTANTS_MAX.WORD_CONTENT_LEN)
  content?: string;

  @ApiProperty({ type: () => WordMeaning, isArray: true })
  @IsNotEmpty()
  @IsArray()
  @Type(() => WordMeaning)
  meanings: WordMeaning[];

  @ApiProperty()
  @IsOptional()
  @IsString()
  @MaxLength(CONSTANTS_MAX.WORD_NOTE_LEN)
  note?: string;

  @ApiProperty()
  // @IsOptional()
  @IsString()
  phonetic?: string;

  @ApiProperty()
  @IsOptional()
  @IsArray()
  examples?: string[];

  @ApiProperty()
  @IsOptional()
  @IsArray()
  synonyms?: string[];

  @ApiProperty()
  @IsOptional()
  @IsArray()
  antonyms?: string[];

  @ApiProperty({ name: 'pictures', type: 'array', items: { type: 'string', format: 'binary', } })
  @IsOptional()
  @IsString()
  pictures?: string[];
}

export class CreateWordContributionDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  type: string;

  @IsNotEmptyObject()
  @IsObject()
  // @IsNotEmpty()
  @ValidateNested()
  @ApiProperty()
  @Type(() => Content)
  content: Content;
}
*/