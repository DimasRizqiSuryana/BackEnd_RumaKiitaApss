import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

enum SourceType {
  local,
  remote,
}

extension SourceTypeX on SourceType {
  bool get isLocal => this == SourceType.local;
  bool get isRemote => this == SourceType.remote;
}

/// FileMetadata
class FileMetadata extends Equatable {
  final SourceType type;

  /// Source file could be a `path`, `url` or anything else
  final String source;

  const FileMetadata({
    required this.type,
    required this.source,
  });

  const FileMetadata.local({
    required this.source,
  }) : type = SourceType.local;

  const FileMetadata.remote({
    required this.source,
  }) : type = SourceType.remote;

  @override
  List<Object?> get props => [type, source];

  Uri get uri {
    if (type.isLocal) {
      return p.toUri(source);
    } else if (type.isRemote) {
      return Uri.parse(source);
    }

    return Uri();
  }

  FileMetadata copyWith({
    SourceType? type,
    String? source,
  }) {
    return FileMetadata(
      type: type ?? this.type,
      source: source ?? this.source,
    );
  }
}

/// Img
///
/// Pre-configured Image widget combined with CachedNetworkImage
///
/// Constructor variants :
/// - `Img()`
/// - `Img.file()`
/// - `Img.filePath()`
/// - `Img.asset()`
/// - `Img.url()`
class Img extends StatefulWidget {
  final FileMetadata? _metadata;
  final File? _file;
  final String? _filePath;
  final String? _assetName;
  final String? _url;
  final double? width;
  final double? height;
  final Alignment alignment;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;

  /// `FileMetadata` as argument
  const Img({
    super.key,
    required FileMetadata metadata,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
  })  : _metadata = metadata,
        _file = null,
        _filePath = null,
        _assetName = null,
        _url = null;

  /// `Image.file()`
  const Img.file({
    super.key,
    required File file,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.placeholder,
    this.errorWidget,
  })  : _metadata = null,
        _file = file,
        _filePath = null,
        _assetName = null,
        _url = null,
        progressIndicatorBuilder = null;

  /// Like `Image.file()` but using `String` path as argument
  const Img.filePath({
    super.key,
    required String path,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.placeholder,
    this.errorWidget,
  })  : _metadata = null,
        _file = null,
        _filePath = path,
        _assetName = null,
        _url = null,
        progressIndicatorBuilder = null;

  /// `Image.asset()`
  const Img.asset({
    super.key,
    required String name,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.placeholder,
    this.errorWidget,
  })  : _metadata = null,
        _file = null,
        _filePath = null,
        _assetName = name,
        _url = null,
        progressIndicatorBuilder = null;

  /// `CachedNetworkImage`
  const Img.url({
    super.key,
    required String url,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
  })  : _metadata = null,
        _file = null,
        _filePath = null,
        _assetName = null,
        _url = url;

  @override
  State<Img> createState() => _ImgState();
}

class _ImgState extends State<Img> {
  String _source = '';

  Widget _placeholderBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (frame == null) {
      if (widget.placeholder != null) {
        return widget.placeholder!(context, _source);
      }
      return Container();
    }

    return child;
  }

  @override
  void initState() {
    super.initState();
    if (widget._file != null) {
      _source = widget._file!.path;
    } else if (widget._filePath != null) {
      _source = widget._filePath!;
    } else if (widget._assetName != null) {
      _source = widget._assetName!;
    } else if (widget._url != null) {
      _source = widget._url!;
    } else if (widget._metadata != null) {
      _source = widget._metadata!.source;
    }
  }

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return widget.errorWidget!(context, widget._assetName!, error);
  }

  Widget _renderFileWidget(File file) {
    return Image.file(
      file,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      fit: widget.fit,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      repeat: widget.repeat,
      matchTextDirection: widget.matchTextDirection,
      frameBuilder: widget.placeholder != null ? _placeholderBuilder : null,
      errorBuilder: widget.errorWidget != null ? _errorBuilder : null,
    );
  }

  Widget _renderFilePathWidget(String path) {
    final file = File(path);
    return _renderFileWidget(file);
  }

  Widget _renderAssetWidget(String name) {
    return Image.asset(
      name,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      fit: widget.fit,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      repeat: widget.repeat,
      matchTextDirection: widget.matchTextDirection,
      frameBuilder: widget.placeholder != null ? _placeholderBuilder : null,
      errorBuilder: widget.errorWidget != null ? _errorBuilder : null,
    );
  }

  Widget _renderUrlWidget(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      fit: widget.fit,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      repeat: widget.repeat,
      matchTextDirection: widget.matchTextDirection,
      placeholder: widget.placeholder,
      progressIndicatorBuilder: widget.progressIndicatorBuilder,
      errorWidget: widget.errorWidget,
    );
  }

  Widget _renderMetadataWidget(FileMetadata metadata) {
    if (metadata.type.isLocal) {
      return _renderFilePathWidget(metadata.source);
    } else if (metadata.type.isRemote) {
      return _renderUrlWidget(metadata.source);
    }

    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._file != null) {
      return _renderFileWidget(widget._file!);
    } else if (widget._filePath != null) {
      return _renderFilePathWidget(widget._filePath!);
    } else if (widget._assetName != null) {
      return _renderAssetWidget(widget._assetName!);
    } else if (widget._url != null) {
      return _renderUrlWidget(widget._url!);
    } else if (widget._metadata != null) {
      return _renderMetadataWidget(widget._metadata!);
    }

    return const Placeholder();
  }
}
