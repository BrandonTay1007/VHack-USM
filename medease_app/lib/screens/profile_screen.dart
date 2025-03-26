// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'home_screen.dart';
// import 'edit_profile_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   final String username;
//   final String age;
//   final String gender;
//   final File? profileImage;

//   const ProfileScreen({
//     Key? key,
//     required this.username,
//     required this.age,
//     required this.gender,
//     this.profileImage,
//   }) : super(key: key);

//   void _openSettings(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => FractionallySizedBox(
//         heightFactor: 0.6,
//         child: Center(child: Text("Settings Screen")),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.home),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const HomeScreen()),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () => _openSettings(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Profile Image
//             CircleAvatar(
//               radius: 75,
//               backgroundColor: Colors.grey.shade300,
//               backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
//               child: profileImage == null
//                   ? const Icon(Icons.person, size: 80, color: Colors.white)
//                   : null,
//             ),
//             const SizedBox(height: 20),
//             // Username
//             Text(
//               username,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             // Profile Info
//             Text('Age: $age'),
//             Text('Gender: $gender'),
//             const Text('Email: abc123@gmail.com'), // Placeholder for email
//             const SizedBox(height: 30),
//             // Edit Profile Button
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const EditProfileScreen()),
//                 );
//               },
//               child: const Text('EDIT PROFILE'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart'; // For storing data
import 'home_screen.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String age;
  final String gender;
  final String? profileImage;

  const ProfileScreen({
    Key? key,
    this.username = "Guest",
    this.age = "",
    this.gender = "",
    this.profileImage,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Guest";
  String age = "";
  String gender = "";
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    setState(() {
      username = widget.username;
      age = widget.age;
      gender = widget.gender;
      profileImagePath = widget.profileImage;
    });
    _loadUserProfile(); // Load saved data
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? widget.username;
      age = prefs.getString('age') ?? widget.age;
      gender = prefs.getString('gender') ?? widget.gender;
      profileImagePath = prefs.getString('profileImage') ?? widget.profileImage;
    });
  }

   void _openSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.6,
        child: SettingsScreen(
          onClose: () => Navigator.pop(context), // Close when tapping the close button
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _openSettings(context),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE5FFE5), Color(0xFFE5F0FF)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: ClipOval(
                child: profileImagePath != null
                    ? Image.file(File(profileImagePath!), fit: BoxFit.cover)
                    : Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.person, size: 80, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 15),
            // Username
            Text(
              username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            // Profile Info
            _buildProfileInfo('Age', age),
            _buildProfileInfo('Gender', gender),
            _buildProfileInfo('Email', 'abc123@gmail.com'),
            const SizedBox(height: 30),
            // Edit Profile Button
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3FFA3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                  );
                  _loadUserProfile();
                },
                child: const Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                    color: Color(0xFF1A1C29),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
