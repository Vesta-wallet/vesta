import 'package:flutter/material.dart';
import 'package:vesta/assets/pc_icons.dart';

void main() {
  runApp(MaterialApp(
    title: "Vesta",
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    homePage,
    walletPage,
    transactionPage,
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        // This needs to be the logo
        leading: Icon(
          MyFlutterApp.logo_vesta,
          color: Color(0xFF74B62E),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          Icon(Icons.more_vert, color: Color(0xFF74B62E)),
        ],
        backgroundColor: Color(0xff141414),
      ),
      body: Center(child: _children[_currentIndex]),
      // Make our bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        // Set the background color of the navigation bar
        backgroundColor: Color(0xff74B62E),
        // Set the unselected color of the icons
        unselectedItemColor: Color(0xff141414),
        // Hide the labels of the selected menu item because we don't need them
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Sets the current index of the page we are on
        currentIndex: _currentIndex,
        // Update our state onTabTap and change the index
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.menu_wallet_black),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.menu_exchange_black),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.menu_profile_white),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}

// This is the widget
class SectionTitle extends StatelessWidget {
  //Define our input variable types
  final String title;

  SectionTitle({@required this.title});

  // Override the default StatelessWidget
  @override
  // Build the actual widget
  Widget build(BuildContext content) {
    return Text(
        // Add our title
        title,
        // Align our text to the left
        textAlign: TextAlign.left,
        style: TextStyle(
          // Font Size
          fontSize: 15,
          // Set color - needs to be a theme based variable
          color: Color(0xff74B62E),
          // Set our font weight
          fontWeight: FontWeight.bold,
        ));
  }
}

// Profile page
Widget homePage = Column(
  children: [
    // Home Value
    SectionTitle(title: "VALUE"),
    homeValueContainer,
    // List of Assets
    SectionTitle(title: "LIST OF ASSETS"),
    listOfAssets,
  ],
);

// Wallet page
Widget walletPage = Column(children: [
  //
  walletValueContainer,
  // Turn on/off coins here
  SectionTitle(title: "ACTIVITY"),
  transactionActivity,
]);

// Transactions page
Widget transactionPage = Column(
  children: [
    // Access settings
    SectionTitle(title: "PROFILE"),
    profileSettings,
    // Turn on/off coins herejfc
    SectionTitle(title: "ENABLE/DISABLE ASSESTS"),
    enableDisableAssets,
    //
  ],
);

// Value Container
Widget homeValueContainer = ColoredBox(
    color: Color(0xff404040),
    //padding: const EdgeInsets.all(32),
    child: Container(
        padding: const EdgeInsets.all(32),
        child: (Text(
            // This will need to be passed the actual value of the portfolio
            // It will be $_portfolioValue at some point
            '\u0024 89,563.54',
            softWrap: false,
            // Set the style
            style: TextStyle(
              color: Color(0xffDFDFDF),
              fontSize: 25,
            )))));

// List of Assets Container
Widget listOfAssets = Container(
    // Ticker, Name, Image url, coin quantity
    child: AssetWidget(
        ticker: "BTC",
        name: "Bitcoin",
        // Not sure how to make this work
        // icon: Icon(MyFlutterApp.l_peercoin),
        quantity: "3.56"));

// [
//   {
//     "name": "Bitcoin",
//     "network": "BTC",
//     "image": "vesta\vesta\assets\l_bitcoin.svg",
//     "enabled": true
//   }
// ]

// Asset Widget
class AssetWidget extends StatefulWidget {
  final String ticker;
  final String name;
  // final Icon icon;
  final String quantity;

  // const AssetWidget({this.ticker, this.name, this.icon, this.quantity});
  const AssetWidget({this.ticker, this.name, this.quantity});
  @override
  _AssetWidgetState createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xff404040),
      child: Row(
        children: [
          // Asset Icon - This should be a custom icon but I'm not sure how to pass it down yet
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: Color(0xFFDFDFDF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.ticker,
                  style: TextStyle(
                    color: Color(0xFFDFDFDF),
                  ),
                ),
              ],
            ),
          ),
          /*3*/

          Text(widget.quantity, style: TextStyle(color: Color(0xFFDFDFDF))),
        ],
      ),
    );
  }
}

Widget profileSettings = Expanded(
    // Needs to have "Profile"
    child: (Text("Profile Settings will go here"))
    // Menu items
    // Security
    // Settings
    // Support
    );

Widget enableDisableAssets = Expanded(
    child: (
        // This is where all the swtiches for enabling and disabling things will go
        Text("Asset Swtiches will go here")));

// Value Container
Widget walletValueContainer = ColoredBox(
    color: Color(0xff404040),
    //padding: const EdgeInsets.all(32),
    child: Container(
      padding: const EdgeInsets.all(32),
      child: Text(
          // This will need to be passed the actual value of the portfolio
          // It will be $_portfolioValue at some point
          '\u0024 31,568.45 USDT',
          softWrap: false,
          // Set the style
          style: TextStyle(
            color: Color(0xffDFDFDF),
            fontSize: 25,
          )),
    ));

// Transaction Activity
Widget transactionActivity =
    Expanded(child: Text("Transaction activity will go here"));
