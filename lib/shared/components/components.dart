import 'package:flutter/material.dart';

void navigatTo(context,route)
{
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>route ));
}

void navigatToAndFinish(context,route)
{
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=>route ),
          (Route<dynamic> route)=>false
  );
}


Widget defaultTextFormField(
{
  TextEditingController? controller,
  String? Function (String?)? validate,
  Icon? preIcon,
  Widget? sufIcon,
  String? label,
  double border=0,
  bool secure=false,
  Function(String?)? onChange,
  Function(String?)? onSubmit,
  TextInputType? type,
  bool enabled =true,
}
    )

{
  return TextFormField(
    enabled: enabled,
    controller: controller,
    validator: validate,
    obscureText:secure ,
    onChanged: onChange,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      label: Text(
        '$label'
      ),
      prefixIcon: preIcon,
      suffixIcon: sufIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(border),
      ),
    ),
  );

}


Widget defaultButton(
{
  VoidCallback? onPressed,
  String? text,
  bool upper=false,
  Color? backgroundColor,
  Color colorOfText=Colors.white,
  double? width
}
) => Container(
  width: width,
  color: backgroundColor,
  child:   TextButton(
      onPressed: onPressed,
      child: Text(
        '${upper? text!.toUpperCase(): text}',
        style: TextStyle(
          color: colorOfText,
        ),
      )   ,
  ),
);