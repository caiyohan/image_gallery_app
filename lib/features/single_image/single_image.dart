import 'package:flutter/material.dart';
import 'package:image_gallery/utilities/string_constants.dart';

class SingleImage extends StatefulWidget {
  const SingleImage({
    required this.isTabA,
    required this.isInCarousel,
    required this.onTransferTab,
    required this.onCheckCarousel,
    required this.imagePath,
    super.key,
  });

  final Future<bool> Function(String imagePath) isTabA;
  final Future<bool> Function(String imagePath) isInCarousel;
  final Future<void> Function(String imagePath) onTransferTab;
  final Future<void> Function(String imagePath, bool isChecked) onCheckCarousel;
  final String imagePath;

  @override
  State<SingleImage> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImage> {
  late List<bool> isImageTabA;
  late bool isCarousel;

  @override
  void initState() {
    super.initState();
    isImageTabA = [true, false];
    isCarousel = false;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isTabA = await widget.isTabA(widget.imagePath);
      isImageTabA = [isTabA, !isTabA];
      isCarousel = await widget.isInCarousel(widget.imagePath);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            // context.goNamed(ImageGalleryConnector.routeName);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text('Single Image Gallery'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                widget.imagePath,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ToggleButtons(
                  onPressed: (int index) {
                    Future.delayed(const Duration(seconds: 0), () async {
                      widget.onTransferTab(widget.imagePath);
                    });
                    setState(() {
                      final firstIndex = index == 0;
                      if (firstIndex) {
                        isImageTabA[0] = true;
                        isImageTabA[1] = false;
                      } else {
                        isImageTabA[0] = false;
                        isImageTabA[1] = true;
                      }
                    });
                  },
                  borderColor: Colors.black,
                  fillColor: Colors.blueAccent,
                  borderWidth: 2,
                  selectedBorderColor: Colors.black,
                  selectedColor: Colors.white,
                  isSelected: isImageTabA,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        tabA,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        tabB,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isCarousel,
                      onChanged: (value) => setState(() {
                        if (value == null) return;
                        isCarousel = value;
                        widget.onCheckCarousel(widget.imagePath, isCarousel);
                      }),
                    ),
                    const Text(
                      'Include in Carousel',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
