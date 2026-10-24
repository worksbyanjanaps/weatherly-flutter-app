import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/weather.dart';
import 'package:weatherly/weather_result.dart';


const apiKey = 'c67a8ad51a3e28fa1fae4f1c1894127a';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool? isChecked = false;
  var selectedIndex = 0;
  int selectedItem = 0;
  List tabWidgets = [
    Text("Home",style: TextStyle(fontSize: 40),),
    Text("Profile",style: TextStyle(fontSize: 40),),
    Text("Dashboard",style: TextStyle(fontSize: 40),),
    Text("Settings",style: TextStyle(fontSize: 40),),
  ];
  String? gender;
  String? status;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      var WeatherData = await weatherModel.getLocationweather();

      Navigator.pushNamed(context, '/loading');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return WeatherResultScreen(
      //         LocationWeather:  WeatherData,
      //       );
      //     },
      //   ),
      // );
    } catch (e) {
      print('Error getting weather: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get weather. Please try again.'),
        ),
      );
    }
  }
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(

          bottom: TabBar(
            tabs: const [Tab(icon: Icon(Icons.cloud), text: "Current Weather",), Tab(icon: Icon(Icons.calendar_month), text: "Forecast",),],
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: Colors.greenAccent
            // ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),


          leading: Builder(builder: (context) {
            return IconButton(onPressed: () {
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu_sharp));
          }),
          title: Text('Weather App'),
          centerTitle: true,
          elevation: 10,
          actions: [
            IconButton(onPressed: () {} , icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
          ),
          backgroundColor: Colors.green[900],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [
                  Colors.tealAccent[700]!,
                  Colors.green[900]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                ),
              ),
            ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
              backgroundColor: Colors.pink
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            backgroundColor: Colors.brown
          ),
        ],
          iconSize: 30,
      
          showUnselectedLabels: true,
          currentIndex: selectedItem,
          onTap: (int index) {
          setState(() {
            selectedItem = index;
          });
          },
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.tealAccent[700]!,
                    Colors.green[900]!
                  ])
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                      Text("Anjana",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("anjanaps600@gmail.com",style: TextStyle(fontSize: 12),),
                ],
              ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                selected: selectedIndex==0,
                onTap: () {
                  onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text("Current Location"),
                selected: selectedIndex==1,
                onTap: () {
                  onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text("Search City"),
                selected: selectedIndex==2,
                onTap: () {
                  onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                selected: selectedIndex==3,
                onTap: () {
                  onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About"),
                selected: selectedIndex==4,
                onTap: () {
                  onItemTapped(4);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.red,),
                title: Text("Logout",style: TextStyle(color: Colors.red),),
                selected: selectedIndex==5,
                onTap: () {
                  onItemTapped(5);
                  Navigator.pop(context);},),],),
        ), 
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 
        floatingActionButton: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           FloatingActionButton.extended(
             onPressed: () {},
             label: Text("Share Location"),
             icon: Icon(Icons.share),),
      
           FloatingActionButton(
             onPressed: () {},
             mini:true,
             tooltip: "Share Location",
             backgroundColor: Colors.green,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20)
             ),
             child: Icon(Icons.location_on),),
         ],
       ),
      
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.brown,
                  child: Column(
                    children: [
                      Text("select your gender",style: TextStyle(fontSize: 20),),
                      ListTile(
                        title: Text('male'),
                        leading: Radio(value: 'male',groupValue: gender,
                          onChanged: (String? value) {
                          setState(() {
                            gender =value;
                          });
                        },),
                      ),
                      ListTile(
                        title: Text('female'),
                        leading: Radio(value: 'female',groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender =value;
                            });
                          },),
                      ),
                      ListTile(
                        title: Text('Other'),
                        leading: Radio(value: 'Other',groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender =value;
                            });
                          },),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Marital Status",style: TextStyle(fontSize: 20),),
                      RadioListTile(
                        activeColor: Colors.red,
                          title: Text('Unmarried'),
                          value: 'married',groupValue: status,onChanged: (String? value) {
                        setState(() {
                          status= value;
                        });
                      }),
                      RadioListTile(
                          title: Text("Married"),
                          value: 'unmarried',groupValue: status,onChanged: (String? value) {
                        setState(() {
                          status= value;
                        });
                      }),
                      Text('$status',style: TextStyle(fontSize: 30),)
                  ],),
                ),
                Expanded(
                  child: TabBarView(
                      children: [
                    Text("Chats Page",style: TextStyle(fontSize: 30),),
                    Text("Data Page",style: TextStyle(fontSize: 30),),
                  ],),
                ),
            
                Center(child: tabWidgets.elementAt(selectedItem),),
            
                Image.asset('assets/images/cloudIntro.png', height: 130.0,),
            
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFF1A1C2E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black),
                    boxShadow: [BoxShadow(color: Colors.blueAccent,offset:Offset(2, 3)),],
                  ),
                  child: Text(
                    'Discover the Weather in Your City',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins Bold',
                      fontWeight: FontWeight.w600,
                      wordSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2, 4),
                          blurRadius: 3
                        )]),),),
            
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Get to Know your weather maps and radar precipitation forecast',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Poppins Regular',
                        color: Colors.grey.shade400),),
                ),
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:[
                      CheckboxListTile(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                        });},
                        tileColor: Colors.green,
                        title: Text("Send Notifications",style: TextStyle(color: Colors.white),),
                        subtitle: Text("Turn ON or OFF Notifications"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),),],),),
            
            
                GestureDetector(
                  onTap: () {
                    getLocationData();
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(16),
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(16),),
                    child: Text(
                      'Get Weather',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        fontSize: 15.0,
                      ),),),),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

