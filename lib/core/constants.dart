import 'package:glitzup/views/screens/home/home_screen.dart';
import 'package:glitzup/views/screens/notification/notification_screen.dart';
import 'package:glitzup/views/screens/profile/profile_screen.dart';
import 'package:glitzup/views/screens/search/search_screen.dart';
import 'package:glitzup/views/screens/upload%20post/uploadpost_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

final screens = [
  const HomeScreen(),
   const SearchScreen(),
  const UploadPost(),
  const NotificationScreen(),
  const ProfileScreen()
];

 final googleSignIn = GoogleSignIn();


const profileImage = 'https://w7.pngwing.com/pngs/304/275/png-transparent-user-profile-computer-icons-profile-miscellaneous-logo-monochrome-thumbnail.png';
const coverImage = 'https://media.istockphoto.com/id/1408387701/photo/social-media-marketing-digitally-generated-image-engagement.webp?b=1&s=612x612&w=0&k=20&c=GZCD21X5437zQJjw40Qnda-pMWLY_x0zzeQSv-rEe_I='
;