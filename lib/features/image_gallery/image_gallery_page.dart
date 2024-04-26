import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery/api/isar/model/images.dart';
import 'package:image_gallery/features/login/login_screen_connector.dart';
import 'package:image_gallery/features/single_image/single_image_connector.dart';
import 'package:image_gallery/utilities/string_constants.dart';

class ImageGalleryPage extends StatefulWidget {
  const ImageGalleryPage({
    required this.onLoggedOut,
    required this.images,
    super.key,
  });

  final Future<void> Function() onLoggedOut;
  final Images images;

  @override
  State<ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  late bool selectedTab1;

  @override
  void initState() {
    selectedTab1 = true;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabATitle = '$tabA ${widget.images.tabA.length} Products';
    final tabBTitle = '$tabB ${widget.images.tabB.length} Products';

    final tabAList = widget.images.tabA
        .map((imagePath) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: InkWell(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  context.goNamed(
                    SingleImageConnector.routeName,
                    extra: imagePath,
                  );
                },
              ),
            ))
        .toList();
    final tabBList = widget.images.tabB
        .map((imagePath) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: InkWell(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  context.goNamed(
                    SingleImageConnector.routeName,
                    extra: imagePath,
                  );
                },
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey,

      /// TODO: make this a reusable widget for future use
      bottomNavigationBar: Container(
        height: 100.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: InkWell(
                child: const Text(tabA),
                onTap: () => setState(() => selectedTab1 = true),
              ),
            ),
            Flexible(
              child: InkWell(
                child: const Text(tabB),
                onTap: () => setState(() => selectedTab1 = false),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.goNamed(LoginScreenConnector.routeName);
            widget.onLoggedOut();
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        title: Text(selectedTab1 ? tabATitle : tabBTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider(
              items: widget.images.carousel
                  .map((imagePath) => GestureDetector(
                        onLongPress: () => context.goNamed(
                          SingleImageConnector.routeName,
                          extra: imagePath,
                        ),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1.0,
              ),
            ),
            ListView(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: selectedTab1 ? tabAList : tabBList,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(LoginScreenConnector.routeName);
                  widget.onLoggedOut();
                },
                child: const Text('logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
