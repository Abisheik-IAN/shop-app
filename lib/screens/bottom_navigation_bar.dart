import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_events.dart';
import '../bloc/cart_bloc/cartcount_bloc.dart';
import '../widgets/batch.dart';
import 'account.dart';
import 'cart.dart';
import 'home_page.dart';
import 'menu.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Account(),
    MyCart(),
    Menu()
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("bottom bar");
    context.read<CartCountBloc>().add(CartCountIncrementEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity_outlined,
            ),
            label: 'Account',
            activeIcon: Icon(
              Icons.perm_identity_outlined,
              color:  Colors.white,
            ),
          ),
          BottomNavigationBarItem(

            icon:NamedIcon(iconcolor: null,),
            label: 'Cart',
            activeIcon: NamedIcon(iconcolor: Colors.white,)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,

            ),
            label: 'Cart',
            activeIcon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (index) {
          print("pressed");
          context.read<CartCountBloc>().add(CartCountIncrementEvent());
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Stack(
        children: [
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
          _buildOffstageNavigator(3),
        ],
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {

    return {
      '/': (context) {
        return [
          HomePage(),
          Account(),
          MyCart(),
          Menu()
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    final Map routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }
  Summa(){
    return Container();
  }
}
