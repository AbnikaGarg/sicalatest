import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/components/gallery_card.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/employeement_schema/job_provider.dart';
import 'package:sica/views/employeement_schema/job_seeker.dart';
import 'package:sica/views/home/seeAllFeatures.dart';
import 'package:sica/views/home/select_form_reason.dart';
import 'package:sica/views/shooting/dop_list.dart';
import '../../components/buton.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../forum/select_forum_type.dart';
import '../funds/funds.dart';
import '../gallery/gallery_list.dart';
import '../members/members.dart';
import '../news/news_tab.dart';
import '../operators/operators.dart';
import '../shooting/create_dop.dart';
import '../shooting/create_shooting.dart';
import '../shooting/shooting_details.dart';
import '../shooting/shooting_list.dart';
import '../vendors/vendors.dart';
import 'about_sica.dart';
import 'components/drawer.dart';
import 'components/select_card.dart';
import 'form.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  int _selectIndex = 0;
  List<Choice> guestChoice = <Choice>[
    Choice(title: 'About Sica', svg: "about", page: const AboutSica()),
    Choice(
        title: 'Employment schema',
        svg: "employement",
        page: const SelectForumType()),
    Choice(
        title: 'Discussion Forum', svg: "forum", page: const SelectForumType()),
  ];
  List<Choice> choices = <Choice>[
    Choice(title: 'About Sica', svg: "about", page: const AboutSica()),
    Choice(title: 'All Members', svg: "member", page: const Members()),
    Choice(
        title: 'Discussion Forum', svg: "forum", page: const SelectForumType()),
    Choice(
        title: 'Employment schema',
        svg: "employement",
        page: const SelectForumType()),
    Choice(
        title: 'Shooting  Diary', svg: "camera", page: const SelectForumType()),
    Choice(title: 'Vendors', svg: "vendors", page: const Vendors()),
    Choice(title: 'Operators', svg: "member", page: const Operators()),
    Choice(title: 'Fund', svg: "hand", page: const Funds()),
    Choice(title: 'Support', svg: "viewall", page: SelectReason()),
  ];
  List forumType = [
    {"title": "WEBSITE LAUNCH", "image": "assets/images/website.png"},
    {"title": "SICA AGM 2021", "image": "assets/images/agm.png"},
    {"title": "MEETING", "image": "assets/images/meeting.png"},
    {"title": "WORKSHOP", "image": "assets/images/workshop.png"}
  ];
  List newsList = [
    {
      "title": "Christopher Nolan and Imax Film!",
      "image": "assets/images/news1.jpg",
      "dis":
          "Imax format though was introduced during late 1970’s during expo and a film made on using Imax camera and film is TIGER CHILD. Imax is very much different from Cinemascope and 70 mm formats where screen and aspect ratio are broader, the uniqueness of Imax is its Height. Approx.  screen",
      "date": "Jul 19 2023"
    },
    {
      "title": "Laowa Cinema Zoom Lenses/Anamorphic Primes!",
      "image": "assets/images/news2.jpg",
      "dis":
          "Venus Optics are formed by a group of passionate industry experts and photographers who wish to create Unique, Practical & Affordable lenses, Laowa got wide applause for its Probe Lenses designed for Cinematography. Laowa recently has brought Two Zoom lenses for cinematography which covers Full frame Sensor, The Ranger Compact",
      "date": "Jul 17 2023"
    },
    {
      "title": "10 common mistakes: Screen Writer’s!",
      "image": "assets/images/news3.jpg",
      "dis":
          "10 common mistakes that most Film Script Writers do; 1. Story idea is different from the screenplay – The Writer gets motivated by an idea or an event. While writing the screenplay, the main moral is diluted by the overlapping of another powerful idea. 2. Wrong Narrative Style",
      "date": "Jul 15 2023"
    },
  ];
  List _category = ["All", "News", "Blogs", "Tech Talks"];
  List events = [
    {
      "title": "Film Camera Training part1",
      "date": "March 02 2023",
      "duration": "6 Weeks",
      "author": "By P.C.Sreeram",
      "rupess": "800",
      "image": "assets/images/sicaevent1.png"
    },
    {
      "title": "Cinematography",
      "date": "March 08 2023",
      "duration": "1 Daye",
      "author": "By Arul",
      "rupess": "1000",
      "image": "assets/images/sicaevent2.png"
    },
    {
      "title": "Laser Projection",
      "date": "March 15 2023",
      "duration": "1 Weeks",
      "author": "By M. Ilavarasu",
      "rupess": "1800",
      "image": "assets/images/sicaevent3.png"
    }
  ];
  List featured = [
    {
      "name": "Balu Mahendra",
      "awards": "National Award Winner",
      "image": "assets/images/a.png"
    },
    {
      "name": "Marcus Bartley",
      "awards": "National Award Winner",
      "image": "assets/images/b.png"
    },
    {
      "name": "Madhu Ambat",
      "awards": "National Award Winner",
      "image": "assets/images/c.png"
    },
    {
      "name": "P.C.Sreeram",
      "awards": "National Award Winner",
      "image": "assets/images/d.png"
    },
    {
      "name": "B.Kannan",
      "awards": "State Award Winner",
      "image": "assets/images/e.png"
    },
    {
      "name": "Santosh Sivan",
      "awards": "State Award Winner",
      "image": "assets/images/f.png"
    },
    {
      "name": "Chota K Naidu",
      "awards": "State Award Winner",
      "image": "assets/images/g.png"
    },
    {
      "name": "S. Ramachandra",
      "awards": "State Award Winner",
      "image": "assets/images/h.png"
    },
  ];
  List bannerImages = [];
  
  _launchURLBrowser() async {
    const url = 'http://thesica.in/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
 
  void getImages() {
    final service = MemberRepo();
    service.getBannerImages().then((value) {
      if (value.isNotEmpty) {
        bannerImages = value;
      
        if (mounted) setState(() {});
      }
    });
  }

  // this variable determnines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    getDettails();
     getImages();
    super.initState();
  }

  String? accountType = "";
  Future<void> getDettails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountType = (sharedPreferences.getString('accounttype') ?? "");
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton.small(
              backgroundColor: AppTheme.darkPrimaryColor,
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward_rounded),
            ),
      drawer: NavBar(),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            Images.logo2,
            fit: BoxFit.cover,
            height: 40.h,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  // color: AppTheme.bodyTextColor,
                )),
          ]),
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if(bannerImages.isNotEmpty)
              CarouselSlider.builder(
                  itemCount: bannerImages[0].length,
                  itemBuilder: (context, index, realIndex) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                bannerImages[0][index]["photo_details"]["image"],
                                fit: BoxFit.cover,
                                // color: Color(0x66000000),
                                // colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    //  height: getProportionateScreenHeight(300),
                    aspectRatio: 16 / 7,
                    enlargeCenterPage: true,

                    viewportFraction: 0.9,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },

                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    // autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    // onPageChanged: pageController,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,

                    scrollDirection: Axis.horizontal,
                  )),
                  if(bannerImages.isNotEmpty)
              DotsIndicator(
                dotsCount:  bannerImages[0].length,
                position: _currentIndex,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeColor: Theme.of(context).primaryColor,
                  activeSize: const Size(18.0, 9.0),
                  color: AppTheme.darkPrimaryColor.withOpacity(0.3),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              if (accountType == "1")
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SeeAllFeatures()));
                      },
                      child: Text(
                        "View all",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 14.sp,
                                color: const Color.fromRGBO(205, 192, 158, 1)),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 14.h,
                    childAspectRatio: 1 / 0.8,
                    children: accountType == "1"
                        ? List.generate(choices.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == 3) {
                                  showModal(context);
                                } else if (index == 4) {
                                  showModal2(context);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          choices[index].page));
                                }
                              },
                              child: SelectCard(
                                title: choices[index].title,
                                svg: choices[index].svg,
                              ),
                            );
                          })
                        : List.generate(guestChoice.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == 1) {
                                  showModal(context);
                                } else if (index == 3) {
                                  showModal2(context);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          guestChoice[index].page));
                                }
                              },
                              child: SelectCard(
                                title: guestChoice[index].title,
                                svg: guestChoice[index].svg,
                              ),
                            );
                          })),
              ),
              SizedBox(
                height: 5.h,
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: List.generate(
              //         _category.length,
              //         (index) => GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                //   _selectIndex = index;
              //                 });
              //               },
              //               child: FilterBox(
              //                   index: index,
              //                   selectIndex: 0,
              //                   category: _category[index],
              //                   context: context),
              //             )),
              //   ),
              // ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF383838),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeadLine("Latest Updates", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsTabBarWidget(),
                        ),
                      );
                    }),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                            _category.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectIndex = index;
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 14.w : 10.w),
                                      decoration: BoxDecoration(
                                        color: _selectIndex == index
                                            ? Theme.of(context).primaryColor
                                            : AppTheme.whiteBackgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                        border: _selectIndex == index
                                            ? Border.all(
                                                width: 1.0,
                                                color: Theme.of(context)
                                                    .primaryColor)
                                            : Border.all(
                                                width: 1.0,
                                                color: Colors.grey
                                                    .withOpacity(0.5)),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.w, vertical: 4.h),
                                          child: Text(_category[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      color: AppTheme
                                                          .darkTextColor,
                                                      height: 0)))),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(newsList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: index == 0 ? 0 : 12.w,
                                    bottom: 10.h,
                                    top: 5.h),
                                child: NewCard(news: newsList[index]));
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // _buildHeadLine("Events", () {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MyDashBoard(currentIndex: 1),
              //     ),
              //   );
              // }),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: List.generate(events.length, (index) {
              //       return Padding(
              //           padding: EdgeInsets.only(
              //             left: 8.w,
              //           ),
              //           child: SizedBox(
              //             width: 300.w,
              //             child: EventCard(events: events[index]),
              //           ));
              //     }),
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),

              SizedBox(
                height: 20.h,
              ),
              Divider(
                color: AppTheme.darkTextColor,
                height: 0,
              ),
              Container(
                height: 130.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/awards.png")),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SICA Awards",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: AppTheme.whiteBackgroundColor,
                                    fontSize: 18.sp),
                          ),
                          Text(
                            "Vote for your Favorite Artists",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: AppTheme.whiteBackgroundColor,
                                    fontSize: 10.sp),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 74, 144, 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 6.h),
                          child: Text(
                            "Vote now",
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: AppTheme.whiteBackgroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildHeadLine("Featured", () {}),
              Container(
                width: double.infinity,
                //color: AppTheme.whiteBackgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(featured.length, (index) {
                      return Padding(
                          padding: EdgeInsets.only(left: 12.w, bottom: 10.h),
                          child: FeaturedCard(featured: featured[index]));
                    }),
                  ),
                ),
              ),

              SizedBox(
                height: 10.h,
              ),

              _buildAwards(),
              SizedBox(
                height: 20.h,
              ),
              _buildHeadLine("Gallery", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryList(),
                  ),
                );
              }),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  )),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                // color: AppTheme.whiteBackgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(forumType.length, (index) {
                      return Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                          ),
                          child: GalleryWidget(galleryList: forumType[index]));
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          )),
    );
  }

  _buildAwards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 220.h,
            color: const Color.fromRGBO(143, 43, 11, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Merchandise",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: AppTheme.whiteBackgroundColor, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Buy SICA Products",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppTheme.whiteBackgroundColor, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      child: Text(
                        "Shop now",
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: AppTheme.whiteBackgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 220.h,
          width: MediaQuery.of(context).size.width / 2.1,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/images/shop.png")),
          ),
        ),
      ],
    );
  }

  Widget _buildHeadLine(String title, VoidCallback onTouch) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontSize: 18.sp),
          ),
          GestureDetector(
            onTap: onTouch,
            child: Text(
              "See all",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(205, 192, 158, 1)),
            ),
          )
        ],
      ),
    );
  }

  void showModal2(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 12.h),
                          //   child: Text(
                          //     "Shooting Dairy",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .headlineLarge!
                          //         .copyWith(fontSize: 18.sp),
                          //   ),
                          // ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 CreateShooting()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            CupertinoIcons.video_camera_solid,
                                            color: AppTheme.bodyTextColor,
                                            size: 30.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Shooting",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 50,),
                                GestureDetector(
                                  onTap: () {
                                   Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateDOP(associateList: [],)));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            CupertinoIcons
                                                .plus_square_fill_on_square_fill,
                                            color: AppTheme.bodyTextColor,
                                            size: 24.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("DOP",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.of(context).pushReplacement(
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 const ShootingList()));
                                //   },
                                //   child: Column(
                                //     children: [
                                //       Container(
                                //           height: 60.h,
                                //           width: 60.h,
                                //           alignment: Alignment.center,
                                //           decoration: BoxDecoration(
                                //               color: Theme.of(context)
                                //                   .primaryColor,
                                //               shape: BoxShape.circle),
                                //           child: Icon(
                                //             Icons.list_rounded,
                                //             color: AppTheme.bodyTextColor,
                                //             size: 26.sp,
                                //           )),
                                //       SizedBox(
                                //         height: 8.h,
                                //       ),
                                //       Text("List",
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodySmall!
                                //               .copyWith(fontSize: 12.sp)),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(width: 50,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShootingDopApproval()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60.h,
                                          width: 60.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.approval_rounded,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Approval",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 12.sp)),
                                    ],
                                  ),
                                ),
                            ]),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              "Employment Schema",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 18.sp),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const JobSeeker()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50.h,
                                          width: 50.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.person_search,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Job Seeker",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const JobProviders()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 50.h,
                                          width: 50.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.person_sharp,
                                            color: AppTheme.bodyTextColor,
                                            size: 26.sp,
                                          )),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text("Job provider",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!),
                                    ],
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }
}

class NewCard extends StatelessWidget {
  NewCard({super.key, required this.news});
  var news;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade300,
          //     offset: Offset(
          //       0.0,
          //       0.0,
          //     ),
          //     blurRadius: 2.0,
          //   ),
          // ],
        ),
        width: 220.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.h,
              width: 220.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage(news["image"])),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              child: Text(
                news["title"],
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Text(
                news["dis"],
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 12.sp),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RoundedButton(
                  height: 40,
                  ontap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtpScreen(),
                    //   ),
                    // );
                  },
                  title: "Read more",
                  color: Theme.of(context).primaryColor,
                  textcolor: AppTheme.whiteBackgroundColor),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ));
  }
}

class FeaturedCard extends StatelessWidget {
  FeaturedCard({super.key, required this.featured});
  var featured;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(
                0.0,
                0.0,
              ),
              blurRadius: 2.0,
            ),
          ],
        ),
        width: 135.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180.h,
              width: 135.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(featured["image"].toString())),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              child: Text(
                featured["name"].toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Text(
                featured["awards"].toString(),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 10.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ));
  }
}
