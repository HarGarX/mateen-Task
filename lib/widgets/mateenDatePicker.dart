import 'package:flutter/material.dart';
import 'package:mateen/predef/colorPalette.dart';

class MateenDatePicker extends StatefulWidget {
  @override
  _MateenDatePickerState createState() => _MateenDatePickerState();
}

class _MateenDatePickerState extends State<MateenDatePicker> {

  DateTime date = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> pickDate(context),
      child: Text('${date.day}/${date.month}/${date.year}',
        style: TextStyle(
          color: ColorPalette().defaultColor,
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if(newDate == null) return;

    setState(() => date = newDate);

  }
}