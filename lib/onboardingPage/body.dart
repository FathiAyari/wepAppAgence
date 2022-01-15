import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivawgo/home_page.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void onboardingCach() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Onboard', isViewed);
    print(isViewed);
  }

  int currentPage = 0;
  List<Widget> pages = [
    const OnbaordingContent(
      title: "Bienvenue ",
      desc:
          'Triva Go votre application mobile pour gérer votre agence de voyage est à votre disposition',
      image: 'assets/manager.png',
    ),
    const OnbaordingContent(
      title: '',
      desc:
          'Triva Go  est la meilleur solution  pour vous 7/7 24/24. \n Gestion et suivie tout est facile.',
      image: 'assets/time.png',
    ),
    const OnbaordingContent(
      title: "",
      desc:
          'A partir de maintenant vous aves votre agence de voyage dans votre poches \n par un clic .',
      image: 'assets/click.png',
    ),
  ];
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: pages.length,
              scrollDirection: Axis.horizontal, // the axis
              controller: _controller,
              itemBuilder: (context, int index) {
                return pages[index];
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: size.height * 0.01,
                    width: (index == currentPage) ? 25 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (index == currentPage)
                            ? Colors.white
                            : Colors.white.withOpacity(0.5)),
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                        onTap: () async {
                          Get.to(home_page());
                        },
                        child: const Text(
                          'Ignorer',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 50,
                        width: (currentPage == pages.length - 1) ? 150 : 100,
                        child: DirectionMethode(
                            controller: _controller,
                            currentPage: currentPage,
                            pages: pages,
                            press: (currentPage == pages.length - 1)
                                ? () async {
                                    await onboardingCach();
                                    Get.to(home_page());
                                  }
                                : () {
                                    onboardingCach();

                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOutQuint);
                                  }),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class DirectionMethode extends StatelessWidget {
  final Function press;
  const DirectionMethode({
    Key key,
    @required PageController controller,
    @required this.currentPage,
    @required this.pages,
    this.press,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;
  final int currentPage;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: press,
      child: (currentPage == pages.length - 1)
          ? const Text(
              'Commencer',
              style: TextStyle(color: Colors.white),
            )
          : const Text(
              'Suivant',
              style: TextStyle(color: Colors.white),
            ),
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class OnbaordingContent extends StatelessWidget {
  final String title;
  final String image;
  final String desc;
  const OnbaordingContent({
    Key key,
    this.title,
    this.image,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Color(0xff411eae),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.05)),
            ),
            Image.asset(
              image,
              height: size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'NewsCycle-Bold'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
