import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class OtherChat extends StatelessWidget {
  const OtherChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional(-1, 1),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 9.89.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSenderName(),
              _buildMessageBubble(context),
              _buildMessageTimestamp(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _buildProfileImage(context),
        ),
      ],
    );
  }

  Widget _buildSenderName() {
    return Padding(
      padding: EdgeInsets.only(left: 2.64.w, bottom: 4),
      child: Text(
        'DQ 1078',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // TODO have a better context management
  Widget _buildMessageBubble(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 11, 9),
          child: Text(
            'No problem! To hide the sidebar in Figma, you can follow these steps:',
            textAlign: TextAlign.start,
            textWidthBasis: TextWidthBasis.longestLine,
            style: GoogleFonts.inter(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageTimestamp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 3, 13, 2),
      child: Text(
        'Sunday, 4.01 AM',
        textAlign: TextAlign.start,
        maxLines: 1,
        style: GoogleFonts.inter(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildProfileImage(context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Container(
          width: 41,
          height: 41,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            imageUrl: 'https://picsum.photos/seed/323/600',
            fit: BoxFit.cover,
          ),
          // child: Image.network(
          //   'https://picsum.photos/seed/377/600',
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }
}
