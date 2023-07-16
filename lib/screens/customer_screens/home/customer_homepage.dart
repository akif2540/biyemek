import 'package:biyemek/components/category_name.dart';
import 'package:biyemek/screens/customer_screens/home/profile/customer_profile_page.dart';
import 'package:biyemek/screens/onboarding/entrances/customer_entrance.dart';
import 'package:biyemek/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../models/product_model.dart';
import '../../../services/customer_product_service.dart';
import '../../../widgets/cart_products_item.dart';
import '../../../widgets/product_grid_view.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentStep = 0;
  final statuses = List.generate(
    2,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  int curIndex = -1;
  int lastIndex = -1;
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const CustomerEntrance();
    }

    List<String> categories = [
      'Meyve - Sebze',
      'Şarküteri',
      'Temel Gıda',
      'Meze - Hazır Yemek - Donuk',
      'Fırın - Pastane',
      'Atıştırmalık',
      'Meşrubat',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CustomerProfilePage();
                },
              ),
            );
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Yakınımdaki Ürünler",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF5722),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ...List.generate(categories.length, (index) {
                      return Column(
                        children: [
                          CategoryName(
                            text: categories[index], //category name
                          ),
                          ProductGridView(
                              category: categories[index]), //product
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
//my cart page starts here-------------------------------------------------
            Expanded(
              child: Column(
                children: [
                  //products will come here
                  Expanded(
                    child: StreamBuilder<List<Product>>(
                      stream: CustomerProductsService().getCartProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Bir şeyler yanlış gitti'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Sepetinizde ürün yok'));
                        } else {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: CartProductItem(
                                product: snapshot.data![i],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Center(
                      child: Text('Sepete eklenmiş bir ürün bulunamadı')),
                ],
              ),
            ),
//my cart page ends here-------------------------------------------------
            const Column(
              children: [Text("sayfa3")],
            ),
          ],
        ),
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
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Ana Sayfa",
                  ),
                  GButton(
                    icon: Icons.shopping_basket,
                    text: "Sepetim",
                  ),
                  GButton(
                    icon: Icons.food_bank_outlined,
                    text: "Siparişlerim",
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
