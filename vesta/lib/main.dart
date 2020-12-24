import 'package:flutter/material.dart';
import 'package:vesta/assets/pc_icons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Dark theme constants
// Vesta Green
const PrimaryGreen = Color(0xFF74B62E);
// Lightest Grey
const PrimaryGrey = Color(0xFFDFDFDF);
// Middle Grey
const SecondaryGrey = Color(0xFF404040);
// Darkest Grey
const TertiaryGrey = Color(0xFF141414);

void main() {
  runApp(MaterialApp(
    title: "Vesta",
    home: HomePage(),
    // theme: ThemeData(
    //   brightness: Brightness.light,
    //   primarySwatch: Colors.orange,
    // ),
    theme: ThemeData(
      brightness: Brightness.dark,
      // primarySwatch: PrimaryGreen,
      scaffoldBackgroundColor: TertiaryGrey,
      // Custom font family
      fontFamily: "BellotaText",
      // Unselected Nav item color
      unselectedWidgetColor: TertiaryGrey,
      // themeMode: darkTheme
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize our value
  Future<Balance> fetchBalance;

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
      appBar: AppBar(
        centerTitle: true,
        // This needs to be the logo
        title: const Icon(
          MyFlutterApp.logo_vesta,
          color: Color(0xFF74B62E),
        ),
        backgroundColor: Color(0xff141414),
      ),
      body: Center(child: _children[_currentIndex]),
      // Make our bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        // Set the background color of the navigation bar
        backgroundColor: Color(0xff404040),
        // Set the unselected color of the icons
        selectedItemColor: PrimaryGreen,
        unselectedItemColor: TertiaryGrey,
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

// Get balances
Future<Balance> fetchBalance() async {
  final response = await http.get(
      "https://btc1.trezor.io/api/v2/address/3ETUmNhL2JuCFFVNSpk8Bqx2eorxyP9FVh");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Balance.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

// Get our balance call
class Balance {
  // Initialize our balance
  final double assetBalance;

  Balance({this.assetBalance});
  // Parse the JSON
  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(assetBalance: json['balance']);
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

// List of Assets Container
Widget listOfAssets = Container(
    // Ticker, Name, Image url, coin quantity
    child: Column(children: [
  AssetWidget(
    // Ticker name will go in here eventually
    ticker: "BTC",
    name: "Bitcoin",
    // Not sure how to make this work
    icon: MyFlutterApp.l_bitcoin,
    quantity: "3.56",
  ),
  AssetWidget(
      // Ticker name will go in here eventually
      ticker: "PPC",
      name: "Peercoin",
      // Not sure how to make this work
      icon: MyFlutterApp.l_peercoin,
      quantity: "4443.56"),
]));

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
  final IconData icon;
  final String quantity;

  // const AssetWidget({this.ticker, this.name, this.icon, this.quantity});
  const AssetWidget({this.ticker, this.name, this.icon, this.quantity});
  @override
  _AssetWidgetState createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 46,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 46,
        color: Color(0xff404040),
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30.86,
              height: 30.86,
              child: Icon(
                widget.icon,
                color: Color(0xff74B62E),
                size: 30,
              ),
            ),
            SizedBox(width: 22.92),
            Column(children: [
              Text(
                widget.ticker,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xffdfdfdf),
                  fontSize: 13,
                ),
              ),
              Text(
                widget.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xffdfdfdf),
                  fontSize: 10,
                ),
              ),
            ]),
            SizedBox(width: 22.92),
            Column(children: [
              Text(
                // Usd quantity
                "75,651.21",
                style: TextStyle(
                  color: Color(0xffdfdfdf),
                  fontSize: 13,
                ),
              ),
              Text(
                widget.quantity,
                style: TextStyle(
                  color: Color(0xffdfdfdf),
                  fontSize: 10,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

Widget profileSettings = Expanded(
  // Needs to have "Profile"
  child: Column(
    // Menu items
    children: [
      // Security
      ProfileSettingsItem(menuItemName: "Security"),
      // Settings
      ProfileSettingsItem(menuItemName: "Settings"),
    ],
  ),
);

class ProfileSettingsItem extends StatelessWidget {
  final String menuItemName;

  ProfileSettingsItem({@required this.menuItemName});
  @override
  Widget build(BuildContext content) {
    return Container(
      width: 301,
      height: 60,
      child: Container(
        width: 301,
        height: 60,
        color: Color(0xff404040),
        padding: const EdgeInsets.only(
          left: 9,
          right: 203,
          top: 10,
          bottom: 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 26.89,
              height: 26.85,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Opacity(
                        opacity: 0.50,
                        child: Container(
                          width: 9.97,
                          height: 12.32,
                          color: Color(0xff74b62e),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.50,
                    child: Container(
                      width: 26.89,
                      height: 26.85,
                      color: Color(0xff74b62e),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 3.61),
            Text(
              menuItemName,
              style: TextStyle(
                color: Color(0xff74b62e),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget enableDisableAssets = Expanded(
    child: Column(children: [
  EnableDisableAssetWidget(
    // Ticker name will go in here eventually
    ticker: "BTC",
    name: "Bitcoin",
    // Not sure how to make this work
    icon: MyFlutterApp.l_bitcoin,
    // switchState: true
  ),
  EnableDisableAssetWidget(
    // Ticker name will go in here eventually
    ticker: "PPC",
    name: "Peercoin",
    // Not sure how to make this work
    icon: MyFlutterApp.l_peercoin,
    // switchState: true
  ),
]));

// Asset Widget
class EnableDisableAssetWidget extends StatefulWidget {
  final String ticker;
  final String name;
  // final Icon icon;
  final IconData icon;
  // final bool switchState;

  // const AssetWidget({this.ticker, this.name, this.icon, this.quantity});
  const EnableDisableAssetWidget({this.ticker, this.name, this.icon});
  @override
  _EnableDisableAssetWidgetState createState() =>
      _EnableDisableAssetWidgetState();
}

class _EnableDisableAssetWidgetState extends State<EnableDisableAssetWidget> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xff404040),
      child: Row(
        children: [
          // Asset Icon - This should be a custom icon but I'm not sure how to pass it down yet
          Icon(
            widget.icon,
            color: Color(0xff141414),
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
                GestureDetector(
                  //onTap: (),
                  child: Text(
                    widget.ticker,
                    style: TextStyle(
                      color: Color(0xFFDFDFDF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.white,
            activeColor: Color(0xFF74B62E),
          ),
        ],
      ),
    );
  }
}

// Value Container
Widget homeValueContainer = ColoredBox(
    color: Color(0xff404040),
    //padding: const EdgeInsets.all(32),
    child: Column(children: [
      Column(children: [
        Icon(
          MyFlutterApp.l_bitcoin,
          color: Color(0xff141414),
        ),
        // Quantity
        Text("654.5446",
            style: TextStyle(
              color: Color(0xff74B62E),
              fontSize: 25,
            )),
        // Fiat value
        Text(
            // This will need to be passed the actual value of the portfolio
            // It will be $_portfolioValue at some point
            '\u0024 31,568.45 USD',
            softWrap: false,
            // Set the style
            style: TextStyle(
              color: Color(0xff74B62E),
              fontSize: 15,
            )),
      ]),
      Row(
          // children: [
          // Receive
          // Balance
          // ]
          )
    ]));

// Transaction Activity
Widget transactionActivity =
    Expanded(child: Text("Transaction activity will go here"));
