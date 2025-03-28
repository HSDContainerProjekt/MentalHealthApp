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
                Text(
                  headline,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Expanded(
                  child: mainBuilder(context),
                ),
                Divider(
                  height: 5,
                  color: Colors.transparent,
                ),
                if (buttons != null)
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: buttons!.length,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        child: ElevatedButton(
                            onPressed: buttons![index].onClick,
                            child: Text(
                              buttons![index].headline,
                              style: Theme.of(context).textTheme.labelSmall,
                            )),
                      ),
                    ),
                  ),
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
