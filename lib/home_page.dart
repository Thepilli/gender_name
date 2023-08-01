import 'package:flutter/material.dart';
import 'package:gender_name/constants/applystyle.dart';
import 'package:gender_name/constants/colors.dart';
import 'package:gender_name/widgets/gender_circle.dart';
import 'package:gender_name/widgets/height_box.dart';
import 'package:gender_name/model/gender_name.dart';
import 'package:gender_name/services/gender_name_service.dart';
import 'package:gender_name/widgets/material_button.dart';
import 'package:gender_name/widgets/width_box.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GenderName? genderResult;
  TextEditingController nameController = TextEditingController();
  bool _isEnabled = false;
  int count = 0;
  String name = '';
  String gender = '';
  double probability = 0;
  bool isRunning = true;
  bool isFemaleNotPicked = true;
  bool isMaleNotPicked = true;

  @override
  void initState() {
    nameController.addListener(updateButtonState);
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      _isEnabled = nameController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;

    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5de94),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //welcome
                    //text
                    Text(
                      "Welcome to the Genderize model",
                      textAlign: TextAlign.center,
                      style: appstyle(30, AppColors.jPrimaryColor, FontWeight.w700),
                    ),
                    const HeightBox(height: 40),

                    // enter the name  -- use whisperrer for the most common names? DB of czech names?
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextField(
                        controller: nameController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter the name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.jPrimaryColor, width: 3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.jSecondaryColor, width: 3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const HeightBox(height: 40),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GenderCircle(
                            imgPath: 'assets/images/male_circle.png',
                            shadowColor: Colors.blueAccent,
                            isNotPicked: isMaleNotPicked,
                          ),
                          const WidthBox(width: 20),
                          GenderCircle(
                            imgPath: 'assets/images/female_circle.png',
                            shadowColor: Colors.pinkAccent,
                            isNotPicked: isFemaleNotPicked,
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(height: 40),

                    Text(
                      capitalizeFirstLetter(name),
                      style: appstyle(
                        30,
                        gender == 'male' ? Colors.blueAccent : Colors.pinkAccent,
                        FontWeight.w500,
                      ),
                    ),
                    Text(
                      'The name is most likely $gender',
                      style: appstyle(15, AppColors.textDarkColor, FontWeight.normal),
                    ),

                    const HeightBox(height: 40),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      width: 400,
                      animation: true,
                      lineHeight: 30.0,
                      animationDuration: 4000,
                      percent: probability,
                      animateFromLastPercent: false,
                      barRadius: const Radius.circular(90),
                      center: probability != 0 ? Text("${(probability * 100).toInt()}%") : null,
                      progressColor: gender == 'male' ? Colors.blueAccent : Colors.pinkAccent,
                      backgroundColor: probability != 0 ? AppColors.jSecondaryColor : Colors.transparent,
                    ),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: MyMaterialButton(
                          buttonText: name == '' ? 'Check the name' : 'Check another name',
                          onPressed: () async {
                            genderResult = await GendernameService().getGender(name: nameController.text);
                            setState(() {
                              nameController.clear();
                              count = genderResult?.count ?? 0;
                              name = genderResult?.name ?? '';
                              gender = genderResult?.gender ?? '';
                              probability = genderResult?.probability ?? 0;
                              isFemaleNotPicked = gender == 'female' ? true : false;
                              isMaleNotPicked = gender == 'male' ? true : false;
                            });
                          },
                          isEnabled: _isEnabled),
                    ),
                  ],
                ),
                Text(
                  'This is based on $count cases where ${(probability * 100).toInt()}% of individuals were $gender ',
                  textAlign: TextAlign.center,
                  style: appstyle(15, AppColors.textDarkColor, FontWeight.normal),
                ),
                // const Text(
                //     "Please be aware that the results are subjective, open for interpretation and should not be used to make any important decisions. They are based on a language model trained on 114 million cases "),
                // const HeightBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
