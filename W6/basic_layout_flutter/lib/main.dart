import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter List Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ListExamplesHome(),
    );
  }
}

class ListExamplesHome extends StatefulWidget {
  const ListExamplesHome({super.key});

  @override
  State<ListExamplesHome> createState() => _ListExamplesHomeState();
}

class _ListExamplesHomeState extends State<ListExamplesHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _pages = [
    const BasicListExample(),
    const HorizontalListExample(),
    const GridListExample(),
    const MixedListExample(),
    const SpacedItemsExample(),
    const LongListExample(),
    const FloatingAppBarExample(),
    const ParallaxScrollingExample(),
  ];

  final List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.list), text: 'Basic'),
    const Tab(icon: Icon(Icons.swap_horiz), text: 'Horizontal'),
    const Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
    const Tab(icon: Icon(Icons.view_agenda), text: 'Mixed'),
    const Tab(icon: Icon(Icons.space_bar), text: 'Spaced'),
    const Tab(icon: Icon(Icons.format_list_numbered), text: 'Long'),
    const Tab(icon: Icon(Icons.apps), text: 'Floating'),
    const Tab(icon: Icon(Icons.image), text: 'Parallax'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter List & Effects Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }
}

// 1. Basic List Example
class BasicListExample extends StatelessWidget {
  const BasicListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
          subtitle: Text('Find your way around'),
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
          subtitle: Text('View your photos'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
          subtitle: Text('Make a call'),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email'),
          subtitle: Text('Send a message'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          subtitle: Text('Configure your app'),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          subtitle: Text('Manage your account'),
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favorites'),
          subtitle: Text('Your liked items'),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('History'),
          subtitle: Text('Recent activity'),
        ),
      ],
    );
  }
}

// 2. Horizontal List Example
class HorizontalListExample extends StatelessWidget {
  const HorizontalListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160,
            color: Colors.red,
            child: const Center(
              child: Text('Red', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Container(
            width: 160,
            color: Colors.blue,
            child: const Center(
              child: Text('Blue', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Container(
            width: 160,
            color: Colors.green,
            child: const Center(
              child: Text('Green', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Container(
            width: 160,
            color: Colors.yellow,
            child: const Center(
              child: Text('Yellow', style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
          Container(
            width: 160,
            color: Colors.orange,
            child: const Center(
              child: Text('Orange', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          Container(
            width: 160,
            color: Colors.purple,
            child: const Center(
              child: Text('Purple', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. Grid List Example
class GridListExample extends StatelessWidget {
  const GridListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(100, (index) {
        return Center(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade300),
            ),
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        );
      }),
    );
  }
}

// 4. Mixed List Example
class MixedListExample extends StatelessWidget {
  const MixedListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<ListItem>.generate(
      1000,
      (i) => i % 6 == 0
          ? HeadingItem('Heading $i')
          : MessageItem('Sender $i', 'Message body $i'),
    );

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}

// 5. Spaced Items Example
class SpacedItemsExample extends StatelessWidget {
  const SpacedItemsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemWidget(text: 'Item 1'),
                ItemWidget(text: 'Item 2'),
                ItemWidget(text: 'Item 3'),
                ItemWidget(text: 'Item 4'),
                ItemWidget(text: 'Item 5'),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 6. Long List Example
class LongListExample extends StatelessWidget {
  const LongListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10000, (i) => 'Item $i');

    return ListView.builder(
      itemCount: items.length,
      prototypeItem: ListTile(title: Text(items.first)),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped on ${items[index]}')),
            );
          },
        );
      },
    );
  }
}

// Helper classes for Mixed List Example
abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

// Helper widget for Spaced Items Example
class ItemWidget extends StatelessWidget {
  final String text;

  const ItemWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

// 7. Floating App Bar Example
class FloatingAppBarExample extends StatelessWidget {
  const FloatingAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Floating App Bar'),
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Pull to Expand'),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade600,
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.cloud,
                  size: 80,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('${index + 1}'),
            ),
            title: Text('Item #${index + 1}'),
            subtitle: Text('This is the subtitle for item ${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on Item ${index + 1}')),
              );
            },
          ),
        ),
      ],
    );
  }
}

// 8. Parallax Scrolling Example
class ParallaxScrollingExample extends StatelessWidget {
  const ParallaxScrollingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ParallaxRecipe();
  }
}

class ParallaxRecipe extends StatelessWidget {
  const ParallaxRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final location in locations)
            LocationListItem(
              imageUrl: location.imageUrl,
              name: location.name,
              country: location.place,
            ),
        ],
      ),
    );
  }
}

@immutable
class LocationListItem extends StatelessWidget {
  LocationListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.country,
  });

  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 50),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            country,
            style: const TextStyle(color: Colors.white, fontSize: 14),
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
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(
      0.0,
      1.0,
    );

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(
      backgroundSize,
      Offset.zero & listItemSize,
    );

    // Paint the background.
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0.0, childRect.top),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

// Sample data for parallax scrolling
class Location {
  const Location({
    required this.name,
    required this.place,
    required this.imageUrl,
  });

  final String name;
  final String place;
  final String imageUrl;
}

const urlPrefix = 'https://images.unsplash.com/photo-';

const locations = [
  Location(
    name: 'Mount Rushmore',
    place: 'U.S.A',
    imageUrl: '${urlPrefix}1506905925171-a22f0f8a3e3f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'Vitznau',
    place: 'Switzerland',
    imageUrl: '${urlPrefix}1493246507139-91e8fad9978e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'Beirut',
    place: 'Lebanon',
    imageUrl: '${urlPrefix}1519452575417-564c1401ecc0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'Barcelona',
    place: 'Spain',
    imageUrl: '${urlPrefix}1539037116219-da62b02e4ce8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'Nairobi',
    place: 'Kenya',
    imageUrl: '${urlPrefix}1570127353909-38b44d30af71?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'Cairo',
    place: 'Egypt',
    imageUrl: '${urlPrefix}1539650116574-75c0c6d76648?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
  Location(
    name: 'New York',
    place: 'U.S.A',
    imageUrl: '${urlPrefix}1496442226666-8d4d0e62e6e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ),
];
