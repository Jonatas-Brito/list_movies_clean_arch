import 'package:flutter/material.dart';

class TileComponent extends StatelessWidget {
  final VoidCallback? onTap;
  const TileComponent({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey[50],
          thickness: 0.3,
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline,
            color: Colors.grey[50],
          ),
          title: Text(
            'Mais informações',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.grey[50],
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[50],
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
