import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ch15_photo_sticker/component/emoticon_sticker.dart';
import 'package:ch15_photo_sticker/component/footer.dart';
import 'package:ch15_photo_sticker/component/main_app_bar.dart';
import 'package:ch15_photo_sticker/model/sticker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image; // 선택한 이미지를 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 현재 선택된 스티커의 ID
  GlobalKey imgKey = GlobalKey();

  // 미리 생성해둔 onPickImage() 함수 변경하기
  void onPickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    ); // ➊ 갤러리에서 이미지 선택하기

    setState(() {
      this.image = image; // 선택한 이미지 변수에 저장하기
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        // ➊ 스크린에 Body, AppBar, Footer 순서로 쌓을 준비
        children: [
          renderBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              // ➋ AppBar 위치하기
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          if (image != null) // ➌ image가 선택되면 Footer 위치하기
            Positioned(
              // 맨 아래에 Footer 위젯 위치하기
              bottom: 0,
              left: 0, // left와 right를 모두 0을 주면 좌우로 최대 크기를 차지함
              right: 0,
              child: Footer(onEmoticonTap: onEmoticonTap),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image != null) {
      // ➊ 위젯을 이미지로 저장하기 위해 사용
      // 다른 변경되지 않은 위젯까지 재렌더링을 할 때 렌더링 성능을 최적화시킴
      return RepaintBoundary(
        key: imgKey,
        child: Positioned.fill(
          // InteractiveViewer 이미지 확대할 때
          child: InteractiveViewer(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(File(image!.path), fit: BoxFit.fitWidth),
                // ... spread operator:여러개 항목을 컬렉션에 간편하게 추가.
                ...stickers.map(
                  (sticker) => Center(
                    child: EmoticonSticker(
                      key: ObjectKey(sticker.id),
                      onTransform: () {
                        onTransform(sticker.id);
                      },
                      imgPath: sticker.imgPath,
                      isSelected: selectedId == sticker.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // ➋ 이미지 선택이 안 된 경우 이미지 선택 버튼 표시
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          onPressed: onPickImage,
          child: Text('이미지 선택하기'),
        ),
      );
    }
  }

  // 메인사진에 추가되는 이모티콘 목록을 갱신하는 함수(이모티콘 선택할 때)
  void onEmoticonTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(), // ➊ 스티커의 고유 ID
          imgPath: 'asset/img/emoticon_$index.png',
        ),
      };
    });
  }

  void onSaveImage() async {
    // RepaintBoundary`를 사용하여 렌더링 성능을 최적화
    RenderRepaintBoundary boundary =
        imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(); // ➊ 바운더리를 이미지로 변경
    ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    ); // ➋ byte data 형태로 형태 변경
    Uint8List pngBytes =
        byteData!.buffer.asUint8List(); // ➌ Unit8List : 버퍼 형태로 형태 변경

    await ImageGallerySaverPlus.saveImage(pngBytes, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      // ➋ 저장 후 Snackbar 보여주기
      SnackBar(content: Text('저장되었습니다!')),
    );
  }

  void onDeleteItem() async {
    setState(() {
      stickers =
          stickers
              .where((sticker) => sticker.id != selectedId)
              .toSet(); // ➊ 현재 선택돼 있는 스티커 삭제 후 Set로 변환
    });
  }

  void onTransform(String id) {
    // 스티커가 변형될 때마다 변형 중인 스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }
}
