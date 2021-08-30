import 'package:flutter/services.dart';


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
const kGeoNewsCategory = [
  'Latest News',
  'Business',
  'Sports',
  'Entertainment',
  'Health',
  'Sci-Tech',
  'World',
  // 'Amazing'
];
const kGeoPath = [
  'latest-news',
  'category/business',
  'category/sports',
  'category/entertainment',
  'category/health',
  'category/sci-tech',
  'category/world',
  // 'category/amazing'
];
