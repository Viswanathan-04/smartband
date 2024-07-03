import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarProfileWidget extends StatefulWidget implements PreferredSizeWidget{
  const AppBarProfileWidget({super.key});

  @override
  State<AppBarProfileWidget> createState() => _AppBarProfileWidgetState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarProfileWidgetState extends State<AppBarProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Icon(Icons.menu),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.17),
              child: Image.network(
                "https://placements.lk/storage/Company/LogoImages/1637824455.jpg",
                width: 100,
              ),
            ),
            const Icon(
              Icons.account_circle_outlined
            )
          ],
        )
    );
  }
}