import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/theme/theme_colors.dart';
import '../../common/utils/constants/app_constants.dart';
import '../../lists/search/ui/search_screen.dart';
import '../bloc/home_bloc.dart';

part 'home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  bool isTabletOrIpad = false;
  late AppLocalizations tr;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> homePages = <Widget>[
    const SearchScreen(),
    const Center(
      child: Text(
        'Index 1: Business',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 3: Settings',
        style: optionStyle,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    tr = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    isTabletOrIpad = size.shortestSide > 550;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appTitle),
      ),
      body: BlocProvider(
        create: (context) {
          return HomeBloc();
        },
        child: HomeScreenBody(parent: this),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: _onItemTapped,
        height: 50,
        indicatorColor: ThemeColors.primaryDark,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'LIST',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'LIKES',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit),
            label: 'DRAFTS',
          ),
        ],
      ),
    );
  }
}
