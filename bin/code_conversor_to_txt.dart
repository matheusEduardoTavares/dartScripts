import 'dart:async';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  stdout.write(
    'Absolute path where is project (caminho absoluto onde está o projeto): ',
  );
  final absolutePath = stdin.readLineSync()!;

  final dir = Directory(absolutePath);

  stdout.write(
    'File extensions i.e .dart (extensão do arquivo que vai trabalhar, por exemplo, .c, .py): ',
  );
  final fileExtension = stdin.readLineSync()!;

  List<FileSystemEntity> entries = dir.listSync(recursive: true).toList()
    ..retainWhere((element) => element.path.endsWith(fileExtension));

  stdout.write(
    'Path with txt to save - i.e: '
    '/media/matheus/Arquivos/flutter/tcc/dengue_tcc/code.txt (caminho junto do'
    ' nome do arquivo que deseja ter o resultado final): ',
  );
  final pathAndFilenameToOutput = stdin.readLineSync()!;
  File outputFile = File(
    pathAndFilenameToOutput,
  );
  outputFile.createSync();

  for (final currentFile in entries) {
    File file = File(currentFile.path);
    final content = await file.readAsString();
    final formattedContent = '${currentFile.path}\n\n$content\n';
    outputFile.writeAsStringSync(formattedContent, mode: FileMode.append);
  }
}
