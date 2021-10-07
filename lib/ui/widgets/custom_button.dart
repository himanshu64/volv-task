import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;
  const CustomButton({Key? key, required this.title, required this.onpressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white, fontSize: 14),
        ),
        // color: Theme.of(context).primaryColor,
        // splashColor: Colors.green,
      ),
    );
  }
}
