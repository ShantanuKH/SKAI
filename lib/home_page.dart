import 'package:flutter/material.dart';
import 'package:voice_assistance_app/feature_box.dart';
import 'package:voice_assistance_app/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SKAI"),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/assiatanceImg.jpeg'),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                "Hello! What can I do for you?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 18,
                  color: Pallete.mainFontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Here are few features :",
              
                  style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 18,
                    color: Pallete.mainFontColor,
                    fontWeight: FontWeight.w500,
                  ),),
            ),
        
            Column(
              children: [
                FeatureBox(color: Pallete.firstSuggestionBoxColor,
                headerText: "ChatGPT",
                descriptionText: "Elevate your organization and stay effortlessly informed with ChatGPT",),
                FeatureBox(color: Pallete.secondSuggestionBoxColor,
                headerText: "Dall-E",
                descriptionText: "Unleash your creativity and bring your ideas to life with DALL·E",),
                FeatureBox(color: Pallete.thirdSuggestionBoxColor,
                headerText: "Smart Voice Assistance",
                descriptionText: "Smart Voice Assistance. A helpful assistant for managing tasks and finding information quickly.",)
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.mic_none_rounded),
        backgroundColor: Pallete.whiteColor,

      ),
    );
  }
}
