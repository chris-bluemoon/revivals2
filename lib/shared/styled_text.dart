import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledBody extends StatelessWidget {
  const StyledBody(this.text, {this.color = Colors.black, this.weight = FontWeight.bold, super.key});

  final String text;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(text, style: GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.bodyMedium,
      color: color,
      fontWeight: weight,
      fontSize: width*0.03,
    ));
  }
}

class StyledBodyStrikeout extends StatelessWidget {
  const StyledBodyStrikeout(this.text, {this.color = Colors.black, this.weight = FontWeight.bold, super.key});

  final String text;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(text, style: GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.bodyMedium,
      decoration: TextDecoration.lineThrough,
      decorationColor: Colors.black, decorationThickness: 4.0,
      fontSize: width*0.03,
      color: color,
      fontWeight: weight,
    ));
  }
}

class StyledBodyCenter extends StatelessWidget {
  const StyledBodyCenter(this.text, {this.color = Colors.black, this.weight = FontWeight.bold, super.key});

  final String text;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      text, 
      style: GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        fontSize: width*0.03,
        color: color,
        fontWeight: weight,
      ),
      textAlign: TextAlign.center
    );
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(this.text, {this.color = Colors.black, this.weight = FontWeight.bold, super.key});

  final String text;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(text, style: GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.headlineMedium,
      fontSize: width*0.04,
      color: color,
      fontWeight: weight,
    ));
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, {this.color = Colors.black, this.weight = FontWeight.bold, super.key});

  final String text;
  final Color color;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(text, style: GoogleFonts.openSans(
      textStyle: Theme.of(context).textTheme.titleMedium,
      fontSize: width*0.05,
      color: color,
      fontWeight: weight,
    ));
  }
}

class StyledBodyPlayFair extends StatelessWidget {
  const StyledBodyPlayFair(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.playfair(
      textStyle: Theme.of(context).textTheme.bodyMedium,
    ));
  }
}

class StyledHeadingPlayFair extends StatelessWidget {
  const StyledHeadingPlayFair(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.playfair(
      textStyle: Theme.of(context).textTheme.headlineMedium
    ));
  }
}

class StyledTitlePlayFair extends StatelessWidget {
  const StyledTitlePlayFair(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.playfair(
      textStyle: Theme.of(context).textTheme.titleLarge
    ));
  }
}