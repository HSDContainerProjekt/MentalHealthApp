import 'package:flutter/material.dart';

class PostIt extends StatelessWidget {
  final String headline;
  final WidgetBuilder mainBuilder;

  final List<PostItButton>? buttons;

  const PostIt(
      {super.key,
      required this.headline,
      required this.mainBuilder,
      this.buttons});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/postit.png"),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              children: [
                Text(headline),
                Expanded(
                  child: mainBuilder(context),
                ),
                if (buttons != null)
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: buttons!.length,
                      itemBuilder: (context, index) => TextButton(
                          onPressed: buttons![index].onClick,
                          child: Text(buttons![index].headline)),
                    ),
                  )
              ],
            ),
          )),
    );
  }
}

class PostItButton {
  final String headline;
  final VoidCallback onClick;

  PostItButton({required this.headline, required this.onClick});
}
