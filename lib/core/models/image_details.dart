import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

abstract class ImageDetails{
  const ImageDetails();

  ImageProvider get imageProvider;
}

class FileImageDetails implements ImageDetails {
  final File imageFile;
  const FileImageDetails({required this.imageFile});

  @override
  ImageProvider get imageProvider=>FileImage(imageFile);
}

class NetworkImageDetails implements ImageDetails {
  final String url;
  const NetworkImageDetails({required this.url});

  @override
  ImageProvider get imageProvider=>NetworkImage(url);
}

class AssetsImageDetails implements ImageDetails {
  final String path;
  const AssetsImageDetails({required this.path});

  @override
  ImageProvider get imageProvider=>AssetImage(path);
}

class MemoryImageDetails implements ImageDetails {
  final Uint8List bytes;
  const MemoryImageDetails({required this.bytes});

  @override
  ImageProvider get imageProvider=>MemoryImage(bytes);
}