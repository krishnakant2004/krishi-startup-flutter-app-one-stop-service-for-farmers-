import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// Just for demo
const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

// End For demo

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xFF7B61FF);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFEFECFF),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whiteColor80 = Color(0xFFCCCCCC);
const Color whiteColor60 = Color(0xFF999999);
const Color whiteColor40 = Color(0xFF666666);
const Color whiteColor20 = Color(0xFF333333);
const Color whiteColor10 = Color(0xFF191919);
const Color whiteColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
const Color greyColor80 = Color(0xFFC6C4CF);
const Color greyColor60 = Color(0xFFD4D3DB);
const Color greyColor40 = Color(0xFFE3E1E7);
const Color greyColor20 = Color(0xFFF1F0F3);
const Color greyColor10 = Color(0xFFF8F8F9);
const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

const pasNotMatchErrorText = "passwords do not match";

List<String> carouselForPromotion=[
"https://cdn.pixabay.com/photo/2019/08/09/06/12/car-racing-4394450_640.jpg",
  "https://c4.wallpaperflare.com/wallpaper/193/556/883/car-neon-chevrolet-corvette-race-cars-hd-wallpaper-preview.jpg",
  "https://cdn.pixabay.com/photo/2022/11/29/08/54/race-car-7624025_1280.jpg",
  "https://png.pngtree.com/thumb_back/fh260/background/20230707/pngtree-3d-illustration-of-a-speeding-race-car-on-the-track-image_3772134.jpg",
  "https://t4.ftcdn.net/jpg/05/52/85/27/360_F_552852793_4IfEWbUyX4Ei38YBX6LtkNrMKk2tQof8.jpg"
];

//our krishi app

const kcontentColor = Color(0xffEEEEEE);
const kprimaryColor= Color(0xffff660e);
const kbackgroundColor=Color(0xffe9f5f8);
const MAIN_URL = 'http://192.168.137.244:3000';

const FAVORITE_PRODUCT_BOX = 'FAVORITE_PRODUCT_BOX';
const USER_INFO_BOX = 'USER_INFO_BOX';

const  PHONE_KEY = 'PHONE_KEY';
const  STREET_KEY = 'STREET_KEY';
const  CITY_KEY = 'CITY_KEY';
const  STATE_KEY = 'STATE_KEY';
const  POSTAL_CODE_KEY = 'POSTAL_CODE_KEY';
const  COUNTRY_KEY = 'COUNTRY_KEY';
