import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:take_away/shared/styles/icons.dart';

void showToast({required String msg, required state}) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0);
enum ToastStates { SUCCESS, WARNING, ERROR }

Color chooseColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget defaultButton(
        {required String label,
        required Function onPressed,
        required double fontSize,
        required context,
         double? width,
          IconData? icon,
        Color? color}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MaterialButton(
        minWidth: 0,
        padding: EdgeInsets.zero,
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style:  TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,
            ),
             if(icon != null)
             Padding(
               padding: const EdgeInsetsDirectional.only(start: 10),
               child: Icon(icon,color: Colors.white),
             )
          ],
        ),
      ),
    );

Widget defaultToggleButton({
  required context,
  required List<Widget> constToggleChildren,
  required List<bool> isSelectedList,
  required void Function(int index) onTap,

})=> Padding(
  padding: const EdgeInsetsDirectional.only(bottom: 10),
  child: Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: ToggleButtons(
      renderBorder: false,
      children: constToggleChildren,
      isSelected: isSelectedList,
      onPressed: onTap,
      borderRadius: BorderRadius.circular(20),
      splashColor: Theme.of(context).primaryColor.withOpacity(.2),
      color: Colors.black,
      fillColor: Theme.of(context).primaryColor,
      selectedColor: Colors.white,

    ),
  ),
);

Widget defaultFormField({
  required context,
  required TextEditingController controller,
  required String label,
  IconData? prefixIcon,
  String? hintText,
  TextStyle? labelStyle,
  TextStyle? hintStyle,
  Color?  outLineColor,
  Color? fillColor,
  Color? focusColor,
  Color? hoverColor,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  FormFieldValidator<String>? validate,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onSubmitted,
  required TextInputType keyboard,
  bool isPassword = false,
  bool noInput = false,
}) =>
    TextFormField(
      style: TextStyle(color:Theme.of(context).primaryColor),
      cursorColor: outLineColor,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      readOnly: noInput,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.5)),
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        labelStyle: labelStyle??TextStyle(color:Theme.of(context).primaryColor ),
        prefixStyle: TextStyle(color:Theme.of(context).primaryColor ),
        prefixIcon: Icon(prefixIcon,color: Theme.of(context).primaryColor,),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon,color: Theme.of(context).primaryColor,),
          onPressed: suffixPressed,
        ),
        hintText: hintText,
        hintStyle: hintStyle??TextStyle(color:Theme.of(context).primaryColor.withOpacity(.5), ),
      ),
      keyboardType: keyboard,
      obscureText: isPassword,
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(title!),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2)),
      actions: actions,
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context, MaterialPageRoute(builder: (BuildContext context) => widget));

void navigateAndFinishTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (BuildContext context) => widget),);

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
