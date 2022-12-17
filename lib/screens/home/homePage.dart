import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thence/dots/categories.dart';
import 'package:thence/entity/Data.dart';
import 'package:thence/resource/color.dart';
import 'package:thence/routers/router.dart';
import 'package:thence/screens/home/controller/homeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeCtrl = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: showBottomNav(),
      appBar: AppBar(
        title: const Text(
          "All plants",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              "assets/svgs/search_svg.svg",
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: ListView(
          children: [
            showTopic(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            loadAndShowData(),
          ],
        ),
      ),
    );
  }

  Widget showTopic() {
    return const Text(
      "Houseplants",
      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 28),
    );
  }

  Widget loadAndShowData() {
    return FutureBuilder(
      future: homeCtrl.getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showAllLoading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return showAllData();
          } else {
            return noDataWidget();
          }
        } else {
          return noDataWidget();
        }
      },
    );
  }

  Widget noDataWidget() {
    return const Center(child: Text("No data"));
  }

  Widget showListData() {
    return Obx(
      () => ListView.builder(
        itemCount: homeCtrl.plants.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Data plantData = homeCtrl.plants[index];
          return InkWell(
            onTap: ()=>Get.toNamed(GetPageRouters.plantScreenPage,arguments: plantData),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    AppColors.unSelectedColor,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.25, 0.75])),
                          child: Hero(
                            tag: plantData.id,
                            child: CachedNetworkImage(
                              imageUrl: plantData.imageUrl,
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              placeholder: (context, url) {
                                return showGreyBox(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.width * 0.2);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(bottom: 5, right: 5, child: showHeart(0))
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            plantData.name,
                            style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/svgs/star_svg.svg"),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                plantData.rating.toStringAsFixed(1),
                                style: const TextStyle(color: AppColors.yellowColor, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${plantData.availableSize[0]} ${plantData.unit}",
                        style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${plantData.price} ${plantData.priceUnit}",
                        style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showLoadingData() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return showDummyListItem();
      },
    );
  }

  Widget showLoadingCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.unSelectedColor),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget showCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: ListView.builder(
                itemCount: DotDatas.categories.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  String catName = DotDatas.categories[index];
                  return Obx(
                    () => InkWell(
                      onTap: () => homeCtrl.changeCatIndex(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeCtrl.selectedCatIndex.value == index ? AppColors.primaryColor : AppColors.unSelectedColor),
                        child: Center(
                          child: Text(
                            catName,
                            style: TextStyle(color: homeCtrl.selectedCatIndex.value == index ? Colors.white : Colors.black, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget showDummyListItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.025),
      child: Row(
        children: [
          showGreyBox(MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.width * 0.25),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showGreyBox(MediaQuery.of(context).size.width * 0.5, 15),
              const SizedBox(
                height: 5,
              ),
              showGreyBox(MediaQuery.of(context).size.width * 0.1, 15),
              const SizedBox(
                height: 15,
              ),
              showGreyBox(MediaQuery.of(context).size.width * 0.1, 15),
            ],
          )
        ],
      ),
    );
  }

  Widget showGreyBox(double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: height,
        color: AppColors.unSelectedColor,
      ),
    );
  }

  Widget showAllLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showLoadingCategory(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: showGreyBox(MediaQuery.of(context).size.width * 0.2, 15),
        ),
        showLoadingData(),
      ],
    );
  }

  Widget showBottomNav() {
    return Obx(
      () => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset("assets/svgs/menu_svg.svg"), label: 'Home'),
            BottomNavigationBarItem(icon: SvgPicture.asset("assets/svgs/cart_svg.svg"), label: 'Cart'),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/heart_svg.svg"),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svgs/user_svg.svg"),
              label: 'User',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: homeCtrl.selectedBottomNavIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: (v) => homeCtrl.updateBotomNavIndex(v),
          elevation: 5),
    );
  }

  Widget showAllData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        showCategory(),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "By popularity",
                style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 12),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_downward_sharp,
                size: 16,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        showListData(),
      ],
    );
  }

  Widget showHeart(double size) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Transform.scale(
          scale: 0.75,
            child: SvgPicture.asset("assets/svgs/heart_svg.svg")),
      ),
    );
  }
}
