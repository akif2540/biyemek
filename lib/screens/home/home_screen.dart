import 'package:biyemek/screens/home/comments.dart';
import 'package:biyemek/screens/home/location.dart';
import 'package:biyemek/screens/home/products.dart';
import 'package:biyemek/screens/home/profile.dart';
import 'package:biyemek/screens/onboarding/entrance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentStep=0;
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not signed in, handle this case accordingly
      return const Entrance(); // Return an empty container or another widget
    }
    return SafeArea(
      child: Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Container(
                color: Color(0xFFFAFAFA),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const location();
                              },
                            ),
                          );
                        },
                        child: Row(

                          children: [
                            SizedBox(width:10 ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.green,
                                  size: 42,
                                ),
                                Text(
                                  "İstanbul/Üsküdar",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width:70 ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const notifications();
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  color: Colors.black12,
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Colors.green,
                                  size: 42,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFBE7CB4),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                  shape: BoxShape.rectangle,
                                  color: Color(0xFFDBB7D6),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "MadGlobal",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                    Icon(
                                      Icons.account_circle_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(

                        children: [

                          SizedBox(width:15 ),


                          Expanded(
                            child: Container(
                              width: 110,
                              height: 110,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFBE7CB4),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFDBB7D6),

                              ),
                              child: Column(
                                children: [
                                    SizedBox(height:10 ),
                                  Text("Money Saved",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white
                                  ),),
                                  Image.asset("assets/images/img_1.png",
                                  width: 48,
                                  height: 48,
                                  color: Color(0xFFBE7CB4),),

                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(width:40 ),
                                        Icon(Icons.currency_lira_outlined,

                                        color: Color(0xFFBE7CB4),
                                        ),
                                        Text("200",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFBE7CB4)
                                        ),),
                                      ],
                                    ),
                                  ),



                                ],
                              ),
                            ),
                          ),

                          SizedBox(width:20 ),
                          Expanded(child: Container(
                            width: 110,
                            height: 110,

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFBE7CB4),
                                width: 1.0,
                              ),
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFFDBB7D6)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height:10 ),
                                Text("CO2 Saved",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white
                                  ),),

                                Icon(Icons.co2_outlined,
                                color:Color(0xFFBE7CB4) ,
                                size: 50,),

                                SizedBox(width:40 ),

                                Text("33 Kg",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFBE7CB4)
                                  ),),



                              ],
                            ),

                          ),

                          ),
                          SizedBox(width: 15),



                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20.0),
                                  shape: BoxShape.rectangle,
                                  color: Color(0xFFDBB7D6)
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const comments();
                                        },
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.mode_comment_outlined,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const products();
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(20.0),
                                    shape: BoxShape.rectangle,
                                    color: Color(0xFFDBB7D6)
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "My Products",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(

                        child: Container(

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12.withOpacity(0.1),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Sütunları yatayda hizalamak için
                            children: <Widget>[

                              Column(
                                children: [
                                  SizedBox(height: 10),

                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 200,

                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: Color(0xFFBE7CB4),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFFDBB7D6)

                                      ),
                                      
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Text(
                                        "Bekleyen",
                                            style: TextStyle(
                                              color: Color(0xFFBE7CB4),
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                              "Siparişler",
                                            style: TextStyle(
                                              color: Color(0xFFBE7CB4),
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              "0 Adet",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:5 ),
                                  Expanded(child:Container(
                                    width: 150,
                                    height: 200,

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                        color: Color(0xFFBE7CB4),
                                      ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFFDBB7D6)

                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Aktif",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Ürünler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "0 Adet",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),



                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: Container(
                                      width: 150,
                                      height: 150,

                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFBE7CB4),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFFDBB7D6)
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15),
                                          Text(
                                            "Gönderilen",
                                            style: TextStyle(
                                              color: Color(0xFFBE7CB4),
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Siparişler",
                                            style: TextStyle(
                                              color: Color(0xFFBE7CB4),
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "0 Adet",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:5 ),

                                  Expanded(child:Container(
                                    width: 150,
                                    height: 150,

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFFBE7CB4),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFDBB7D6)
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Gönderilen",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Ürünler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "0 Adet",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ), ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(children: [
                Stepper(steps: [
                  Step(title: Text("Ürün Bilgileri"), content: Column(children: [

                    Text("Add Product İmages"),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0xFFDBB7D6),
                              border: Border.all(
                                color: Color(0xFFBE7CB4),
                                width: 2.0,

                              ),
                            ),
                            child: Icon(Icons.add_circle_outline_outlined,
                            size: 60,
                            color: Colors.white30),
                          ),

                        ),
                        SizedBox(width:30 ),


                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFFDBB7D6),
                              border: Border.all(
                                color: Color(0xFFBE7CB4),
                                width: 2.0,

                              ),
                            ),
                            child: Icon(Icons.add_circle_outline_outlined,
                                size: 60,
                                color: Colors.white30),
                          ),

                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Product Name"),
                    SizedBox(height: 10),
                    ExcludeFocus(
                      child: Container(
                        height: 45,
                        
                        decoration: BoxDecoration(
                          color: Color(0xFFDBB7D6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFFBE7CB4),
                            width: 2.0,

                          ),
                        ),
                      ),
                    )
                  ],)),


                  Step(title: Text("Ürün Özellikleri"),content: Text("")),
                ],
                onStepTapped: (int newIndex){
                  setState(() {
                    _currentStep=newIndex;
                  });
                },
                currentStep: _currentStep,
                  onStepContinue: (){
                  if(_currentStep !=2){
                    setState(() {
                      _currentStep +=1;
                    });
                  }
                  },
                  onStepCancel: (){
                  if(_currentStep !=0){
                    setState(() {
                      _currentStep -=1;
                    });

                     }
                  },
                )
              ]),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 90),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext) {
                              return Container(
                                height: 200,
                                child: Row(
                                  children: [
                                    SizedBox(width: 70),
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.green,
                                      size: 75,
                                    ),
                                    SizedBox(width: 100),
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.green,
                                      size: 75,
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Icon(Icons.account_circle,
                          size: 150, color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "İşletme Adı",
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const profile();
                            },
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Profilimi Düzenle",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 60),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext) {
                              return Container(
                                height: 200,
                                color: Colors.white24,
                                child: Row(
                                  children: [
                                    SizedBox(width: 50),
                                    Text(
                                      "Türkçe",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.green),
                                    ),
                                    SizedBox(width: 90),
                                    Text(
                                      "English",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.green),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.language,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Dil",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 190),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: signUserOut,
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            child: Icon(
                              Icons.exit_to_app_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Exit",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          SizedBox(width: 180),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Container(
            width: 130,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GNav(
                color: Colors.green,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.green,
                iconSize: 35,
                gap: 5,
                padding: const EdgeInsets.all(16),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.add_shopping_cart,
                    text: "Add Product",
                  ),
                  GButton(
                    icon: Icons.supervisor_account_rounded,
                    text: "Account",
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                },
              ),
            ),
          ),
        ),

      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
