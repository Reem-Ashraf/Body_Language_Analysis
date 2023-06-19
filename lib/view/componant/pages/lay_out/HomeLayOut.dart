import 'package:flutter/material.dart';
import 'package:graduation_project/model/History.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/cameraScreen.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/welcomeScreen.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../model/shaerd_prefrense/shaerd_prefrense.dart';
import '../../core/constant.dart';
import '../authonication/login.dart';
import '../screens in Home Page/Create Patient.dart';
import '../screens in Home Page/History.dart';
import '../screens in Home Page/ProfilePage.dart';

class HomeLayOut extends StatefulWidget {
  const HomeLayOut({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
const primaryColor = Color(0xFF6252DA);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF7777B6);

class _MyHomePageState extends State<HomeLayOut > {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
          builder: (context) {
            final isSmallScreen = MediaQuery.of(context).size.width < 600;
            return Scaffold(
                backgroundColor:  Color(0xff2A3164),
                key: _key,
                appBar: isSmallScreen ? AppBar(
                  backgroundColor: Colors.white,
                  //title: Text('SideBarX Example'),
                  leading: IconButton(
                    onPressed: (){
                      _key.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                ): null,
                drawer: SideBarXExample(controller: _controller,),
                body: Row(
                  children: [
                    if(!isSmallScreen) SideBarXExample(controller: _controller),
                    Expanded(child: Center(child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context,child){
                        switch(_controller.selectedIndex){
                          case 0: _key.currentState?.closeDrawer();
                          return  Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                                child: WelcomeScreen()),
                          );
                          case 1: _key.currentState?.closeDrawer();
                          return  Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                                child: CreatePatient()),
                          );
                          case 2: _key.currentState?.closeDrawer();
                          return  Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                                child: CameraScreen()),
                          );
                          case 3: _key.currentState?.closeDrawer();
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                                child: HistoryScreen()),
                          );
                          // case 3: _key.currentState?.closeDrawer();
                          // return Center(
                          //   child: Text('Theme',style: TextStyle(color: Colors.white,fontSize: 40),),
                          // );

                          default:
                            return Center(
                            );
                        }
                      },
                    ),))
                  ],
                )
            );
          }
      ),
    );
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample({Key? key, required SidebarXController controller}) : _controller = controller,super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SidebarX(

          controller: _controller,
          theme: const SidebarXTheme(
            padding: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                color:  Color(0xff2A3164),

                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
            ),
            hoverColor:canvasColor ,
            iconTheme: IconThemeData(
              color: Colors.white,

            ),

            selectedTextStyle: TextStyle(color: Colors.white),
          ),
          extendedTheme: const SidebarXTheme(
              width: 120
          ),

          footerDivider: Divider(color:  Colors.white.withOpacity(0.8), height: 1),
          headerBuilder: (context,extended){
            return InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile()));
              },
              child:SizedBox(
              //  height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('assets/user (2).png'),),
                    SizedBox(height: 5,),
                    Text("Profile",style: TextStyle(color: Colors.black,)),
                    SizedBox(height: 20,),
                    Divider(color:  Colors.white.withOpacity(0.8), height: 1),

                  ],
                ),
              ),
            );
          },

          items: [
            SidebarXItem(
              icon: Icons.home,
              onTap: (){}, label: 'Home',),
            SidebarXItem(
              icon: Icons.group_add_outlined,
              onTap: (){}, label: 'Create',),
            SidebarXItem(icon: Icons.camera_alt_outlined, label: 'Camera'),
            SidebarXItem(icon: Icons.history_edu_sharp, label: 'History'),
            SidebarXItem(
              onTap: (){
                user = null;
                accessToken = "";
                CacheHelper.clearData().then((value) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) =>Login()));});
              },
                icon: Icons.logout, label: 'Log Out'),
          ],
        ),
      ),
    );
  }
}