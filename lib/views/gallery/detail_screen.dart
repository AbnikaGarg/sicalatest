import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.img, required this.text})
      : super(key: key);
  final String img;
  final String text;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
       appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: const Text("Gallery"),
      ),
        body: Center(
          child: Image.asset(
              widget.img,
              alignment: Alignment.center,
              //  height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
        ));
  }
}
