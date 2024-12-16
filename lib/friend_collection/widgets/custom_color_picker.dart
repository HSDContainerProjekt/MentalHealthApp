import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; 

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(body:
        Center(child:
          BlockPicker(
            pickerColor: Colors.red, //default color
            onColorChanged: (Color color){ //on the color picked
                print(color);
            }, 
          ) 
        )
            
      );
  }
}