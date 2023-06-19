import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/componant/pages/authonication/login.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/cameraScreen.dart';
//import 'package:graduation_project/view/componant/pages/screens%20in%20lay%20out/welcomeScreen.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera.dart';

import '../../../../model/login_model/login_model.dart';
import '../../../../model/shaerd_prefrense/shaerd_prefrense.dart';
import '../../core/constant.dart';
import '../screens in Home Page/ProfilePage.dart';
import '../screens in Home Page/welcomeScreen.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A3164),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                openSideMenuWidth: 150,
                backgroundColor: Color(0xff2A3164),
                unselectedIconColor: Color(0xffefefee),
                // showTooltip: false,
               // displayMode: SideMenuDisplayMode.auto,
                hoverColor: Color(0xff181d43),
               // selectedColor: Color(0xff919da0),
               selectedTitleTextStyle: const TextStyle(color: Colors.white),
              //  selectedIconColor: Colors.white,
               // compactSideMenuWidth: 200,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                // ),
                // backgroundColor: Colors.blueGrey[700]
              ),
              title: Column(
                children: [
                  ConstrainedBox(
                    constraints:  BoxConstraints(
                     // maxHeight: 150,
                      maxWidth: 150,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: InkWell(
                        hoverColor: Color(0xff334e56),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: Container(child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Image(
                              height: 40,
                              width: 40,
                              image: AssetImage('assets/user (2).png'),),
                            SizedBox(height: 5,),
                            Text("Your Profile",style: TextStyle(color: Colors.black,)),
                          ],
                        )),
                      ),
                    ),
                  ),
                   SizedBox(height:25),
                   Divider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                ],
              ),
              footer:  Padding(
                padding: EdgeInsets.all(8.0),
                //child: Icon(Icons.arrow_back)
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Dashboard',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.home,color: Color(0xfff6765f),),
                  badgeContent: const Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Camera',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.camera_alt,color: Colors.white,),
                ),
                // SideMenuItem(
                //   priority: 2,
                //   title: 'Files',
                //   onTap: (page, _) {
                //     sideMenu.changePage(page);
                //   },
                //   icon: const Icon(Icons.file_copy_rounded),
                //   trailing: Container(
                //       decoration: const BoxDecoration(
                //           color: Colors.amber,
                //           borderRadius: BorderRadius.all(Radius.circular(6))),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 6.0, vertical: 3),
                //         child: Text(
                //           '//New',
                //           style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                //         ),
                //       )),
                // ),
                SideMenuItem(
                  priority: 2,
                  title: 'History',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                  },
                  icon: const Icon(Icons.history_edu_sharp),
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Log Out',
                  onTap: (page, _) {
                    sideMenu.changePage(page);
                    user = null;
                    accessToken = "";
                    CacheHelper.clearData().then((value) {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) =>Login()));});
                  },
                  icon: const Icon(Icons.login_rounded),
                ),
                // SideMenuItem(
                //   priority: 5,
                //   onTap:(page){
                //     sideMenu.changePage(5);
                //   },
                //   icon: const Icon(Icons.image_rounded),
                // ),
                // SideMenuItem(
                //   priority: 6,
                //   title: 'Only Title',
                //   onTap:(page){
                //     sideMenu.changePage(6);
                //   },
                // ),
                // const SideMenuItem(
                //   priority: 7,
                //   title: 'Exit',
                //   icon: Icon(Icons.exit_to_app),
                // ),
              ],
              onDisplayModeChanged: (value){
               print( value.index);
              },
            ),
            Expanded(
              child: PageView(
                controller: page,
                children: [
                  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                            child: WelcomeScreen()),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        child: CameraScreen()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        child:Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Users',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),),
                  ),

                  // Container(
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: Text(
                  //       'Files',
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: Text(
                  //       'Download',
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: Text(
                  //       'Settings',
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: Text(
                  //       'Only Title',
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: Text(
                  //       'Only Icon',
                  //       style: TextStyle(fontSize: 35),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}