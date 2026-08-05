import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClickableProfileImage extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final Future<String?> Function(File image) onUpload;

  const ClickableProfileImage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onUpload,
  });

  @override
  State<ClickableProfileImage> createState() => _ClickableProfileImageState();
}

class _ClickableProfileImageState extends State<ClickableProfileImage> {
  File? _localImage;
  bool _loading = false;

  Future<void> _pickAndUpload() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() {
      _localImage = File(picked.path);
      _loading = true;
    });

    final url = await widget.onUpload(_localImage!);

    setState(() {
      _loading = false;
      if (url != null) {
        // optionally update UI immediately
      }
    });
  }

  Widget _buildImage() {
    if (_localImage != null) {
      return Image.file(_localImage!, fit: BoxFit.cover);
    }

    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _fallback(),
      );
    }

    return _fallback();
  }

  Widget _fallback() {
    return Center(
      child: Text(
        (widget.name != null && widget.name!.isNotEmpty)
            ? widget.name![0].toUpperCase()
            : "?",
        style: const TextStyle(fontSize: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _loading ? null : _pickAndUpload,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.grey[300],
            child: ClipOval(
              child: SizedBox(
                width: 110,
                height: 110,
                child: _buildImage(),
              ),
            ),
          ),

          if (_loading)
            const Positioned.fill(
              child: CircularProgressIndicator(),
            ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}