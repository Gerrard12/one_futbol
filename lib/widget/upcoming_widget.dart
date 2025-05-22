import 'package:flutter/material.dart';

class UpComingMatch extends StatelessWidget {
  final String homeLogo, homeTitle, awayLogo, awayTitle, date, time;
  final bool isFavorite;
  final Color textColor;
  const UpComingMatch({
    super.key,
    required this.homeLogo,
    required this.homeTitle,
    required this.awayLogo,
    required this.awayTitle,
    required this.date,
    required this.time,
    required this.isFavorite,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(0xFF1D1D1D),
          ),
          child: Row(
            children: [
              Text(
                homeTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Image.asset(
                    homeLogo,
                    height: 45,
                    width: 45,
                  ),
                  Text(
                    'Casa',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Image.asset(
                    awayLogo,
                    height: 45,
                    width: 45,
                  ),
                  Text(
                    'Visita',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Text(
                awayTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
