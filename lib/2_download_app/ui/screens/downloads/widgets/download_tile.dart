import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatefulWidget {
  const DownloadTile({
    super.key,
    required this.controller,
    required this.resources,
  });

  final DownloadController controller;
  final Ressource resources;

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  // TODO
  IconData getIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return Icons.download;
      case DownloadStatus.downloading:
        return Icons.downloading;
      case DownloadStatus.downloaded:
        return Icons.folder;
    }
  }

  double getSize(double progress) {
    return (progress * widget.resources.size);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (builder, child) {
        return Card(
          child: ListTile(
            title: Text(widget.resources.name),
            subtitle: widget.controller.status == DownloadStatus.downloading
                ? Text (
                  '${widget.controller.progress * 100} % completed - ${getSize(widget.controller.progress)} of ${widget.resources.size} MB',
                ) : null,
            trailing: IconButton(
              onPressed: () {
                widget.controller.startDownload();
              },
              icon: Icon(getIcon(widget.controller.status)),
            ),
          ),
        );
      },
    );

    // TODO
  }
}
