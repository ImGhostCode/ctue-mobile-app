import 'package:ctue_app/features/auth/presentation/pages/login_page.dart';
import 'package:ctue_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:ctue_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ctue_app/features/auth/presentation/pages/verify_code_page.dart';
import 'package:ctue_app/features/contribute/presentation/pages/contribure_page.dart';
import 'package:ctue_app/features/game/presentation/pages/correct_word_page.dart';
import 'package:ctue_app/features/game/presentation/pages/game_page.dart';
import 'package:ctue_app/features/game/presentation/pages/word_match_page.dart';
import 'package:ctue_app/features/home/presentation/pages/com_phrase_detail.dart';
import 'package:ctue_app/features/home/presentation/pages/communication_phrase_page.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/home/presentation/pages/ipa_page.dart';
import 'package:ctue_app/features/home/presentation/pages/irregular_verb_page.dart';
import 'package:ctue_app/features/home/presentation/pages/word_detail.dart';
import 'package:ctue_app/features/notification/presentation/pages/notification.dart';
import 'package:ctue_app/features/profile/presentation/pages/setting_page.dart';
import 'package:ctue_app/features/profile/presentation/pages/user_info_page.dart';
import 'package:ctue_app/features/word_store/presentation/pages/create_vocabulary_set.dart';
import 'package:ctue_app/features/word_store/presentation/pages/statistic_learned_words.dart';
import 'package:ctue_app/features/word_store/presentation/pages/vocabulary_set_detail.dart';
import 'package:ctue_app/features/word_store/presentation/pages/vocabulary_sets_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'features/pokemon/presentation/providers/pokemon_provider.dart';
// import 'features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'features/skeleton/providers/selected_page_provider.dart';
import 'features/skeleton/skeleton.dart';

import 'package:rename/rename.dart';

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CTUE',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.teal,
            primaryColor: Colors.teal,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black87,
            )),
        home: const Home(),
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
    // SelectedPokemonItemProvider selectedPokemonItem =
    //     Provider.of<SelectedPokemonItemProvider>(context, listen: false);

    // Provider.of<PokemonProvider>(context, listen: false).eitherFailureOrPokemon(
    //   value: (selectedPokemonItem.number + 1).toString(),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CTUE Learn English',
      theme: ThemeData(
          fontFamily: 'Roboto',
          useMaterial3: true,

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
                color: Colors.grey.shade500, fontWeight: FontWeight.w600),
            bodyLarge: const TextStyle(fontWeight: FontWeight.w600),
            // displaySmall: TextStyle(
            //     // fontSize: 13,
            //     color: Colors.grey.shade600,
            //     fontWeight: FontWeight.w500),
          ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.blue.shade800),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.teal),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  textStyle: const MaterialStatePropertyAll(TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500))))),
      initialRoute: '/',
      routes: {
        '/': (context) => const Skeleton(),
        // '/': (context) => const LoginPage(),
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
        '/dictionary': (context) => DictionaryPage(),
        '/word-detail': (context) => WordDetail(),
        '/irregular-verb': (context) => IrregularVerbPage(),
        '/communication-phrases': (context) => ComPhrasePage(),
        '/communication-phrase-detail': (context) =>
            CommunicationPhraseDetail(),
        '/notification': (context) => const NotificationPage(),
        '/create-vocabulary-set': (context) => const CreateVocabularySet(),
        '/vocabulary-sets': (context) => const VocabularySets(),
        '/vocabulary-set-detail': (context) => const VocabularySetDetail(),
        '/statistic-learned-words': (context) =>
            const StatisticLearnedWordPage(),
      },
    );
    // return const Skeleton();
  }
}
