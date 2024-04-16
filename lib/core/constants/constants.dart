String kTemplate = 'template';

// String kName = 'name';
// String kId = 'id';
String kSprites = 'sprites';
String kTypes = 'types';
String kType = 'type';
String kOther = 'other';
String kOfficialArtwork = 'official-artwork';
String kFrontDefault = 'front_default';
String kFrontShiny = 'front_shiny';

String kAccessToken = 'accessToken';
String kData = 'data';
String kBody = 'body';
String kMessage = 'message';
String kEmail = 'email';
String kUserId = 'userId';
String kAuthType = 'authType';
String kAccountType = 'accountType';
String kIsBan = 'isBan';
String kFeedback = 'feedback';
String kIsDeleted = 'isDeleted';

String kId = 'id';
String kName = 'name';
String kAvt = 'avt';
String kCreatedAt = 'createdAt';
String kUpdatedAt = 'updatedAt';
String kisWord = 'isWord';

String kTypeId = 'typeId';
String kContent = 'content';
String kMean = 'meaning';

String kNote = 'note';

String kTopics = 'topics';
String kMeanings = 'meanings';
String kLevelId = 'levelId';
String kSpecializationId = 'specializationId';
String kPhonetic = 'phonetic';
String kPictures = 'pictures';
String kPicture = 'picture';
String kExamples = 'examples';
String kSynonyms = 'synonyms';
String kAntonyms = 'antonyms';

String kMeaning = 'meaning';
String kWordId = 'wordId';

String kV1 = 'v1';
String kV2 = 'v2';
String kV3 = 'v3';
String kWords = 'words';
String kLearnedWords = 'learnedWords';
String kWord = 'Word';
String kStatus = 'status';
String kUser = 'User';
String kContriType = 'type';
String kTitle = 'title';
String kIsPublic = 'isPublic';
String kDownloads = 'downloads';
String kSpecId = 'specId';
String kTopicId = 'topicId';
String kSpecialization = 'Specialization';
String kTopic = 'Topic';
String kDisplayName = 'DisplayName';
String kShortName = 'ShortName';
String kGender = 'Gender';
String kLocate = 'Locale';
String kVoiceType = 'VoiceType';
String kConfidence = 'confidence';
String kLabel = 'label';
String kScore = 'score';
String kPhonemeAssessment = 'phonemeAssessments';
String kDetail = 'detail';
String kAvg = 'Avg';
String kavg = 'avg';
String kLablesNeedToBeImprove = 'lablesNeedToBeImprove';
String kLablesDoWell = 'lablesDoWell';
String kSuggestWordsToImprove = 'suggestWordsToImprove';

String kNumberOfWords = 'count';
String kLevel_1 = 'level_1';
String kLevel_2 = 'level_2';
String kLevel_3 = 'level_3';
String kLevel_4 = 'level_4';
String kLevel_5 = 'level_5';
String kLevel_6 = 'level_6';

String kVocaSetId = 'vocabularySetId';
String kMemoryLevel = 'memoryLevel';
String kIsDone = 'isDone';
String kReviewAt = 'reviewAt';

String kTotal = 'total';
String kTotalPages = 'totalPages';

enum ResponseData { data, message, statusCode }

String localeUS = 'en-US';

int maxPokemonId = 1008;
int maxDisplayedWords = 5;

class VocabularySetArguments {
  final int id;
  final bool isAdmin;

  VocabularySetArguments({required this.id, this.isAdmin = false});
}

String accNotFound = 'Tài khoản không tồn tại';
String accBaned = 'Tài khoản đã bị khóa';
String pwdErrorMessage = 'Mật khẩu không chính xác';

String typeConWord = 'word';
String typeConSen = 'sentence';
const int refused = -1;
const int pending = -1;
const int approved = -1;

String defaultDisplayName = 'Ava';
String defaultLocale = 'en-US';
String defaultGender = 'Female';
String defaultShortName = 'en-US-AvaNeural';
String defaultVoiceType = 'Neural';

class ContributionType {
  static const String word = 'word';
  static const String sentence = 'sentence';
}

class AccountType {
  static const String user = 'user';
  static const String admin = 'admin';
}

class NotificationType {
  static const String contribution = 'contribution';
}

class ContributionStatus {
  static const int refused = -1;
  static const int pending = 0;
  static const int approved = 1;
}

const String channelId = 'CTUE';
const String channelName = 'ctue_learning_english_app';
const String channelDescription = 'Learning English application';

const String kActive = 'active';
const String kBanned = 'banned';
const String kDeleted = 'deleted';

const String kPending = 'pending';
const String kRefused = 'refused';
const String kApproved = 'approved';
const String kSpecializationName = 'specializationName';
const String kLevelName = 'levelName';
const String kTopicName = 'topicName';
const String kTypeName = 'typeName';
const String kCount = 'count';

const String kBySpecialization = 'bySpecialization';
const String kByLevel = 'byLevel';
const String kByTopic = 'byTopic';
const String kByType = 'byType';

const String kTotalPublic = 'totalPublic';
const String kTotalPrivate = 'totalPrivate';

const String kInterestTopics = 'interestTopics';
