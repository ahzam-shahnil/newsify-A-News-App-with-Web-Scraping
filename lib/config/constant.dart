import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kBaseUrl = 'https://newsapi.org/';
const kPlayStoreLink =
    'https://play.google.com/store/apps/details?id=com.proapps.newsify';
const kAppName = 'Newsify';
const kGitHubUrl = 'https://github.com/ahzam-shahnil/ahzam_shahnil';
const kInstaUrl = 'https://www.instagram.com/ahzam.shahnil/';
const kLogoImgAddress = 'assets/images/logo.svg';
//? Orientation
var kAllOrientation = SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.landscapeRight,
  DeviceOrientation.landscapeLeft
]);
var kPortraitOnly = SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
]);

//? News Category
const List<String> kNewsApiCategories = [
  'General',
  'Business',
  'Entertainment',
  'Science',
  'Health',
  'Sports',
  'Technology'
];

const kGeneralCategory = 'general';
const kEntertainCategory = 'entertainment';
const kScienceCategory = 'science';
const kBusinessCategory = 'business';
const kHealthCategory = 'health';
const kTechnologyCategory = 'technology';
const kSportCategory = 'sports';

//? Linear gradient
const kShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
