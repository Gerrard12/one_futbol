import 'package:flutter/material.dart';

class LiveMatchBox extends StatelessWidget {
  final String homeLogo, homeTitle, awayLogo, awayTitle;
  final int time, awayGoal, homeGoal;
  final Color color, textColor, numColor;
  final DecorationImage backgroundImage;
  const LiveMatchBox({
    super.key,
    required this.homeLogo,
    required this.homeTitle,
    required this.awayLogo,
    required this.awayTitle,
    required this.time,
    required this.awayGoal,
    required this.homeGoal,
    required this.color,
    required this.textColor,
    required this.backgroundImage,
    required this.numColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        image: backgroundImage,
      ),
      child: Column(
        children: [
          Text(
            'Copa Cerrito Verde',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'GRAN FINAL',
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    homeLogo,
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    homeTitle,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Casa',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "$time'",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "$homeGoal : ",
                          style: TextStyle(
                            fontSize: 36,
                            color: textColor,
                          ),
                        ),
                        TextSpan(
                          text: "$awayGoal",
                          style: TextStyle(
                            fontSize: 36,
                            color: numColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Image.asset(
                    awayLogo,
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    awayTitle,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Visita',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
