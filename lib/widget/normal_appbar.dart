import 'package:flutter/material.dart';
import 'package:krishidost/widget/circular_container.dart';

import '../utility/app_data.dart';

class NormalAppbar extends StatelessWidget {
  const NormalAppbar({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      leadingWidth:60 ,
      backgroundColor: Colors.green,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16,top: 3),
        child: CircularContainer(
            child: Center(
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back,)),
            )),
      ),
      title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color:AppData.darkOrange,fontWeight: FontWeight.w800,fontSize: 24, )
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors:[
            //  Color(0xff01452c),
            Color(0xff025839),
            Color(0xff026c45),
            Color(0xff03925e),
          ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
