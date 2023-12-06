import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/shooting/shooting_details.dart';
import '../../components/filter_box.dart';
import '../../components/member_card.dart';
import '../../theme/theme.dart';

class ShootingList extends StatefulWidget {
  const ShootingList({super.key});

  @override
  State<ShootingList> createState() => _nameState();
}

class _nameState extends State<ShootingList> {
  List _category = ["All", "Movies", "Serials", "Advertisements"];
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          title: const Text("Shooting List"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(children: [
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    //  showModal(context);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/filter.svg',
                    color: Theme.of(context).iconTheme.color,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                _buildFilterOption()
              ]),
              SizedBox(
                height: 16.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShootingDetail()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 8.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.3), width: 1)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/banner1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Vacation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "Venkat Pradbhu | 11 Feb '12",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Movie",
                                  style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.bodyTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget _buildFilterOption() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              _category.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                    },
                    child: FilterBox(
                        index: index,
                        selectIndex: _selectIndex,
                        category: _category[index],
                        context: context),
                  )),
        ),
      ),
    );
  }
}
