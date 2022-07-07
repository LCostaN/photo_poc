import 'package:flutter/material.dart';
import 'package:photo_poc/models/photo.dart';
import 'package:photo_poc/service/photo_service.dart';
import 'package:photo_poc/src/photo_grid_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final extentDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150,
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
  );

  final countDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 20,
    crossAxisSpacing: 20,
  );

  late SliverGridDelegate currentDelegate;
  late List<Photo> photos = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    currentDelegate = extentDelegate;
    WidgetsBinding.instance.addPostFrameCallback((_) => load());
  }

  Future<void> load() async {
    setState(() => loading = true);
    try {
      photos = await PhotoService().fetchData();
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Albums App"),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: IconButton(
              onPressed: changeView,
              icon: const Icon(Icons.change_circle_outlined),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loading ? null : load,
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: currentDelegate,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  var photo = photos[index];

                  return PhotoGridTile(photo: photo);
                },
              ),
      ),
    );
  }

  void changeView() {
    setState(() => currentDelegate =
        currentDelegate == extentDelegate ? countDelegate : extentDelegate);
  }
}