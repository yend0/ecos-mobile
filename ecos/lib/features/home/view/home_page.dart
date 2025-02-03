import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  static const String _homeIcon = 'assets/icons/ic_home.svg';
  static const String _recyclingIcon = 'assets/icons/ic_recycling.svg';
  static const String _profileIcon = 'assets/icons/ic_profile.svg';


  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final theme = Theme.of(context);
   return Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          floating: true,
          pinned: true,
          snap: false,
          title: Row(
            children: [
              Text('Hi! Vadim'),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: TextStyle(
        color: Colors.black,
      ),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            HomePage._homeIcon,
            height: 24,
            width: 24,
          ),
          activeIcon: SvgPicture.asset(
              HomePage._homeIcon,
              height: 24,
              width: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            HomePage._recyclingIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
          ),
        activeIcon: SvgPicture.asset(
          HomePage._recyclingIcon,
          height: 24,
          width: 24,
        ),
        label: 'Recycle',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            HomePage._profileIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
          ),
        activeIcon: SvgPicture.asset(
          HomePage._profileIcon,
          height: 24,
          width: 24,
        ),
        label: 'Profile',
        ),
      ],
    ),
   );
  }

}