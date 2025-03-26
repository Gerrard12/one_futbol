import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DatosCarta extends StatelessWidget {
  const DatosCarta({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 70, horizontal: 95),
      child: Stack(
        children: [
          Image.asset('assets/image/carta_3.png'),
          Container(
            width: 154,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 1),
            child: AutoSizeText(
              '58',
              style: GoogleFonts.alumniSans(
                  fontWeight: FontWeight.w500, fontSize: 30),
                  textAlign: TextAlign.center
            ),
          ),
          Container(
            width: 154,
            padding: EdgeInsets.symmetric(vertical: 55, horizontal: 1),
            child: AutoSizeText(
              'GHF',
              style: GoogleFonts.alumniSans(
                  fontWeight: FontWeight.w500, fontSize: 30),
                  textAlign: TextAlign.center
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 57),
              child: Image.asset('assets/image/peru.png',width: 40,height: 210)),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 57),
              child: Image.asset('assets/image/escudo.png',width: 40,height: 300)),
          Container(
              padding: EdgeInsets.fromLTRB(120, 40, 30, 0),
              child: Image.asset('assets/image/pepe.png')),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 178),
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: AutoSizeText(
                'EL DESHUESADO FERNAND', //solo 21 caracteres
                style: GoogleFonts.alumniSans(
                    fontWeight: FontWeight.w500, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 225, horizontal: 25)),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 252, horizontal: 25),
              ),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 280, horizontal: 25),
              ),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 225, horizontal: 73),
              ),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 252, horizontal: 73),
              ),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 280, horizontal: 73),
              ),
              AutoSizeText('99',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 225, horizontal: 46),
              ),
              AutoSizeText('RIT',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 252, horizontal: 46),
              ),
              AutoSizeText('TIR',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 280, horizontal: 46),
              ),
              AutoSizeText('PAS',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 225, horizontal: 95),
              ),
              AutoSizeText('REG',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 252, horizontal: 95),
              ),
              AutoSizeText('DEF',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 280, horizontal: 95),
              ),
              AutoSizeText('FIS',
                  style: GoogleFonts.alumniSans(
                      fontWeight: FontWeight.w500, fontSize: 25)),
            ],
          ),
        ],
      ),
    );
  }
}
