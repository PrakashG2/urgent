import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadImageColors();
  }

  Color dominantColour = Colors.white;

  List<String> imageLinks = [
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/love-music-red-rose-mixtape-cover-design-template-1ef9655f703c649772b8378aacd969c3_screen.jpg?ts=1617180582",
    "https://img.freepik.com/premium-photo/various-digital-lifestyle-colombia-vector-animation_959624-856.jpg",
    "https://static1.colliderimages.com/wordpress/wp-content/uploads/2022/05/thor-recap-feature.jpg",
    "https://assets.promptbase.com/DALLE_IMAGES%2FdJTbLvp6wn4QiagrVJIJ%2Fresized%2F1693498112845_800x800.webp?alt=media&token=a561e9a1-4eaa-4dbb-b6d3-7ddb453a713e",
    "https://assets.vogue.in/photos/5d9af125d3535f0008d722a9/master/pass/f.jpg",
    "https://img.freepik.com/premium-photo/astronaut-floating-deep-space-with-red-fluid-ink_31965-107582.jpg",
    "https://i.pinimg.com/736x/5d/be/df/5dbedf8e8157fc501a5ac58b4c20f971.jpg",
  ];

  List<Color> gradientColours = [];

  Future<void> _loadImageColors() async {
    for (var i = 0; i < imageLinks.length; i++) {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(imageLinks[i]),
      );
      print(paletteGenerator.dominantColor);
      setState(() {
        gradientColours.add(paletteGenerator.vibrantColor!.color);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listen Now"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Listen Now",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  CircleAvatar(
                    child: Icon(Icons.music_note),
                    // Replace 'Icons.music_note' with the desired icon
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //-----------------------------------------------------------------> UP NEXT SECTION
            const Row(
              children: [
                Text(
                  "Up Next",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Icon(CupertinoIcons.right_chevron),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  imageLinks.length,
                  (index) => Container(
                    height: 355,
                    width: 250,
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: gradientColours.length != imageLinks.length ? Center(child: CircularProgressIndicator(),) : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(imageLinks[index]),
                            height: 1920,
                            width: 1080,
                            fit: BoxFit.fitHeight,
                          ),
                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.white,
                                ],
                                stops: [0.4, 0.2, 0.65],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              height: 1920,
                              width: 1080,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    gradientColours[index],
                                    gradientColours[index],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   height: 55,
                                    //   width: 55,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(50),
                                    //   ),
                                    //   child: ClipRect(child: Image(
                                    //     image: NetworkImage(
                                    //       imageLinks[index],
                                    //     ),fit: BoxFit.cover,
                                    //   ),)
                                    // ),
                                    const Text(
                                      "JUN 15",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Text(
                                      "Pausing for Sudan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    const SizedBox(
                                      width: 200, // Adjust the width as needed
                                      child: Text(
                                        "Pausing for Sudan Pausing for Sudan Pausing for Sudan Pausing for Sudan Pausing for Sudan",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.play_arrow_solid,
                                                size: 15,
                                              ),
                                              Text(
                                                "14 m",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const TextButton(
                                            onPressed: null,
                                            child: Text(
                                              "...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
