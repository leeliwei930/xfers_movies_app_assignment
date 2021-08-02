import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';
class ReadableField extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueTextStyle;

  ReadableField({this.label = "", this.value = "", this.valueTextStyle});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(), style: kReadableFieldLabelTextStyle.copyWith(color: Theme.of(context).primaryColor),),
          SizedBox(height: 5,),
          Text(value, textAlign: TextAlign.justify, style: this.valueTextStyle ?? Theme.of(context).textTheme.bodyText2,),
        ],
      ),
    );
  }
}
