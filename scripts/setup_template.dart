// ignore_for_file: avoid_print
import 'dart:io';

Future<void> main(List<String> args) async {
  final runTests = !args.contains('--skip-tests');
  final runAnalyze = !args.contains('--skip-analyze');

  print('🧰 Setup de plantilla Flutter');
  print('-------------------------------------------');
  print('Directorio actual: ${Directory.current.path}');

  final commands = <_CommandStep>[
    const _CommandStep('flutter', ['pub', 'get'], 'Instalando dependencias'),
    const _CommandStep('flutter', ['gen-l10n'], 'Generando localizaciones'),
    if (runTests)
      const _CommandStep('flutter', ['test'], 'Ejecutando pruebas unit/widget'),
    if (runAnalyze)
      const _CommandStep('flutter', [
        'analyze',
      ], 'Ejecutando análisis estático'),
  ];

  for (final command in commands) {
    final ok = await _runStep(command);
    if (!ok) {
      exitCode = 1;
      print('\n❌ Setup detenido por error en: ${command.title}.');
      print('Tip: puedes omitir pasos con --skip-tests y/o --skip-analyze.');
      return;
    }
  }

  print('\n✅ Setup completado correctamente.');
}

Future<bool> _runStep(_CommandStep step) async {
  print('\n▶ ${step.title}');
  print('   Comando: ${step.executable} ${step.arguments.join(' ')}');

  final process = await Process.start(
    step.executable,
    step.arguments,
    mode: ProcessStartMode.inheritStdio,
    workingDirectory: Directory.current.path,
  );

  final code = await process.exitCode;
  if (code == 0) {
    print('✔ ${step.title}');
    return true;
  }

  print('✖ ${step.title} (exit code: $code)');
  return false;
}

class _CommandStep {
  const _CommandStep(this.executable, this.arguments, this.title);

  final String executable;
  final List<String> arguments;
  final String title;
}
