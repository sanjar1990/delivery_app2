import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foo_delivery/controllers/popular_product_controller.dart';
import 'package:foo_delivery/controllers/recommended_product_controller.dart';
import 'package:foo_delivery/models/product_models.dart';
import 'package:foo_delivery/pages/food/popular_food_detail.dart';
import 'package:foo_delivery/routes/route_helper.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:foo_delivery/utils/colors.dart';
import 'package:foo_delivery/utils/dimensions.dart';
import 'package:foo_delivery/widgets/app_column.dart';
import 'package:foo_delivery/widgets/big_text.dart';
import 'package:foo_delivery/widgets/icon_and_text_widget.dart';
import 'package:foo_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        // print('currentPageValue:  $_currentPageValue');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //Slider page section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          print(popularProducts.popularProductList.length);
          return popularProducts.isLoaded? Container(
            // color: Colors.red,
            height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductList[position], popularProducts.isLoaded);
                  }),

          ) : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        // dots section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
          dotsCount: popularProducts.popularProductList.length<=0?1:popularProducts.popularProductList.length,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
          );
        }),
        // popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: BigText(text: '.', color: Colors.black26,)),
              SizedBox( width:  Dimensions.width10,),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(text: 'Food pairing',
                color: Colors.black26,)),
            ],
          ),
        ),
        //List of food and images
       GetBuilder<RecommendedProductController>(builder: (recommendedProducts){
         return recommendedProducts.isLoaded ? ListView.builder(
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: recommendedProducts.recommendedProductList.length,
             itemBuilder: (context, index){
               return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index,'home'));
                  },
                 child: Container(
                   margin: EdgeInsets.only(
                       left: Dimensions.width20,
                       right: Dimensions.width20,
                       bottom: Dimensions.height10
                   ),
                   child: Row(
                     children: [
                       //image section
                       Container(
                         width: Dimensions.listViewImgSize,
                         height: Dimensions.listViewImgSize,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(Dimensions.radius20),
                             color: Colors.white38,
                             image: DecorationImage(
                                 fit: BoxFit.cover,
                                 image: NetworkImage(
                                     '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${recommendedProducts.recommendedProductList[index].img}')

                             )
                         ),
                       ),
                       //Text info section
                       Expanded(
                         child: Container(
                           height: Dimensions.listViewTextContSize,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.only(
                                 topRight: Radius.circular(Dimensions.radius20),
                                 bottomRight: Radius.circular(Dimensions.radius20),
                               )
                           ),
                           child: Padding(
                             padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 BigText(text: recommendedProducts.recommendedProductList[index].name?? 'no name'),
                                 SmallText(text: 'With chinese characteristics'),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     IconAndTextWidget(
                                         icon: Icons.circle_sharp,
                                         text: 'Normal',
                                         iconColor: AppColors.iconColor1),
                                     IconAndTextWidget(
                                         icon: Icons.location_on,
                                         text: '1.7km',
                                         iconColor: AppColors.mainColor),
                                     IconAndTextWidget(
                                         icon: Icons.access_time_rounded,
                                         text: '32min',
                                         iconColor: AppColors.iconColor2),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),

                     ],
                   ),
                 ),
               );
             }) : CircularProgressIndicator(color: AppColors.mainColor,);
       })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct, bool isLoaded) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          // image section
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index,'home'));
            },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:  NetworkImage('${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${popularProduct.img}')
                  )),
            ),
          ),
          //Info box section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10, right: 15, left: 15),
                child: AppColumn( text: popularProduct.name?? 'No name',),
              ),
            ),
          )
        ],
      ),
    );
  }
}
