
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchAppBar(),
          SizedBox(height: 5.0),
          ImageBannerWidget(
            imageUrls: myImageUrls,
            height: 130.0,
          ),
          SizedBox(height: 5.0),
          ListView(
            shrinkWrap: true,
            children: [
              PostWidget(
                name: 'LoneRanger',
                profileImageUrl:
                    'https://plus.unsplash.com/premium_photo-1705091981480-4e259fa4d740?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMnx8fGVufDB8fHx8fA%3D%3D',
                postImageUrl:
                    'https://images.unsplash.com/photo-1708607728910-b00e0c1be0af?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2OHx8fGVufDB8fHx8fA%3D%3D',
                description:
                    'Pariatur veniam minim tempor consequat aliquip aliquip id aliqua eiusmod eiusmod officia..',
                dateTime: DateTime.now(),
              ),
              SizedBox(height: 10.0),
              PostWidget2(
                  name: "Alex Thompson",
                  profileImageUrl:
                      "https://randomuser.me/api/portraits/men/63.jpg",
                  postImageUrl:
                      "https://images.unsplash.com/photo-1503220317375-aaad61436b1b",
                  description: "Finally got a new PR on the bench press!",
                  dateTime: DateTime.now().subtract(const Duration(days: 1)),
                  numPeople: 1,
                  location: "Gold's Gym",
                  sportType: "Weightlifting")
              // Add more PostWidgets here if needed
            ],
          )
        ],
      ),
    );
  }
}

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Space between elements
        children: [
          Flexible(
            flex: 2,
            child: Image.asset(
              './assets/images/logo.png',
            ),
          ),
          const Flexible(
            flex: 4, // Expand to take up available space
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none, // Remove default border
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

List<String> myImageUrls = [
  'https://plus.unsplash.com/premium_photo-1681582960531-7b5de57fb276?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1707327956851-30a531b70cda?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwyMXx8fGVufDB8fHx8fA%3D%3D',
  'https://plus.unsplash.com/premium_photo-1686278851694-d1ab44635d03?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8fA%3D%3D',
];

class PostWidget extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final String postImageUrl;
  final String description;
  final DateTime dateTime;

  const PostWidget({
    Key? key,
    required this.name,
    required this.profileImageUrl,
    required this.postImageUrl,
    required this.description,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Color.fromARGB(255, 220, 242, 241),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(formatDate(dateTime)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(description),
          const SizedBox(height: 10.0),
          // Added image section
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              postImageUrl, // Use separate URL for the post image
              fit: BoxFit.cover,
              height: 100.0,
              width: double.infinity, // Adjust image height as needed
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align icons at opposite ends
            children: [
              Row(
                children: [
                  // Like icon
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () =>
                        print('Like button pressed'), // Example action
                  ),
                  Text('Like'),
                ],
              ),
              Row(
                children: [
                  // Comment icon
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () =>
                        print('Comment button pressed'), // Example action
                  ),
                  Text('Comment'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostWidget2 extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final String postImageUrl;
  final String description;
  final DateTime dateTime;
  final int numPeople;
  final String location;
  final String sportType;

  const PostWidget2({
    Key? key,
    required this.name,
    required this.profileImageUrl,
    required this.postImageUrl,
    required this.description,
    required this.dateTime,
    required this.numPeople,
    required this.location,
    required this.sportType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(formatDate(dateTime)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(description),
          const SizedBox(height: 10.0),
          Row(
            children: [
              // ClipRRect for image and border
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  postImageUrl,
                  fit: BoxFit.cover,
                  height: 100.0,
                ),
              ),
              const SizedBox(width: 10.0),
              // Details column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // Row for details icons and text
                      children: [
                        // People icon and text
                        Row(
                          children: [
                            Icon(Icons.group, color: Colors.black, size: 16.0),
                            Text(numPeople.toString(),
                                style: const TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        const SizedBox(width: 5.0),
                        // Location icon and text
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.black, size: 16.0),
                            Text(location,
                                style: const TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        const SizedBox(width: 5.0),
                      ],
                    ),
                    const SizedBox(height: 5.0), // Add spacing between rows
                    Row(
                      // New row for additional details
                      children: [
                        Icon(Icons.sports_basketball,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            size: 16.0), // Adjust icon based on sport type
                        Text(sportType,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 12.0)),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Icon(Icons.access_time,
                        color: const Color.fromARGB(255, 0, 0, 0), size: 16.0),
                    Text(formatDate(dateTime),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12.0)),
                    const SizedBox(width: 5.0),
                  ],
                  
                ),
              ),
            ],
          ),
           Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align icons at opposite ends
            children: [
              Row(
                children: [
                  // Like icon
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () =>
                        print('Like button pressed'), // Example action
                  ),
                  Text('Like'),
                ],
              ),
              Row(
                children: [
                  // Comment icon
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () =>
                        print('Comment button pressed'), // Example action
                  ),
                  Text('Comment'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime dateTime) {
  // Implement your desired date/time formatting logic here
  // This example returns a simple string representation
  return dateTime.toString();
}
