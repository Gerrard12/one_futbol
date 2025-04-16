import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatosCarta extends StatelessWidget {
  const DatosCarta({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.all(0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: 100,
            height: screenHeight * 0.25,
            padding: EdgeInsets.only(left: 85),
            child: Stack(
              children: [
                Image.asset(
                  'assets/image/carta_1.png',
                  scale: 1,
                  alignment: Alignment.center,
                ),
                Container(
                  width: 100,
                  height: screenHeight * 0.25,
                  padding: EdgeInsets.only(left: 20, top: 35),
                  child: AutoSizeText('58',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 50),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 100,
                  height: screenHeight * 0.25,
                  padding: EdgeInsets.only(left: 25, top: 70),
                  child: AutoSizeText('CAM',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 50),
                      textAlign: TextAlign.center),
                ),
                Container(
                    padding: EdgeInsets.only(left: 35, top: 35),
                    child: Image.asset('assets/image/peru.png',
                        width: screenWidth * 0.12, height: screenHeight * 0.29,)),
                Container(
                    padding: EdgeInsets.only(left: 35, top: 50),
                    child: Image.asset('assets/image/escudo.png',
                        width: screenWidth * 0.12, height: screenHeight * 0.38,)),
                Container(
                  height: screenHeight * 0.28,
                    padding: EdgeInsets.only(left: 100, top: 25),
                    child: Image.asset(
                      'assets/image/douglas.png',
                      scale: 0.84,
                    )),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(right: 80, top: 60),
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: AutoSizeText(
                      'PAMBISITO', //solo 20 caracteres
                      style: GoogleFonts.alumniSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  children: [],
                ),

                //PRIMERA COLUMNA
                Container(
                  width: screenWidth * 1,
                  padding: EdgeInsets.only(left: 5, top: 260),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 100,
                  padding: EdgeInsets.only(left: 5, top: 300),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 100,
                  padding: EdgeInsets.only(left: 5, top: 340),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),

                //SEGUNDA COLUMNA
                Container(
                  width: 190,
                  padding: EdgeInsets.only(left: 35, top: 260),
                  child: AutoSizeText('RIT',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.only(left: 35, top: 300),
                  child: AutoSizeText('TIR',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.only(left: 35, top: 340),
                  child: AutoSizeText('PAS',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),

                //TERCERA COLUMNA
                Container(
                  width: 290,
                  padding: EdgeInsets.only(left: 60, top: 260),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 290,
                  padding: EdgeInsets.only(left: 60, top: 300),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 290,
                  padding: EdgeInsets.only(left: 60, top: 340),
                  child: AutoSizeText('99',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),

                //CUARTA COLUMNA
                Container(
                  width: 400,
                  padding: EdgeInsets.only(left: 100, top: 260),
                  child: AutoSizeText('REG',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.only(left: 100, top: 300),
                  child: AutoSizeText('DEF',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.only(left: 100, top: 340),
                  child: AutoSizeText('FIS',
                      style: GoogleFonts.alumniSans(
                          fontWeight: FontWeight.w500, fontSize: 45),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ));
  }
}
