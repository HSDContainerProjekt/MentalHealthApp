import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/software_backbone/routing/routing_constants.dart';
import 'dart:math';

class FriendCollectionMe extends StatelessWidget {
  const FriendCollectionMe({super.key});

  @override
  Widget build(BuildContext context) {
    
    CustomColorWidget colorPickerHairColor = 
    CustomColorWidget(Icons.favorite, "Haarfarbe"); // Haarfarbe
    
    CustomColorWidget colorPickerEyeColor = 
    CustomColorWidget(Icons.remove_red_eye_outlined, "Augenfarbe"); // Augenfarbe
    
    CustomColorWidget colorPickerFavoriteColor = 
    CustomColorWidget(Icons.color_lens, "Lieblingsfarbe"); // Lieblingsfarbe
    EdgeInsets paddingvalue =  EdgeInsets.all(6);

    return SafeArea( 
      child: Scaffold(
      backgroundColor: Colors.white70,
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx < -8) {
            Navigator.pushNamed(context, friendsCollectionBirthdayCalender);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DottedBorder(
              color: Colors.black,
              child: Row(children: [
                    
                  ],)
            ),
            IntrinsicHeight(child: Row(
              children: [
                DottedBorder(
                  color: Colors.black,                  
                  padding: paddingvalue,
                  child: Column(children: [
                    Row(children: [Text("Das ist mein(e) Lieblings:")],),
                  ],)
                ), // Das ist mein(e) lieblings
                IntrinsicWidth(
                  child: 
                    Padding(
                      padding: paddingvalue,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          colorPickerEyeColor,
                          colorPickerHairColor,
                          colorPickerFavoriteColor                      
                        ], 
                      )
                    )
            )],
            ))
          ],
        )
      )
    ));
  }
}

class 
CustomColorWidget extends StatefulWidget {
  final IconData passedIcon;
  final String iconText;
  const 
  CustomColorWidget(this.passedIcon, this.iconText, {super.key});

  @override
  State<
  CustomColorWidget> createState() => _CustomColorPicker();
}

class _CustomColorPicker extends State<
CustomColorWidget> {
  Color pickedColor = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  bool inColorPickingMode = false;

  void changeColor(newColor){
    setState(() {
      pickedColor = newColor;
    });
  }
  
  void pickingColor(){
    setState(() {
      inColorPickingMode = !inColorPickingMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.iconText),
        GestureDetector(
          onTap: (){
            print(pickedColor);
            pickingColor();
            print(inColorPickingMode);
            showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Custom dialog',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'You can use the Dialog widget to create custom dialogs',
                    ),
                    const SizedBox(height: 10,),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('close'),
                    )
                  ],
                ),
              ),
            ),
            );
          },
          child:  
            Container(
              decoration: 
                BoxDecoration(
                  color: pickedColor,
                  shape: BoxShape.circle,   
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0
                  ),
                ),
                child: Icon(widget.passedIcon),
            )
        )
      ]
    );
  }
}

