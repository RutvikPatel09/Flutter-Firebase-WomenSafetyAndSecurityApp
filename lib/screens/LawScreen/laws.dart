import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Laws extends StatelessWidget {
  const Laws({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF80C038),
        title: Text(
          'Laws Related to Women',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "The Government has also taken a number of initiatives"
                "\nfor safety of women and girls, which are given below:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "A. The Government has set up Nirbhaya Fund for projects"
                "\nfor safety and  security  of  women, for  which  Ministry"
                "of  Women and Child Development is the nodal authority for"
                "appraising/ recommending the proposals / schemes to be"
                "funded under Nirbhaya Fund.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "B. In order to facilitate States/UTs, MHA has launched"
                "an online analytic tool for police on 19th February 2019"
                "called “Investigation Tracking System for Sexual Offence"
                "to monitor and track time-bound investigation in sexual"
                "assault cases in accordance with Criminal Law (Amendment)"
                "Act 2018.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "C. MHA has launched the “National Database on Sexual"
                "ffenders” (NDSO) on 20th September 2018 to facilitate"
                "investigation and tracking of sexual offenders across"
                "the country by law enforcement agencies. NDSO has data"
                "of over 5 lakh sexual offenders.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "D. Emergency Response Support System, which provides"
                "a single emergency number (112) based computer"
                "aided dispatch of field resources to the location"
                "of distress has been operationalized in 20 States/"
                "UTs in 2018-19.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "E. Using technology to aid smart policing and"
                "safety management, Safe City Projects have been"
                "sanctioned in phase I in 8 cities"
                "(Ahmedabad, Bengaluru, Chennai, Delhi, Hyderabad,"
                "Kolkata, Lucknow and Mumbai).",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "F. MHA has issued advisories to all State"
                "Governments/UTs, advising them to ensure"
                "thorough investigation, conducting of medical"
                "examination of rape victims without delay and"
                "for increasing gender sensitivity in Police."
                "These advisories are available at www.mha.gov.in.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                "G. Further, Government of India conducts"
                "awareness generation programmes and publicity"
                "campaigns on various laws relating to women"
                "and their rights through workshops, cultural"
                "programmes, seminars, training programmes,"
                "advertisements in print and electronic media etc.",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
