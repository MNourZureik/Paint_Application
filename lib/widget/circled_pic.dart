import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final double width, height;
  final String? imageUrl;

  const ProfilePic({required this.width, required this.height, this.imageUrl})
      : super();

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Center(
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: imageUrl != null
              ? Container(
                  width: width,
                  height: height,
                  child: CachedNetworkImage(
                    imageUrl: '$imageUrl',
                    imageBuilder: (context, imageProvider) =>
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: CachedNetworkImageProvider(
                        '$imageUrl',
                      ),
                    ),
                    errorWidget: (context, url, error) =>Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: .5,
                            color: Colors.black,
                          )),
                      child: Icon(
                        Icons.person,
                        size: width * .5,
                        color: Colors.black,
                      ),
                    ),
                    placeholder: (context, url)=>const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: .5,
                        color: Colors.black,
                      )),
                  child: Icon(
                    Icons.person,
                    size: width * .5,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
