// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Package imports:
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

Logger logger = Logger();
var uid = const Uuid();
//Text
const kDigiCollection = 'digiKhata';
const kAppName = 'PayQr';
const kCashInOutCollection = 'cashInCashOut';
const kCashRecordsField = 'cashRecords';
const kChatBotUrl = 'http://192.168.43.158:5000/';
const kError = "Something went wrong";
const kScanDescText =
    'Scan products you want to buy at your favorite store and pay by your phone & enjoy happy, friendly Shopping!';

const kPlaceHolderImg = "assets/images/placeholder.png";
const kDefaultImgUrl =
    'https://firebasestorage.googleapis.com/v0/b/pay-qr-b5905.appspot.com/o/placeholder.png?alt=media&token=6b5c9aab-83a8-48b9-8149-db666bfed60d';

//? Colors for App
// const kPrimaryColor = Color(0xFFEEEEEE);
// const kTextFieldColor = Color(0xFFEFB7B7);
// const kLightBackColor = Color(0xFFBD4B4B);
// const kTealColor = Color(0xFF01D2AF);
// const kPrimaryDarkColor = Color(0xFF000000);
// const kBtnColor = Color(0xFFEFB7B7);
// const kScanBackColor = Color(0xFFEEEEEE);
const kPrimaryColor = Color(0xFFFF7B66);
const kTextFieldColor = Color.fromARGB(255, 252, 162, 148);
const kLightBackColor = Color(0xFFFF7B66);
const kTealColor = Color(0xFF01D2AF);
const kPrimaryDarkColor = Color(0xFFFF7B66);
const kBtnColor = Color(0xFFFF7B66);
const kScanBackColor = Color(0xFFEEEEEE);
const kAppBarPrefSize = Size(double.infinity, 56.0);

var kWidth = Get.size.width;
var kHeight = Get.size.height;
// enum kUsers { merchant, user }

//? User Data Names
// const kAdminData = 'adminData';
const kMerchantDb = 'retailerData';
// const kProductDb = 'productData';
const kUserDb = 'userData';
const kProfileCollection = 'profile';
const kProductCollection = 'products';
const kUserIdDoc = 'uid';

const kUserCredSharedPrefKey = 'userCredential';
const kUserTypeSharedPrefKey = 'userType';

const kOnbardOneTxt = """
Wir sind gegen Rassimus, Seximus, Ableismus,
Antisemitismus, Queer- und Transfeindlichkeit.
Mit der Kuseng-App möchten wir, vorallem in der
Clubszene, das Zusammenleben verbessern und
jegliche rassistischen Vorfälle vermeiden.""";

const kOnbardTwoTxt = """
In der Clubszene kommt es oft zu unfairen
Vorfällen. Wir möchten diese Vorfälle in der
Zukunft, mit deiner Hilfe, vermeiden.
Mit der Kuseng-App kannst du den jeweiligen
Club auswählen und deinen Vorfall melden.""";

const kRegisterText = """
Fotografiere nun deinen Personalausweis. Verdecke
anschließend alle Informationen, die nicht benötigt
werden.""";
const kMigrationText = """
Migrationsgeschichte innerhalb der letzten2 Generationn in deiner Familie?""";

const kOnBoardBtnText = 'WEITER';
const kDisabilityText = 'Körperl. Einschränkungen';
const kPassWordForgotTxt = 'Passwort vergessen?';
const kNameText = 'Vollständiger Name (nicht öffentlich)';
const kUserNameText = 'Benutzername (öffentlich)';
const kMotherLngGerText = """Ist deine Muttersprache Deutsch?""";
const kBlackIdentifyText = """Identifizierst du dich als / bist du Schwarz?""";
const kPolicyText =
    """Mit dem Klicken auf Weiter aktzeptierst du unsere AGB’s und Datenschutz erklärung.""";
const kAnotherMotherLngGerText =
    """Hast du eine weitere Mutter-sprache neben Deutsch?""";

//? TEXT used in app

const kEntryText = """Bitte gebe uns weitere Informationen zu deinem Fall""";
const kEntryQuestionText = """Bist du reingekommen?""";

const kSelfieText = """Nimm ein Selfie auf""";
const kSelfieBtnText = """Selfie aufnehmen""";
const kIncidentReportText =
    """Schilder uns bitte, was genau passiert ist. Diese Daten werden nicht öffentlich gezeigt!""";
const kProvideInfoText =
    """Bitte gebe uns weitere Informationen zu deinem Fall.""";
const kHomeText =
    """Wähle den jeweiligen Club aus, um einen Vorfall zu melden""";
const kSelfieInfoText =
    """Achte auf eine gute Belichtung, damit wir das Selfie auswerten können.""";
const kSurveyEndText = """
Wir danken Dir dass du an unserer Umfrage teilgenommen hast und dazu für einander zu gestalten. """;
const kSurveyEndTwoText =
    """Wir danken Dir dass du an unserer Umfrage teilgenommen hast und dazu für einander zugestalten. Wir wünschen dir weiterhin viel Glück! """;
const kRegDesTxt = """
Allgemeine Fragen zur Einordnung deines Avatrs,
""";
const kProfileTxt = """
Hier kannst du Einstellungen zu deinem Account festlegen.
""";
const kRegScreen2Txt = """
Fotografiere nun deinen Personalausweis. Verdecke anschließend alle Informationen, die nicht benötigt werden.
""";
const kRegMiniDescText = """
Diese Daten werden nicht veröffentlicht. Wir nutzen Sie nur für unsere anonymisierte Statistik""";

const kProfileBtnTextList = [
  "Mein Namen ändern",
  "AGB’s & Datenschutz",
  "Standort Einstellungen",
  "Deine Daten",
  "Wer wir sind"
];

//* text style checkbox
final kCheckBoxTextStyle =
    Get.textTheme.headline6?.copyWith(fontSize: Get.size.shortestSide * 0.0358);
final kRegScreenPadding = EdgeInsets.only(left: Get.size.width * 0.1);
