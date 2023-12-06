
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorCardDetails extends StatelessWidget {
  VendorCardDetails({super.key, required this.vendor});
  var vendor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/camera.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                  vendor["name"],
                  style: Theme.of(context).textTheme.headlineMedium!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 18.h,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(' 4.1',
                      style:
                          Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 14.sp,
                              )),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(' (3.5k)',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 12.sp,
                      color: Theme.of(context).iconTheme.color)),
            ],
          ),
        ],
      ),
    );
  }
}

