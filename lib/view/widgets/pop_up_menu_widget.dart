import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';

class AppBarPopUpMenu extends StatelessWidget {
  final void Function() onTap;
  const AppBarPopUpMenu({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            height: 15,
            onTap: onTap,
            child: const Text("Clear All"),
          )
        ];
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
