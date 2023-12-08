import 'package:flutter/cupertino.dart';
import 'package:marquee/marquee.dart';

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
              text: text, style: TextStyle(fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: double.infinity);

        return Container(
          height: 20,
          child: textPainter.width > constraints.maxWidth
              ? Marquee(
                  text: text,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,startAfter: Duration(milliseconds: 100),
                  blankSpace: 20,
                  velocity: 10,
                  pauseAfterRound: Duration(seconds: 1),
                  showFadingOnlyWhenScrolling: true,
                  fadingEdgeStartFraction: 0.1,
                  fadingEdgeEndFraction: 0.5,
                  numberOfRounds: 1,
                  accelerationDuration: Duration(milliseconds: 600),
                  accelerationCurve: Curves.easeIn,
                  decelerationDuration: Duration(milliseconds: 600),
                  decelerationCurve: Curves.easeOut,
                )
              : Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        );
      },
    );
  }
}
