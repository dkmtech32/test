import 'package:flutter/material.dart';
class ImageBannerWidget extends StatefulWidget {
  final List<String> imageUrls; // List of image URLs
  final double height; // Height of the banner

  const ImageBannerWidget({
    Key? key,
    required this.imageUrls,
    this.height = 100.0,
  }) : super(key: key);

  @override
  State<ImageBannerWidget> createState() => _ImageBannerWidgetState();
}

class _ImageBannerWidgetState extends State<ImageBannerWidget> {
  int _currentIndex = 0; // Index of the currently displayed image
  bool _isLeftArrowHovered = false;
  bool _isRightArrowHovered = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.imageUrls[_currentIndex]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 10.0, // Adjust positioning as needed
          top: widget.height / 2 - 20.0, // Center the button vertically
          child: MouseRegion(
            onEnter: (_) => setState(() => _isLeftArrowHovered = true),
            onExit: (_) => setState(() => _isLeftArrowHovered = false),
            child: IconButton(
              icon: Icon(
                Icons.arrow_left_sharp,
                color: _isLeftArrowHovered
                    ? Color.fromARGB(255, 255, 0, 0).withOpacity(0.8)
                    : const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex =
                      (_currentIndex - 1 + widget.imageUrls.length) %
                          widget.imageUrls.length;
                });
              },
            ),
          ),
        ),
        Positioned(
          right: 10.0,
          top: widget.height / 2 - 20.0,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isRightArrowHovered = true),
            onExit: (_) => setState(() => _isRightArrowHovered = false),
            child: IconButton(
              icon: Icon(
                Icons.arrow_right_sharp,
                color: _isRightArrowHovered
                    ? Color.fromARGB(255, 255, 0, 0).withOpacity(0.8)
                    : Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 180.0, // Adjust positioning as needed
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                widget.imageUrls.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor:
                        _currentIndex == index ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
