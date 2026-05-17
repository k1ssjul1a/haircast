import 'package:flutter/material.dart';
import '../../../app/feature/home/home_page.dart';
import '../../../app/feature/details/details_page.dart';
import '../../../app/feature/profile/profile_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentPageIndex = 0;

  // Add your pages here
  final List<Widget> _pages = const [
    HomePage(),
    DetailsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to be visible behind the floating navbar
      body: _pages[currentPageIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black, // Continuous island look
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_rounded),
              _buildNavItem(1, Icons.moving_rounded),
              _buildNavItem(2, Icons.person_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = currentPageIndex == index;
    return GestureDetector(
      onTap: () => setState(() => currentPageIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCD3FF) : Colors.transparent, // Pop out with pastel purple
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white.withOpacity(0.5),
          size: 28,
        ),
      ),
    );
  }
}
