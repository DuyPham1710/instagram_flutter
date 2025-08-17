import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoPickerScreen extends StatefulWidget {
  const PhotoPickerScreen({super.key});

  @override
  State<PhotoPickerScreen> createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  List<AssetEntity> images = [];
  List<AssetPathEntity> albums = [];
  List<AssetEntity> selectedImages = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    // xin quyền
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) {
      PhotoManager.openSetting();
      return;
    }

    // lấy album
    albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    // lấy ảnh trong album
    if (albums.isNotEmpty) {
      images = await albums[0].getAssetListPaged(page: 0, size: 100);
      setState(() {});
    }
  }

  void _toggleSelect(AssetEntity asset) {
    setState(() {
      if (selectedImages.contains(asset)) {
        selectedImages.remove(asset);
      } else {
        selectedImages.add(asset);
      }
    });
  }

  void _done() {
    //    print("Selected ${selectedImages.length} images");
    Navigator.pop(context, selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Select Photos",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          if (selectedImages.isNotEmpty)
            TextButton(
              onPressed: _done,
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: images.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final asset = images[index];
                  return FutureBuilder<Uint8List?>(
                    future: asset.thumbnailDataWithSize(
                      const ThumbnailSize(200, 200),
                    ),
                    builder: (_, snapshot) {
                      final bytes = snapshot.data;
                      if (bytes == null) return const SizedBox();
                      final isSelected = selectedImages.contains(asset);
                      return GestureDetector(
                        onTap: () => _toggleSelect(asset),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.memory(bytes, fit: BoxFit.cover),
                            if (isSelected)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 0),
                                  ),
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.blueAccent,
                                    size: 28,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
