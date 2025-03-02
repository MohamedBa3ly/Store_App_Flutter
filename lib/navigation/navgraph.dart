
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/navigation/screen.dart';

import '../cubits/categories_chip_change/chip_change_cubit.dart';
import '../cubits/favourite_icon_change/favourite_icon_cubit.dart';
import '../ui/cart/cart.dart';
import '../ui/details/details.dart';
import '../ui/favourites/favourites.dart';
import '../ui/home/home.dart';
import '../ui/settings/settings.dart';
import '../utils/colors.dart';

class NavGraph extends StatelessWidget {
  const NavGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );

  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  // Define the list of routes that should show the bottom navigation
  final List<String> _bottomNavRoutes = [
    BottomNavigationScreen.home.route,
    BottomNavigationScreen.information.route,
    BottomNavigationScreen.cart.route,
    BottomNavigationScreen.settings.route
  ];

  // Define routes for navigation
  final Map<String, WidgetBuilder> _routes = {
    BottomNavigationScreen.home.route : (context) => HomeScreen(),
    BottomNavigationScreen.information.route : (context) => FavouritesScreen(),
    BottomNavigationScreen.cart.route : (context) => CartScreen(),
    BottomNavigationScreen.settings.route : (context) => SettingsScreen(),
    InitialScreens.details : (context) => DetailsScreen()

  };

  // Helper to determine if current route should show bottom navigation
  bool _shouldShowBottomNav(String route) {
    return _bottomNavRoutes.contains(route);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavouriteIconCubit()),
        BlocProvider(create: (context) => ChipChangeCubit()), // Add ChipChangeCubit here
      ],
      child: Navigator(
        initialRoute: BottomNavigationScreen.home.route,
        onGenerateRoute: (settings) {
          final routeName = settings.name ?? BottomNavigationScreen.home.route;
          final screenBuilder = _routes[routeName];

          return MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: screenBuilder!(context),
                bottomNavigationBar: _shouldShowBottomNav(routeName)
                    ? BottomNavigationBar(
                  currentIndex: _bottomNavRoutes.indexOf(routeName),
                  onTap: (index) {
                    setState(() {
                      Navigator.pushNamed(context, _bottomNavRoutes[index]);
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ''),
                  ],
                  selectedItemColor: AppColors.orange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                )
                    : null,
              );
            },
          );
        },
      ),
    );
  }


}