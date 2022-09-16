import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class full_screen_image extends StatelessWidget {
  final ImageProvider ? imageProvider;
  const full_screen_image({Key? key, this.imageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        initialScale: PhotoViewComputedScale.contained,
        imageProvider: imageProvider,
      ),
    );
  }
}
