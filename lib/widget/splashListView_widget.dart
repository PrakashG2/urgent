import 'package:flutter/material.dart';

class SplashListViewWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List images;

  const SplashListViewWidget(
      {Key? key, required this.scrollController, required this.images})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Container(
              width: 80,
              margin: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
