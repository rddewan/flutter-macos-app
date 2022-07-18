import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_demo/models/user_model.dart';
import 'package:macos_demo/screens/account_screen.dart';
import 'package:macos_demo/screens/home_screen.dart';
import 'package:macos_demo/screens/product_screen.dart';
import 'package:macos_demo/screens/setting_screen.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user_box');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'Macos Demo',
      theme: MacosThemeData.light() ,
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentIndex = 0;
  final List<Widget> pages = const [
    HomeScreen(),
    ProductScreen(),
    AccountScreen(),
    SettingScreen(),
  ];
  

  @override
  Widget build(BuildContext context) {
   
    return MacosWindow(
      sidebar: Sidebar(
        top: MacosSearchField(
          placeholder: 'Search ...',
          results: ['Apple','Boy','Cat','Dog','Egg','Fish','Ball'].map((e) => SearchResultItem(e)).toList(),
          maxResultsToShow: 3,
          onResultSelected: (value) {
            debugPrint(value.searchKey);
          },
        ),
        builder: ((context, scrollController) {
          return SidebarItems(
            currentIndex: currentIndex, 
            onChanged: ((value) {
              setState(() {
                currentIndex = value;
              });
            }),
            items: const [
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.home),
                selectedColor: Colors.greenAccent,
                label: Text('Home')
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.cart),
                selectedColor: Colors.greenAccent,
                label: Text('Product')
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.person),
                selectedColor: Colors.greenAccent,
                label: Text('Account')
              ),
              SidebarItem(
                leading: MacosIcon(CupertinoIcons.settings),
                selectedColor: Colors.greenAccent,
                label: Text('Setting')
              ),
            ], 
          );
        }), 
        minWidth: 200,
        startWidth: 200,
        maxWidth: 350,
        bottom: Row(
          children: const[
            MacosIcon(CupertinoIcons.person),
            Text('demo@gmal.com')
          ],
        )
      ),
      child: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

    );
  }
}
