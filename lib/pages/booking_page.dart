import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWithSearch(),
          SizedBox(height: 16.0),
          FilterCalendarSearchBar(),
          SizedBox(height: 16.0),
          InfoCard(
            title: 'Football court',
            subtitle: 'Somewhere',
            dateRange: '22/2/2024  11:00-13:00',
            buttonText: 'Apply',
            numberOfPeople: 10,
            imageUrl:
                'https://cdn.pixabay.com/photo/2024/02/20/09/39/nuts-8585063_640.jpg',
          ),
          SizedBox(height: 16.0),
          InfoCard(
            title: 'Football court',
            subtitle: 'Somewhere',
            dateRange: '22/2/2024  11:00-13:00',
            buttonText: 'Apply',
            numberOfPeople: 10,
            imageUrl:
                'https://cdn.pixabay.com/photo/2024/02/20/09/39/nuts-8585063_640.jpg',
          ),
          SizedBox(height: 16.0),
          InfoCard(
            title: 'Football court',
            subtitle: 'Somewhere',
            dateRange: '22/2/2024  11:00-13:00',
            buttonText: 'Apply',
            numberOfPeople: 10,
            imageUrl:
                'https://cdn.pixabay.com/photo/2024/02/20/09/39/nuts-8585063_640.jpg',
          ),
        ],
      ),
    );
  }
}

class AppBarWithSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      './assets/images/logo.png',
    );
  }
  // Instead of constructor arguments, define getter methods for properties
}

class FilterCalendarSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            print('Filter button pressed');
          },
        ),
        
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            print('Calender button pressed');
          },
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateRange;
  final String buttonText;
  final String imageUrl;
  final int numberOfPeople;

  const InfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateRange,
    required this.buttonText,
    required this.imageUrl,
    required this.numberOfPeople,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 150.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      dateRange,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '$numberOfPeople people',
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Calender button pressed');
                      },
                      child: Text(buttonText),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
