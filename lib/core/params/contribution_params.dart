import 'package:image_picker/image_picker.dart';

class CreateWordConParams {
  final String type;
  final Content content;
  final String accessToken;
  CreateWordConParams(
      {required this.type, required this.content, required this.accessToken});
}

class CreateSenConParams {
  final String type;
  final Content content;
  final String accessToken;
  CreateSenConParams(
      {required this.type, required this.content, required this.accessToken});
}

class Content {
  List<dynamic> topicId = [];
  final int? levelId;
  final int? specializationId;
  final int? typeId;
  final String content;
  List<WordMeaning>? meanings = [];
  final String? meaning;
  final String? note;
  final String? phonetic;
  List<String>? examples = [];
  List<String>? synonyms = [];
  List<String>? antonyms = [];
  List<XFile>? pictures = [];

  Content(
      {required this.topicId,
      this.levelId,
      this.specializationId,
      this.typeId,
      required this.content,
      this.meanings,
      this.meaning,
      this.phonetic,
      this.examples,
      this.antonyms,
      this.synonyms,
      this.note,
      this.pictures});
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