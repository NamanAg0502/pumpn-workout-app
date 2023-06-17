import 'package:flutter/material.dart';
import 'package:pumpn/constants/index.dart';
import 'package:pumpn/models/add_option.dart';
import 'package:pumpn/screens/home/add_screen.dart';
import 'package:pumpn/screens/home/explore_screen.dart';
import 'package:pumpn/screens/home/workout_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key, Key? widgetKey});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  bool _showOptions = false;

  static final List<Widget> _widgetOptions = <Widget>[
    // Replace these with your actual screens
    const ExploreScreen(),
    const WorkoutScreen(),
    Container(),
    Screen4(),
    Screen5(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _toggleOptions();
      return;
    }
    setState(() {
      _selectedIndex = index;
      _showOptions = false;
    });
  }

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
          if (_showOptions) _buildFloatingOptions(context),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: BottomNavigationBar(
              backgroundColor: Colors.grey[900],
              enableFeedback: false,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottomnav/explore.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 0 ? AppColors.orange : AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottomnav/workout.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? AppColors.orange : AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _showOptions
                        ? 'assets/icons/bottomnav/close.svg'
                        : 'assets/icons/bottomnav/add.svg',
                    colorFilter: ColorFilter.mode(
                      _showOptions ? AppColors.orange : AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottomnav/stats.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 3 ? AppColors.orange : AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/bottomnav/profile.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 4 ? AppColors.orange : AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingOptions(BuildContext context) {
    return Positioned(
      bottom: 0.0, // Adjust the value as needed
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < _optionScreen.length; i++)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(_optionScreen[i].route);
                },
                child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: _optionScreen[i].color.withOpacity(0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(_optionScreen[i].icon,
                            height: 36,
                            colorFilter: ColorFilter.mode(
                              _optionScreen[i].color,
                              BlendMode.srcIn,
                            )),
                        const SizedBox(height: 8.0),
                        Text(
                          _optionScreen[i].name,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }

  final List<AddOptions> _optionScreen = [
    AddOptions(
      icon: 'assets/icons/bottomnav/dumbbell.svg',
      name: 'Workout',
      route: '/create-workout',
      color: AppColors.green,
    ),
    AddOptions(
      icon: 'assets/icons/bottomnav/food.svg',
      name: 'Food',
      route: '/create-workout',
      color: AppColors.red,
    ),
    AddOptions(
      icon: 'assets/icons/bottomnav/drop.svg',
      name: 'Drink',
      route: '/create-workout',
      color: AppColors.blue,
    )
  ];
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Screen 4'),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Screen 5'),
    );
  }
}

// Add Screen3, Screen4, and Screen5 with their respective content
