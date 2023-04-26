import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dice_icons/dice_icons.dart';
import 'package:rachael_mugendi23292024/AllUsersScreen.dart';
import 'CreatePostScreen.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const Feed());
}

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: const Center(
          child: ExampleParallax(),


        ),

        bottomNavigationBar: BottomAppBar(
          color: CupertinoColors.separator,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  //Navigator.pushNamed(context, '/second');
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                   Navigator.pushNamed(context, '/first');
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },

              ),
              IconButton(
                icon:  const Icon(
                  DiceIcons.dice5,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fourth');
                },
              ),

              IconButton(
                icon:  const Icon(
                  Icons.account_balance_sharp,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fifth');
                },
              ),

              IconButton(
                icon:  const Icon(
                  Icons.accessibility,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sixth');
                },
              ),

            ],
          ),
        ),

      ),
    );
  }
}

class ExampleParallax extends StatelessWidget {
  const ExampleParallax({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (final person in persons)
            PersonListItem(
              imageno: person.imageno,
              name: person.name,
              yeargroup: person.yeargroup,
              major: person.major,
              schoolID: person.schoolID,
              movie: person.movie,
              residence: person.residence,


            ),
        ],
      ),
    );
  }

}

class PersonListItem extends StatelessWidget {
  PersonListItem({
    super.key,
    required this.imageno,
    required this.name,
    required this.yeargroup,
    required this.major,
    required this.schoolID,
    required this.movie,
    required this.residence,
  });

  final String imageno;
  final String name;
  final String yeargroup;
  final String major;
  final String schoolID;
  final String movie;
  final String residence;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(
          imageno,
          key: _backgroundImageKey,
          fit: BoxFit.contain,  //come check here
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            schoolID,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            major,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,

            ),
          ),

          Text(
            yeargroup,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            movie,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            residence,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);


  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    super.key,
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
    BoxConstraints.tightFor(width: size.width, height: size.height);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
    localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
    (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}



class Person {
  const Person({
    required this.imageno,
    required this.name,
    required this.yeargroup,
    required this.major,
    required this.schoolID,
    required this.movie,
    required this.residence,
  });

  final String imageno;
  final String name;
  final String yeargroup;
  final String major;
  final String schoolID;
  final String movie;
  final String residence;
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const persons = [
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion1.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion2.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion3.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),

  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion4.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion5.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion6.jpg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
  Person(
    name: 'Safari Mugendi',
    imageno: 'images/fashion7.jpeg',
    yeargroup: '2024',
    major: 'Management Information Systems',
    schoolID: '23292024',
    movie: 'How to get away with murder',
    residence: 'On-campus',
  ),
];