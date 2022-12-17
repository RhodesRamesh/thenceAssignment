import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thence/entity/Data.dart';
import 'package:thence/resource/color.dart';
import 'package:thence/screens/plant/controller/plantController.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({Key? key}) : super(key: key);

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  late Data plantData;
  late PlantController plantCtrl;

  @override
  Widget build(BuildContext context) {
    plantData = Get.arguments;
    plantCtrl = PlantController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Hero(
                      tag: plantData.id,
                      child: CachedNetworkImage(
                        imageUrl: plantData.imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        placeholder: (context, url) {
                          return showGreyBox(MediaQuery.of(context).size.width * 0.2, MediaQuery.of(context).size.width * 0.2);
                        },
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 15,
                        child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.black,
                            ))),
                  ],
                ),
              ),
              showPlantDetails(),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.unSelectedColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Transform.scale(scale: 0.75, child: SvgPicture.asset("assets/svgs/bigheart_svg.svg")),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            fixedSize: Size(MediaQuery.of(context).size.width * 0.125, MediaQuery.of(context).size.width * 0.125),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                        child: const Text("Add to Cart"),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
            ],
          ),

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

  Widget showPlantDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                plantData.name,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "${plantData.price} ${plantData.priceUnit}",
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text(
            "Choose Size",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 35,
            child: ListView.builder(
              itemCount: plantData.availableSize.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                int size = plantData.availableSize[index];
                return Obx(
                  () => InkWell(
                    onTap: () => plantCtrl.updateSizeIndex(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: plantCtrl.selectedSizeIndex.value == index ? AppColors.primaryColor : AppColors.unSelectedColor),
                      child: Center(
                        child: Text(
                          "$size ${plantData.unit}",
                          style: TextStyle(color: plantCtrl.selectedSizeIndex.value == index ? Colors.white : Colors.black, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text(
            "Description",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Text(
            plantData.description,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.4)),
            maxLines: null,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
