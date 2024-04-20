import 'package:flutter/material.dart';

class RouteNames {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String verifyCode = '/verify-code';
  static const String login = '/login';
  static const String resetPassword = '/reset-password';
  static const String signUp = '/sign-up';
  static const String correctWord = '/correct-word';
  static const String wordMatch = '/word-match';
  static const String contribution = '/contribution';
  static const String contributionHistory = '/contribution-history';
  static const String games = '/games';
  static const String setting = '/setting';
  static const String userInfo = '/user-info';
  static const String ipa = '/ipa';
  static const String learn = '/learn';
  static const String learnSetting = '/learn-setting';
  static const String selectWord = '/select-word';
  static const String learnedResult = '/learned-result';
  static const String dictionary = '/dictionary';
  static const String lookUpResult = '/look-up-result';
  static const String wordDetail = '/word-detail';
  static const String irregularVerbs = '/irregular-verb';
  static const String favoriteVocabulary = '/favorite-vocabulary';
  static const String communicationPhrases = '/communication-phrases';
  static const String communicationPhraseDetail =
      '/communication-phrase-detail';
  static const String notification = '/notification';
  static const String createVocabularySet = '/create-vocabulary-set';
  static const String vocabularySets = '/vocabulary-sets';
  static const String searchVocaSet = '/search-voca-set';
  static const String vocabularySetDetail = '/vocabulary-set-detail';
  static const String statisticLearnedWords = '/statistic-learned-words';
  static const String proStatisticsDetail = '/pro-statistics-detail';
  static const String improvePronunciation = '/improve-pronunciation';
  static const String accManagement = '/acc-management';
  static const String contriManagement = '/contri-management';
  static const String dictManagement = '/dict-management';
  static const String senManagement = '/sen-management';
  static const String irrVerbManagement = '/irr-verb-management';
  static const String addWord = '/add-word';
  static const String editWord = '/edit-word';
  static const String addSentence = '/add-sentence';
  static const String editSentence = '/edit-sentence';
  static const String addIrregularVerb = '/add-irregular-verb';
  static const String editIrregularVerbCode = '/edit-irregular-verb';
  static const String vocaSetManagement = '/voca-set-management';
  static const String editVocaSet = '/edit-voca-set';
  static const String adminOverview = '/admin-overview';
  static const String accountDetail = '/account-detail';
}

String getRouteName(String url) {
  switch (url) {
    // case RouteNames.home:
    //   return 'Home';
    // case RouteNames.welcome:
    //   return 'Home';
    // case RouteNames.verifyCode:
    //   return 'Home';
    // case RouteNames.login:
    //   return 'Home';
    // case RouteNames.resetPassword:
    //   return 'Home';
    // case RouteNames.signUp:
    //   return 'Home';
    // case RouteNames.correctWord:
    //   return 'Home';
    // case RouteNames.wordMatch:
    //   return 'Home';
    case RouteNames.contribution:
      return 'Đóng góp';
    case RouteNames.contributionHistory:
      return 'Lịch sử đóng góp';
    // case RouteNames.games:
    // return 'Home';
    case RouteNames.setting:
      return 'Cài đặt';
    case RouteNames.userInfo:
      return 'Thông tin cá nhân';
    case RouteNames.ipa:
      return 'Bảng phiên âm';
    // case RouteNames.learn:
    // return 'Home';
    // case RouteNames.learnSetting:
    // return 'Home';
    // case RouteNames.selectWord:
    // return 'Home';
    // case RouteNames.learnedResult:
    // return 'Home';
    case RouteNames.dictionary:
      return 'Từ điển';
    // case RouteNames.lookUpResult:
    // return 'Home';
    // case RouteNames.wordDetail:
    // return 'Home';
    case RouteNames.irregularVerbs:
      return 'Danh sách động từ bất quy tắc';
    case RouteNames.favoriteVocabulary:
      return 'Từ vựng yêu thích';
    case RouteNames.communicationPhrases:
      return 'Mẫu câu giao tiếp thông dụng';
    // case RouteNames.communicationPhraseDetail:
    // return 'Home';
    // case RouteNames.notification:
    //   return 'Home';
    // case RouteNames.createVocabularySet:
    // return 'Home';
    // case RouteNames.vocabularySets:
    //   return 'Home';
    // case RouteNames.searchVocaSet:
    // return 'Home';
    // case RouteNames.vocabularySetDetail:
    // return 'Home';
    // case RouteNames.statisticLearnedWords:
    // return 'Home';
    case RouteNames.proStatisticsDetail:
      return 'Báo cáo chi tiết phát âm';
    case RouteNames.improvePronunciation:
      return 'Cải thiện phát âm';
    // case RouteNames.accManagement:
    // return 'Home';
    // case RouteNames.contriManagement:
    //   return 'Home';
    // case RouteNames.dictManagement:
    //   return 'Home';
    // case RouteNames.senManagement:
    //   return 'Home';
    // case RouteNames.irrVerbManagement:
    //   return 'Home';
    // case RouteNames.addWord:
    //   return 'Home';
    // case RouteNames.editWord:
    //   return 'Home';
    // case RouteNames.addSentence:
    //   return 'Home';
    // case RouteNames.editSentence:
    //   return 'Home';
    // case RouteNames.addIrregularVerb:
    //   return 'Home';
    // case RouteNames.editIrregularVerbCode:
    //   return 'Home';
    // case RouteNames.vocaSetManagement:
    //   return 'Home';
    // case RouteNames.editVocaSet:
    //   return 'Home';
    case RouteNames.adminOverview:
      return 'Tổng quan';
    default:
      return 'Trang chủ';
  }
}

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

Color isLoadingColor = Colors.grey.shade100;
