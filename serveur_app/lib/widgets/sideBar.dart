import 'package:flutter/material.dart';
import 'package:restaurant_management/config/widget.dart';
import 'package:restaurant_management/theme/theme.dart';
import '../config/config.dart';
import '../config/packages.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final SidebarXController _controller = SidebarXController(
    selectedIndex: 0,
    extended: true,
    );
  final GlobalKey _sidebarKey = GlobalKey();

  final List<Widget> _pages = [
    const Menu1(),
    Center(child: Text('Search Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Settings Page')),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context); // Initialisation de la configuration de l'écran
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Management'),
      ),
      backgroundColor: lightColorScheme.surface,
      body: Row(
        children: [
          SidebarX(
            key: _sidebarKey,
            controller: _controller,
            items: [
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/boisson-non-alcoolisee.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Boissons'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/burger.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Burgers'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/des-cocktails.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Cocktails'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/desert.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Desserts'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/salade.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Entrées'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/frites.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Frites'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/creme-glacee.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Glaces'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/pizza.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Pizzas'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/regime-equilibre.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Plats Chauds'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/tortilla.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Salades'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/sandwich.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Sandwichs'
              ),
              SidebarXItem(
                iconWidget: Image.asset(
                  'assets/icons/bouteille-de-vin.png',
                  width: iconSize,
                  height: iconSize,
                ),
                label: 'Vins'
              ),
            ],
            theme: SidebarXTheme(
              decoration: BoxDecoration(
                color: lightColorScheme.onSurface,
                borderRadius: BorderRadius.circular(10.0),
              ),
              // itemMargin: EdgeInsets.symmetric(vertical: 10), // Espacement entre les éléments
              // itemPadding: EdgeInsets.symmetric(horizontal: 20), // Espacement entre icône et texte
            ),
            extendedTheme: SidebarXTheme(
              margin: EdgeInsets.all(marginSize),
              padding: EdgeInsets.all(10),
              width: paddingSize,
              textStyle: TextStyle(
                color:  lightColorScheme.onPrimary,
                fontSize: bodyTextSize,
                ),
              iconTheme: IconThemeData(
                color:  lightColorScheme.onPrimary,
                size: iconSize,
              ),
              selectedItemDecoration: BoxDecoration(
                color: lightColorScheme.primary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              selectedTextStyle: TextStyle(color: lightColorScheme.onSurface, fontSize: bodyTextSize),
              selectedIconTheme: IconThemeData(color: lightColorScheme.onSurface, size: iconSize),
              // itemPadding: EdgeInsets.symmetric(horizontal: 20), // Espacement entre icône et texte
              // itemPadding: EdgeInsets.only(left: 20), // Espacement entre icône et texte
            ),
            showToggleButton: false, // Supprime le bouton toggle
            toggleButtonBuilder: (_, __) => SizedBox(), // Empêche le toggle
          ),
          Expanded(
            child: IndexedStack(
              index: _controller.selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}