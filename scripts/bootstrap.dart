// ignore_for_file: avoid_print
import 'dart:io';

final _appNamePattern = RegExp(r'^[a-z][a-z0-9_]*$');
final _orgIdPattern = RegExp(r'^[a-zA-Z]+(\.[a-zA-Z0-9_]+)+$');

void main() async {
  print('🚀 Bootstrap Script - Clona tu plantilla Flutter');
  print('-------------------------------------------');

  stdout.write(
    'Introduce el nombre de la nueva app (solo letras minúsculas y guiones bajos): ',
  );
  final newAppName = stdin.readLineSync()?.trim();

  if (newAppName == null || newAppName.isEmpty) {
    print('❌ El nombre de la app no puede estar vacío.');
    return;
  }

  if (!_appNamePattern.hasMatch(newAppName)) {
    print(
      '❌ Nombre inválido. Usa formato snake_case, iniciando con letra minúscula (ej: mi_app).',
    );
    return;
  }

  stdout.write('Introduce el ID de organización (ej: com.miempresa): ');
  final orgId = stdin.readLineSync()?.trim();

  if (orgId == null || orgId.isEmpty) {
    print('❌ El ID de organización no puede estar vacío.');
    return;
  }

  if (!_orgIdPattern.hasMatch(orgId)) {
    print('❌ ID de organización inválido. Ejemplo válido: com.miempresa');
    return;
  }

  final templatePath = Directory.current.path;
  final parentPath = Directory.current.parent.path;
  final newProjectPath = '$parentPath${Platform.pathSeparator}$newAppName';

  print('\n📂 Origen: $templatePath');
  print('📂 Destino: $newProjectPath');
  print('🆔 Nuevo ID: $orgId.$newAppName');

  final newDir = Directory(newProjectPath);
  if (await newDir.exists()) {
    print('❌ La carpeta de destino ya existe. Abortando.');
    return;
  }

  print('\n⏳ Copiando archivos...');
  await _copyDirectory(Directory(templatePath), newDir);

  print('⏳ Realizando reemplazos de nombres...');
  await _replaceInFiles(newDir, newAppName, orgId);
  await _moveAndroidPackagePath(newDir, orgId, newAppName);

  print('\n✅ ¡Listo! Proyecto creado con éxito en: $newProjectPath');
  print('👉 Recuerda entrar a la carpeta y ejecutar "flutter pub get"');
}

Future<void> _copyDirectory(Directory source, Directory destination) async {
  await destination.create(recursive: true);
  await for (var entity in source.list(recursive: false)) {
    final name = entity.path.split(Platform.pathSeparator).last;

    // Ignorar archivos y carpetas que no queremos copiar
    if (_shouldIgnorePathName(name)) {
      continue;
    }
    if (name == 'scripts') {
      continue; // No copiar el script de bootstrap a la nueva app
    }

    if (entity is Directory) {
      final newDirectory = Directory(
        '${destination.path}${Platform.pathSeparator}$name',
      );
      await _copyDirectory(entity, newDirectory);
    } else if (entity is File) {
      await entity.copy('${destination.path}${Platform.pathSeparator}$name');
    }
  }
}

bool _shouldIgnorePathName(String name) {
  const ignored = {
    '.git',
    '.dart_tool',
    '.idea',
    '.vscode',
    'build',
    'node_modules',
    '.fvm',
  };

  return name.startsWith('.') || ignored.contains(name);
}

Future<void> _replaceInFiles(
  Directory directory,
  String newName,
  String orgId,
) async {
  final oldName =
      'myapp'; // Ajustar si el nombre base de la plantilla es distinto
  final oldId = 'com.example.myapp';
  final newFullId = '$orgId.$newName';

  await for (var entity in directory.list(recursive: true)) {
    if (entity is File) {
      final ext = entity.path.split('.').last;
      final fileName = entity.path.split(Platform.pathSeparator).last;

      // Filtrar tipos de archivos donde queremos reemplazar texto
      if ([
            'dart',
            'yaml',
            'gradle',
            'kts',
            'xml',
            'html',
            'json',
            'md',
          ].contains(ext) ||
          fileName == 'CMakeLists.txt') {
        var content = await entity.readAsString();
        var changed = false;

        if (content.contains(oldName)) {
          content = content.replaceAll(oldName, newName);
          changed = true;
        }
        if (content.contains(oldId)) {
          content = content.replaceAll(oldId, newFullId);
          changed = true;
        }

        if (changed) {
          await entity.writeAsString(content);
        }
      }
    }
  }
}

Future<void> _moveAndroidPackagePath(
  Directory root,
  String orgId,
  String appName,
) async {
  final oldPath = [
    root.path,
    'android',
    'app',
    'src',
    'main',
    'kotlin',
    'com',
    'example',
    'myapp',
  ].join(Platform.pathSeparator);

  final newPath = [
    root.path,
    'android',
    'app',
    'src',
    'main',
    'kotlin',
    ...orgId.split('.'),
    appName,
  ].join(Platform.pathSeparator);

  final oldDir = Directory(oldPath);
  if (!await oldDir.exists()) {
    return;
  }

  final newDir = Directory(newPath);
  await newDir.create(recursive: true);

  await for (final entity in oldDir.list(recursive: false)) {
    if (entity is File) {
      await entity.copy(
        '${newDir.path}${Platform.pathSeparator}${entity.uri.pathSegments.last}',
      );
      await entity.delete();
    }
  }

  await _deleteEmptyParents(oldDir);
}

Future<void> _deleteEmptyParents(Directory directory) async {
  if (!await directory.exists()) {
    return;
  }

  final entities = await directory.list(recursive: false).toList();
  if (entities.isEmpty) {
    final parent = directory.parent;
    await directory.delete();
    if (parent.path != directory.path) {
      await _deleteEmptyParents(parent);
    }
  }
}
