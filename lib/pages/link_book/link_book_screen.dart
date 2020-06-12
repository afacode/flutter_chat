import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LinkBookScreen extends StatefulWidget {
  @override
  _LinkBookScreenState createState() => _LinkBookScreenState();
}

class _LinkBookScreenState extends State<LinkBookScreen> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appSupportDirectory;
  Future<Directory> _appLibraryDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;
  Future<List<Directory>> _externalStorageDirectories;
  Future<List<Directory>> _externalCacheDirectories;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data.path}');
      } else {
        text = const Text('path unavailable');
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  Widget _buildDirectories(
      BuildContext context, AsyncSnapshot<List<Directory>> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        final String combined =
            snapshot.data.map((Directory d) => d.path).join(', ');
        text = Text('paths: $combined');
      } else {
        text = const Text('path unavailable');
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestAppLibraryDirectory() {
    setState(() {
      _appLibraryDirectory = getLibraryDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  void _requestExternalStorageDirectories(StorageDirectory type) {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories(type: type);
    });
  }

  void _requestExternalCacheDirectories() {
    setState(() {
      _externalCacheDirectories = getExternalCacheDirectories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: const Text('获取临时路径'),
              onPressed: _requestTempDirectory,
            ),
          ),
          FutureBuilder<Directory>(
              future: _tempDirectory, builder: _buildDirectory),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: const Text('获取APP路径'),
              onPressed: _requestAppDocumentsDirectory,
            ),
          ),
          FutureBuilder<Directory>(
              future: _appDocumentsDirectory, builder: _buildDirectory),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: const Text('获取APP支持的文件路径'),
              onPressed: _requestAppSupportDirectory,
            ),
          ),
          FutureBuilder<Directory>(
              future: _appSupportDirectory, builder: _buildDirectory),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: const Text('Get Application Library Directory'),
              onPressed: _requestAppLibraryDirectory,
            ),
          ),
          FutureBuilder<Directory>(
              future: _appLibraryDirectory, builder: _buildDirectory),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text(
                  '${Platform.isIOS ? "外部存储不可用 " "在iOS" : "获取外部存储路径"}'),
              onPressed:
                  Platform.isIOS ? null : _requestExternalStorageDirectory,
            ),
          ),
          FutureBuilder<Directory>(
              future: _externalDocumentsDirectory, builder: _buildDirectory),
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text(
                    '${Platform.isIOS ? "External directories are unavailable " "on iOS" : "获取外部存储目录"}'),
                onPressed: Platform.isIOS
                    ? null
                    : () {
                        _requestExternalStorageDirectories(
                          StorageDirectory.music,
                        );
                      },
              ),
            ),
          ]),
          FutureBuilder<List<Directory>>(
              future: _externalStorageDirectories, builder: _buildDirectories),
          Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text(
                    '${Platform.isIOS ? "External directories are unavailable " "on iOS" : "获取外部缓存目录"}'),
                onPressed:
                    Platform.isIOS ? null : _requestExternalCacheDirectories,
              ),
            ),
          ]),
          FutureBuilder<List<Directory>>(
              future: _externalCacheDirectories, builder: _buildDirectories),
        ],
      ),
    );
  }
}
