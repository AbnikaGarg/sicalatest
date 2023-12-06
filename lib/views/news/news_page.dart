import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTab extends StatelessWidget {
  NewsTab({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16.h,
        ),
        ListView.builder(
          itemCount: newsList.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsList[index]["date"],
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 12.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        newsList[index]["title"],
                        style: Theme.of(context).textTheme.displayMedium!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        newsList[index]["dis"],
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            image: AssetImage(newsList[index]["image"])),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
