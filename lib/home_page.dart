import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistance_app/feature_box.dart';
import 'package:voice_assistance_app/openai_service.dart';
import 'package:voice_assistance_app/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  String lastWords = '';
  final OpenaiService openAIService = OpenaiService();
  String? generatedContent;
  String? generatedImageUrl;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    flutterTts.setStartHandler(() {
      print("Speech started");
    });

    flutterTts.setCompletionHandler(() {
      print("Speech completed");
    });

    flutterTts.setErrorHandler((error) {
      print("Error occurred: $error");
    });

    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    speechToText.stop();
    flutterTts.stop();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FadeTransition(
            opacity: _animation,
            child: const Text("SKAI"),
          ),
          centerTitle: true,
          leading: const Icon(Icons.menu),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/SKAI.jpeg'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: generatedImageUrl == null,
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Pallete.borderColor,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      generatedContent == null
                          ? "Hello! What can I do for you?"
                          : generatedContent!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: generatedContent == null ? 25 : 18,
                        color: Pallete.mainFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (generatedImageUrl != null)
                FadeTransition(
                  opacity: _animation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        generatedImageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Here are a few features:",
                      style: TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: 18,
                        color: Pallete.mainFontColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideTransition(
                      position: _animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.0, 0.2),
                          end: Offset.zero,
                        ),
                      ),
                      child: FeatureBox(
                        color: Pallete.firstSuggestionBoxColor,
                        headerText: "ChatGPT",
                        descriptionText:
                            "Elevate your organization and stay effortlessly informed with ChatGPT",
                      ),
                    ),
                    SlideTransition(
                      position: _animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.0, 0.2),
                          end: Offset.zero,
                        ),
                      ),
                      child: FeatureBox(
                        color: Pallete.secondSuggestionBoxColor,
                        headerText: "Dall-E",
                        descriptionText:
                            "Unleash your creativity and bring your ideas to life with DALL·E",
                      ),
                    ),
                    SlideTransition(
                      position: _animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.0, 0.2),
                          end: Offset.zero,
                        ),
                      ),
                      child: FeatureBox(
                        color: Pallete.thirdSuggestionBoxColor,
                        headerText: "Smart Voice Assistance",
                        descriptionText:
                            "Smart Voice Assistance. A helpful assistant for managing tasks and finding information quickly.",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission && !speechToText.isListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic_none_rounded,
          ),
        ),
      ),
    );
  }
}
