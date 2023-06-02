// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final bool? isOnline;
  final bool isBox;

  const ProfileBox({
    Key? key,
    required this.size,
    this.imageUrl,
    this.isOnline,
    this.isBox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: isBox ? BoxShape.rectangle : BoxShape.circle,
        color: Colors.white,
        borderRadius: isBox ? BorderRadius.circular(12) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl ?? 'https://i.imgur.com/BoN9kdC.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
