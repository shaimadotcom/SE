import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../utill/images.dart';

//This widget will return curicular or rectengular profile image or default image on error with cached network image for general usage
class CustomUserProfileImageWidget extends StatelessWidget {
  final String profileUrl;
  final Color? color;
  final Icon? icon;
  final BorderRadius? radius;
  const CustomUserProfileImageWidget(
      {super.key, required this.profileUrl, this.color,this.icon, this.radius});

  _imageOrDefaultProfileImage() {
    return (profileUrl!="")?
    CachedNetworkImage(
       fit: BoxFit.cover,
       imageUrl: profileUrl,):
        (icon!=null)?
            icon
            :
     SvgPicture.asset(
      Images.user,
      color:
      color,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return radius != null
        ? ClipRRect(
            borderRadius: radius!,
            child: _imageOrDefaultProfileImage(),
          )
        : ClipOval(
            child: _imageOrDefaultProfileImage(),
          );
  }
}
