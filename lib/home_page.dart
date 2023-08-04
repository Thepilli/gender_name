import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gender_name/constants/applystyle.dart';
import 'package:gender_name/constants/colors.dart';
import 'package:gender_name/services/localization.dart';
import 'package:gender_name/widgets/gender_circle.dart';
import 'package:gender_name/widgets/height_box.dart';
import 'package:gender_name/model/gender_name.dart';
import 'package:gender_name/services/gender_name_service.dart';
import 'package:gender_name/widgets/material_button.dart';
import 'package:gender_name/widgets/width_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  String genderT = '';
  bool noMatchFound = false;
  double probability = 0;
  bool isRunning = true;
  bool isFemale = false;
  bool isMale = false;
  bool receivedResponse = false;

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

  Map<String, dynamic> addTimestampToResponse(GenderName response) {
    final Map<String, dynamic> responseJson = response.toJson();
    responseJson['timestamp'] = FieldValue.serverTimestamp(); // Adding the timestamp key-value
    return responseJson;
  }

  // Function to save the modified response to Firebase Firestore
  void saveToFirebase(Map<String, dynamic> data) {
    FirebaseFirestore.instance.collection('NameSearch').add(data);
    // Replace 'your_collection' with the name of the collection in your Firebase Firestore where you want to save the data.
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;

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
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'welcome_title'.tr(),
                              textAlign: TextAlign.center,
                              style:
                                  GoogleFonts.russoOne(fontSize: 35, color: AppColors.jPrimaryColor, fontWeight: FontWeight.w700),
                              // style: appstyle(30, AppColors.jPrimaryColor, FontWeight.w700),
                            ),
                          ),
                          const WidthBox(width: 20),
                          ToggleSwitch(
                            customIcons: const [
                              Icon(
                                Icons.translate,
                                size: 15.0,
                                color: AppColors.whiteColor,
                              ),
                              Icon(
                                Icons.translate,
                                size: 15.0,
                                color: AppColors.whiteColor,
                              ),
                            ],
                            isVertical: true,
                            minWidth: 60,
                            animate: true,
                            cornerRadius: 20.0,
                            initialLabelIndex: context.locale == const Locale('en') ? 0 : 1,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: const ['EN', 'CS'],
                            onToggle: (index) {
                              LocalizationService.changeLocale(context, index!);
                            },
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(height: 20),

                    // enter the name  -- use whisperrer for the most common names? DB of czech names?
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextField(
                        controller: nameController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          labelText: 'textFieldLabel'.tr(),
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
                      constraints: const BoxConstraints(maxWidth: 400, minHeight: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GenderCircle(
                            imgPath: 'assets/images/male_circle.png',
                            shadowColor: Colors.blueAccent,
                            isPicked: isMale,
                          ),
                          const WidthBox(width: 20),
                          GenderCircle(
                            imgPath: 'assets/images/female_circle.png',
                            shadowColor: Colors.pinkAccent,
                            isPicked: isFemale,
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(height: 40),

                    Text(
                      capitalizeFirstLetter(name.toLowerCase()),
                      style: appstyle(
                        30,
                        gender == 'male' ? Colors.blueAccent : Colors.pinkAccent,
                        FontWeight.w500,
                      ),
                    ),
                    receivedResponse
                        ? Text(
                            'resultText'.tr() + tr('gender.${genderResult?.gender}'),
                            style: appstyle(15, AppColors.textDarkColor, FontWeight.normal),
                          )
                        : noMatchFound
                            ? SizedBox(
                                width: 300,
                                child: Text('noMatch'.tr(),
                                    style: appstyle(15, AppColors.textDarkColor, FontWeight.w200), textAlign: TextAlign.center),
                              )
                            : const SizedBox(),

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
                          buttonText: name == '' ? 'buttonCheck'.tr() : 'buttonCheckAgain'.tr(),
                          onPressed: () async {
                            genderResult = await GendernameService().getGender(name: nameController.text);
                            print(genderResult?.toJson());
                            setState(() {
                              if (genderResult?.gender != null) {
                                nameController.clear();
                                count = genderResult?.count ?? 0;
                                name = genderResult?.name ?? '';
                                gender = genderResult?.gender ?? '';
                                probability = genderResult?.probability ?? 0;
                                isFemale = gender == 'female' ? true : false;
                                isMale = gender == 'male' ? true : false;
                                receivedResponse = true;
                                Map<String, dynamic> modifiedResponse = addTimestampToResponse(genderResult!);
                                saveToFirebase(modifiedResponse);

                                // genderT = tr('gender.${genderResult?.gender}');
                              } else {
                                receivedResponse = false;
                                noMatchFound = true;
                                nameController.clear();
                              }
                            });
                          },
                          isEnabled: _isEnabled),
                    ),
                  ],
                ),
                receivedResponse && currentLocale.languageCode == 'en'
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Text(
                          'This is based on $count cases where ${(probability * 100).toInt()}% of individuals were $gender ',
                          textAlign: TextAlign.center,
                          style: appstyle(15, AppColors.textDarkColor, FontWeight.normal),
                        ),
                      )
                    : const SizedBox(),
                receivedResponse && currentLocale.languageCode == 'cs'
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Text(
                          'Toto je založeno na $count případech, kdy se  ${(probability * 100).toInt()}% jedinců identifikovalo jako ${tr('genderVar.${genderResult?.gender}')}',
                          textAlign: TextAlign.center,
                          style: appstyle(15, AppColors.textDarkColor, FontWeight.normal),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true, // This ensures the sheet uses minimal necessary size
            isDismissible: true, // Allow dismissing the sheet by tapping outside

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            backgroundColor: AppColors.jCardBgColor,
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'disclainer'.tr(),
                  style: appstyle(12, AppColors.textDarkColor, FontWeight.normal),
                ),
              );
            },
          );
        },
        label: Text('disclainerButton'.tr()),
        icon: const Icon(Icons.info),
      ),
    );
  }
}
