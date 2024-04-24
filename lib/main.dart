import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/services/api_service.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/core/services/shared_pref_service.dart';
import 'package:ctue_app/features/auth/presentation/pages/login_page.dart';
import 'package:ctue_app/features/contribute/presentation/pages/contri_history_page.dart';
import 'package:ctue_app/features/home/presentation/providers/home_provider.dart';
import 'package:ctue_app/features/irregular_verb/presentation/pages/add_irr_verb_page.dart';
import 'package:ctue_app/features/irregular_verb/presentation/pages/edit_irr_verb_page.dart';
import 'package:ctue_app/features/learn/presentation/pages/learn_history_page.dart';
import 'package:ctue_app/features/learn/presentation/pages/learned_result.dart';
import 'package:ctue_app/features/learn/presentation/pages/select_word_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/acc_management_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/account_detail_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/contri_management_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/dict_management_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/irre_verb_management_page.dart';
import 'package:ctue_app/features/statistics/presentation/pages/overivew_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/sen_management_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/voca_set_management.dart';
import 'package:ctue_app/features/notification/presentation/providers/notification_provider.dart';
import 'package:ctue_app/features/sentence/presentation/pages/add_sentence_page.dart';
import 'package:ctue_app/features/sentence/presentation/pages/edit_sentence_page%20copy.dart';
import 'package:ctue_app/features/speech/presentation/pages/improve_pronunciation_page.dart';
import 'package:ctue_app/features/statistics/presentation/providers/statistics_provider.dart';
import 'package:ctue_app/features/user/presentation/pages/reset_password_page.dart';
import 'package:ctue_app/features/auth/presentation/pages/sign_up_page.dart';
// import 'package:ctue_app/features/auth/presentation/pages/verify_code_page.dart';
import 'package:ctue_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:ctue_app/features/contribute/presentation/pages/contribure_page.dart';
import 'package:ctue_app/features/contribute/presentation/providers/contribution_provider.dart';
import 'package:ctue_app/features/extension/presentation/pages/favotite_vocabulary.dart';
import 'package:ctue_app/features/extension/presentation/providers/favorite_provider.dart';
import 'package:ctue_app/features/game/presentation/pages/correct_word_page.dart';
import 'package:ctue_app/features/game/presentation/pages/game_page.dart';
import 'package:ctue_app/features/game/presentation/pages/word_match_page.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/home/presentation/pages/ipa_page.dart';
import 'package:ctue_app/features/irregular_verb/presentation/pages/irregular_verb_page.dart';
import 'package:ctue_app/features/home/presentation/pages/welcome_page.dart';
import 'package:ctue_app/features/sentence/presentation/pages/com_phrase_detail.dart';
import 'package:ctue_app/features/sentence/presentation/pages/communication_phrase_page.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/presentation/pages/verify_code_page.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/edit_voca_set_page.dart';
import 'package:ctue_app/features/word/presentation/pages/add_word_page.dart';
import 'package:ctue_app/features/word/presentation/pages/edit_word_page.dart';
import 'package:ctue_app/features/word/presentation/pages/word_detail.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:ctue_app/features/level/presentation/providers/level_provider.dart';
import 'package:ctue_app/features/notification/presentation/pages/notification.dart';
import 'package:ctue_app/features/speech/presentation/pages/pronoun_statistic_detail_page.dart';
import 'package:ctue_app/features/profile/presentation/pages/setting_page.dart';
import 'package:ctue_app/features/profile/presentation/pages/user_info_page.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/specialization/presentation/providers/spec_provider.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/presentation/providers/type_provider.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:ctue_app/features/word/presentation/pages/look_up_result_page.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/create_vocabulary_set.dart';
import 'package:ctue_app/features/learn/presentation/pages/learn_page.dart';
import 'package:ctue_app/features/learn/presentation/pages/learn_setting_page.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/search_voca_set.dart';
import 'package:ctue_app/features/learn/presentation/pages/statistic_learned_words.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/vocabulary_set_detail.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/vocabulary_set_store.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/providers/voca_set_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/skeleton/providers/selected_page_provider.dart';
import 'features/skeleton/skeleton.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:rename/rename.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz; // For timezone support
// import 'package:timezone/timezone.dart' as tz;

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
// final _messageStreamController = BehaviorSubject<RemoteMessage>();

// TODO: Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // It requests a registration token for sending messages to users from your App server or other trusted server environment.
  // String? token = await messaging.getToken();

  // if (kDebugMode) {
  //   print('Registration Token=$token');
  // }

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   if (kDebugMode) {
  //     print('Handling a foreground message: ${message.messageId}');
  //     print('Message data: ${message.data}');
  //     print('Message notification: ${message.notification?.title}');
  //     print('Message notification: ${message.notification?.body}');
  //   }

  //   _messageStreamController.sink.add(message);
  // });

  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await dotenv.load(fileName: "lib/.env");
  ApiService.init();
  AudioService.init();
  SecureStorageService.init();
  SharedPrefService.init();
  await _initializeNotifications();
  runApp(const MyApp());
}

Future<void> _initializeNotifications() async {
  // Initialization settings for Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // Initialization settings for iOS
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  // Initialization settings for initializing both platforms
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SelectedPageProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => PokemonProvider(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => SelectedPokemonItemProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => TopicProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => SentenceProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => WordProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => IrrVerbProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => TypeProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => SpecializationProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => LevelProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => ContributionProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => VocaSetProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => SpeechProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => LearnProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => StatisticsProvider(),
          // builder: (context, child) {},
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
          // builder: (context, child) {},
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CTUE Learn English',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.teal,
            primaryColor: Colors.teal,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue.shade800,
              // titleTextStyle: const TextStyle(
              //   color: Colors.black87,
              //   fontSize: 30,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            fontFamily: 'Roboto',
            // Define the default brightness and colors.
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              secondary: Colors.teal.shade300,
              tertiary: Colors.green.shade600,
              // ···
              brightness: Brightness.light,
            ),
            searchBarTheme: const SearchBarThemeData(
              textStyle: MaterialStatePropertyAll(TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.normal)),
            ),
            textTheme: TextTheme(
              displaySmall: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey.shade700),
              // ···
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey.shade700),
              titleMedium:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              labelMedium: const TextStyle(
                  // fontSize: 13,
                  fontWeight: FontWeight.bold),

              bodyMedium: TextStyle(
                  color: Colors.grey.shade900, fontWeight: FontWeight.normal),
              bodyLarge: const TextStyle(fontWeight: FontWeight.w600),
              // displaySmall: TextStyle(
              //     // fontSize: 13,
              //     color: Colors.grey.shade600,
              //     fontWeight: FontWeight.w500),
            ),
            inputDecorationTheme: InputDecorationTheme(
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red.shade400)),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.tealAccent.shade700),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    textStyle: const MaterialStatePropertyAll(TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500))))),
        initialRoute: RouteNames.home,
        routes: {
          RouteNames.home: (context) => const Home(),
          RouteNames.welcome: (context) => WelcomePage(),
          RouteNames.verifyCode: (context) => const VerifyCodePage(),
          RouteNames.login: (context) => const LoginPage(),
          RouteNames.resetPassword: (context) => const ResetPasswordPage(),
          RouteNames.signUp: (context) => const SignUpPage(),
          RouteNames.correctWord: (context) => const CorrectWordPage(),
          RouteNames.wordMatch: (context) => const WordMatchPage(),
          RouteNames.contribution: (context) => const ContributePage(),
          RouteNames.contributionHistory: (context) =>
              const ContributionHistory(),
          RouteNames.games: (context) => GamePage(),
          RouteNames.setting: (context) => const SettingPage(),
          RouteNames.userInfo: (context) => const UserInfoPage(),
          RouteNames.ipa: (context) => const IPA(),
          RouteNames.learn: (context) => const LearnPage(),
          RouteNames.learnSetting: (context) => const LearnSettingPage(),
          RouteNames.selectWord: (context) => const SelectWordPage(),
          RouteNames.learnedResult: (context) => const LearningResult(),
          RouteNames.dictionary: (context) => const DictionaryPage(),
          RouteNames.lookUpResult: (context) => LookUpResultPage(),
          RouteNames.wordDetail: (context) => const WordDetail(),
          RouteNames.irregularVerbs: (context) => const IrregularVerbPage(),
          RouteNames.favoriteVocabulary: (context) => FavoriteVocabulary(),
          RouteNames.communicationPhrases: (context) => const ComPhrasePage(),
          RouteNames.communicationPhraseDetail: (context) =>
              const CommunicationPhraseDetail(),
          RouteNames.notification: (context) => const NotificationPage(),
          RouteNames.createVocabularySet: (context) =>
              const CreateVocabularySet(),
          RouteNames.vocabularySets: (context) => const VocabularySetStore(),
          RouteNames.searchVocaSet: (context) => SearchVocaSetPage(),
          RouteNames.vocabularySetDetail: (context) =>
              const VocabularySetDetail(),
          RouteNames.statisticLearnedWords: (context) =>
              const StatisticLearnedWordPage(),
          RouteNames.proStatisticsDetail: (context) =>
              const ProStatisticDetailPage(),
          RouteNames.improvePronunciation: (context) =>
              const ImprovePronunciationPage(),
          RouteNames.accManagement: (context) => const AccountManagementPage(),
          RouteNames.contriManagement: (context) =>
              const ContributionManagementPage(),
          RouteNames.dictManagement: (context) =>
              const DictionaryManagementPage(),
          RouteNames.senManagement: (context) => const SentenceManagementPage(),
          RouteNames.irrVerbManagement: (context) =>
              const IrreVerbManagementPage(),
          RouteNames.addWord: (context) => const AddWordPage(),
          RouteNames.editWord: (context) => const EditWordPage(),
          RouteNames.addSentence: (context) => const AddSentencePage(),
          RouteNames.editSentence: (context) => const EditSentencePage(),
          RouteNames.addIrregularVerb: (context) => AddIrregularVerbPage(),
          RouteNames.editIrregularVerbCode: (context) =>
              const EditIrregularVerbPage(),
          RouteNames.vocaSetManagement: (context) =>
              const VocaSetManagementPage(),
          RouteNames.editVocaSet: (context) => const EditVocabularySet(),
          RouteNames.adminOverview: (context) => const OverviewPage(),
          RouteNames.accountDetail: (context) => const AccountDetailPage(),
          RouteNames.learningHistory: (context) => const LearningHistoryPage(),
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String _lastMessage = "";

  _HomeState() {
    // _messageStreamController.listen((message) {
    //   setState(() {
    //     if (message.notification != null) {
    //       _lastMessage = 'Received a notification message:'
    //           '\nTitle=${message.notification?.title},'
    //           '\nBody=${message.notification?.body},'
    //           '\nData=${message.data}';
    //     } else {
    //       _lastMessage = 'Received a data message: ${message.data}';
    //     }
    //   });
    //   if (kDebugMode) {
    //     print(_lastMessage);
    //   }
    // });
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
      Provider.of<NotificationProvider>(context, listen: false).hasNewNoti =
          true;
      // _messageStreamController.sink.add(message);/
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _checkLoggedInStatus(context) async {
    final accessToken = await Provider.of<AuthProvider>(context, listen: false)
        .getAccessToken();

    if (accessToken != null) {
      await Provider.of<UserProvider>(context, listen: false)
          .eitherFailureOrGetUser();
      if (Provider.of<UserProvider>(context, listen: false).userEntity ==
          null) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, '/welcome', (route) => false);
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkLoggedInStatus(context);
    return Consumer<UserProvider>(builder: (context, provider, child) {
      UserEntity? userEntity = provider.userEntity;

      bool isLoading = provider.isLoading;

      Failure? failure = provider.failure;

      if (!isLoading && failure != null) {
        // Handle failure, for example, show an error message
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text(failure.errorMessage)));
      } else if (isLoading && userEntity == null) {
        // Handle the case where topics are empty
        return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()));
      } else if (!isLoading && userEntity != null) {
        return const Skeleton();
      } else {
        return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
