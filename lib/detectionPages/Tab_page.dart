import 'package:flutter/material.dart';
import 'package:krishidost/detectionPages/preservativepredict.dart';

import 'cropdisease.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  void press() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("pridicttion"),
      ),
      body: GridView(
        padding:const EdgeInsets.all(8),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 150,
            childAspectRatio: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        children: [

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const PredictPage(),),);
            },
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
               shadowColor: Colors.black54,
               elevation: 12,
              child:Container(
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20),),
                ),

                child: const Center(child:Text("Crop disease detection",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),),
              )
            ),
          ),
      GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ignore: non_constant_identifier_names
                    builder: (BuildContext) => const CropPredictionForm(),
                  ),
                );
              },
             child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  shadowColor: Colors.black54,
                  elevation: 12,
                  child:Container(
                    decoration:const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20),),
                    ),

                    child:const  Center(child:Text("preservative predict",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),),
                  )
              ),
            ),
        ],
      ),
    );
  }
}


