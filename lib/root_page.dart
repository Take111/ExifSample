import 'package:exif_sample/image_page.dart';
import 'package:exif_sample/painter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> wigets = [
    const ImagePage(),
    const PainterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wigets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.photo,
              ),
              label: 'Exif'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
            ),
            label: 'Photo',
          ),
        ],
      ),
    );
  }
}
