

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getCategoryIcon(String title) {
  if (title.contains('صباح')) {
    return FontAwesomeIcons.sun;
  } else if (title.contains('مساء')) {
    return FontAwesomeIcons.moon;
  } else if (title.contains('نوم') || title.contains('استيقاظ')) {
    return FontAwesomeIcons.bed;
  } else if (title.contains('صلاة') || title.contains('أذان')) {
    return FontAwesomeIcons.personPraying;
  } else if (title.contains('مسجد')) {
    return FontAwesomeIcons.mosque;
  } else if (title.contains('وضوء')) {
    return FontAwesomeIcons.droplet;
  } else if (title.contains('طعام') || title.contains('أكل')) {
    return FontAwesomeIcons.utensils;
  } else if (title.contains('سفر')) {
    return FontAwesomeIcons.plane;
  } else if (title.contains('حج') || title.contains('عمرة')) {
    return FontAwesomeIcons.kaaba;
  } else if (title.contains('منزل') || title.contains('بيت')) {
    return FontAwesomeIcons.house;
  }

  return FontAwesomeIcons.bookOpen;
}