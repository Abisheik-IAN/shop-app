import 'package:flutter/material.dart';


class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen({Key? key}) : super(key: key);

  @override
  State<ShopMainScreen> createState() => _ShopMainScreenState();
}

class _ShopMainScreenState extends State<ShopMainScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ShopHomeScreen"),),
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
