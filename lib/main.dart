import 'package:ctue_app/core/service/api_service.dart';
import 'package:ctue_app/core/service/audio_service.dart';
import 'package:ctue_app/features/auth/presentation/pages/login_page.dart';
import 'package:ctue_app/features/auth/presentation/pages/reset_password_page.dart';
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
import 'package:ctue_app/features/word/presentation/pages/word_detail.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:ctue_app/features/level/presentation/providers/level_provider.dart';
import 'package:ctue_app/features/notification/presentation/pages/notification.dart';
import 'package:ctue_app/features/profile/presentation/pages/pronoun_statistic_detail_page.dart';
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
import 'package:ctue_app/features/word_store/presentation/pages/create_vocabulary_set.dart';
import 'package:ctue_app/features/word_store/presentation/pages/learn_page.dart';
import 'package:ctue_app/features/word_store/presentation/pages/learn_setting_page.dart';
import 'package:ctue_app/features/word_store/presentation/pages/search_voca_set.dart';
import 'package:ctue_app/features/word_store/presentation/pages/statistic_learned_words.dart';
import 'package:ctue_app/features/word_store/presentation/pages/vocabulary_set_detail.dart';
import 'package:ctue_app/features/word_store/presentation/pages/vocabulary_sets_page.dart';
import 'package:ctue_app/features/word_store/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_azure_tts/flutter_azure_tts.dart';
import 'package:provider/provider.dart';
// import 'features/pokemon/presentation/providers/pokemon_provider.dart';
// import 'features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'features/skeleton/providers/selected_page_provider.dart';
import 'features/skeleton/skeleton.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:rename/rename.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  ApiService.init();
  AudioService.init();
  AzureTts.init(
      subscriptionKey: dotenv.env['SPEECH_KEY']!,
      region: dotenv.env['SPEECH_REGION']!,
      withLogs: true); // enable logs
  runApp(const MyApp());
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
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.tealAccent.shade700),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    textStyle: const MaterialStatePropertyAll(TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500))))),
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/welcome': (context) => const WelcomePage(),
          // '/verify-code': (context) => const VerifyCodePage(),
          '/login': (context) => const LoginPage(),
          '/reset-password': (context) => const ResetPasswordPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/correct-word': (context) => const CorrectWordPage(),
          '/word-match': (context) => const WordMatchPage(),
          '/contribution': (context) => const ContributePage(),
          '/games': (context) => GamePage(),
          '/setting': (context) => SettingPage(),
          '/user-info': (context) => UserInfoPage(),
          '/api': (context) => const IPA(),
          '/learn': (context) => const LearnPage(),
          '/learn-setting': (context) => const LearnSettingPage(),
          '/dictionary': (context) => DictionaryPage(),
          '/look-up-result': (context) => LookUpResultPage(),
          '/word-detail': (context) => WordDetail(),
          '/irregular-verb': (context) => IrregularVerbPage(),
          '/favorite-vocabulary': (context) => FavoriteVocabulary(),
          '/communication-phrases': (context) => ComPhrasePage(),
          '/communication-phrase-detail': (context) =>
              CommunicationPhraseDetail(),
          '/notification': (context) => const NotificationPage(),
          '/create-vocabulary-set': (context) => CreateVocabularySet(),
          '/vocabulary-sets': (context) => VocabularySets(),
          '/search-voca-set': (context) => SearchVocaSetPage(),
          '/vocabulary-set-detail': (context) => const VocabularySetDetail(),
          '/statistic-learned-words': (context) =>
              const StatisticLearnedWordPage(),
          '/pro-statistics-detail': (context) => const ProStatisticDetailPage(),
        },
        // home: const Home(),
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
  @override
  void initState() {
    super.initState();
    _checkLoggedInStatus(context);
  }

  Future<void> _checkLoggedInStatus(context) async {
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

      // Navigator.popUntil(context, (route) => false);
      // ignore: use_build_context_synchronously

      return;
      // }
    } else {
      // No token found, redirect to login
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
    }
  }

  final permissionCamera = Permission.camera;
  final permissionLocation = Permission.location;
  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
