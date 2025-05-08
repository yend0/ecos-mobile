import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:ecos/generated/generated.dart';

class CardPoints extends StatelessWidget {
  const CardPoints({
    super.key,
    required this.theme,
    required this.points,
  });

  final ThemeData theme;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 128,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 7, 54, 23),
              Color.fromARGB(255, 2, 36, 14),
            ],
            stops: [0, 1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.title_card.tr(),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: theme.primaryColor,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    points.toString(),
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4),
                  Baseline(
                    baseline: 52,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      LocaleKeys.points.tr(),
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
