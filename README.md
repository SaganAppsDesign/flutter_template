# Flutter Premium Template 🚀

Plantilla base para proyectos Flutter con foco en **Productividad**, **Escalabilidad** y **Estética Premium**.

La base técnica combina:

- **Clean Architecture**
- **MVVM**
- **POO**

## 🎯 Objetivo de este README

Este documento funciona como contrato técnico del proyecto:

- Define la arquitectura y límites entre capas.
- Estandariza estilo, i18n, responsive y testing.
- Acelera el onboarding de nuevos integrantes.

---

## 🏛️ Arquitectura del proyecto

La app está organizada en cuatro capas dentro de `lib/`.

### 1) `domain/` (Negocio)

Núcleo de la aplicación. **No depende** de frameworks, UI ni SDKs externos.

- **Entities**: modelos puros de negocio.
- **Repositories (abstractos)**: contratos de acceso a datos.
- **UseCases**: reglas y operaciones de negocio.

### 2) `data/` (Datos)

Implementa los contratos del dominio.

- **Models**: mapeos/serialización.
- **DataSources**: Firebase, API, local DB, etc.
- **RepositoriesImpl**: implementación concreta de `domain/repositories`.

### 3) `presentation/` (UI)

Pantallas y estado de interfaz.

- **ViewModels**: estado de vistas con `ChangeNotifier` + `Provider`.
- **Views/Screens**: composición de pantallas.
- **Widgets**: componentes reutilizables de UI.

### 4) `core/` (Infraestructura compartida)

Servicios y utilidades transversales.

- **DI**: `GetIt`.
- **Navigation**: `GoRouter`.
- **Network**: cliente HTTP (`Dio`).
- **Config/Theme/Constants/Errors**: soporte común del proyecto.

---

## 🔒 Reglas de dependencia (obligatorias)

### Flujo permitido

- `presentation` → `domain`
- `data` → `domain`
- `core` → usado por todas las capas

### Flujo NO permitido

- `domain` → `data` o `presentation`
- `presentation` → `data` directamente
- Lógica de negocio dentro de widgets

> Regla práctica: toda regla de negocio vive en `usecases`; la UI sólo orquesta y renderiza.

---

## 🧱 Estructura recomendada por feature

```text
lib/
    domain/
        entities/
        repositories/
        usecases/
    data/
        models/
        datasources/
        repositories/
    presentation/
        viewmodels/
        views/
        widgets/
    core/
        config/
        navigation/
        network/
        di/
```

---

## 🚀 Inicio rápido (proyecto actual)

1. Instalar dependencias:

```bash
flutter pub get
```

2. Configurar Firebase (si aplica al entorno):

```bash
flutterfire configure
```

3. Ejecutar la app en **dev** (sin Firebase por defecto):

```bash
flutter run
```

4. Ejecutar en **prod** con configuración por entorno:

```bash
flutter run --dart-define=APP_ENV=prod --dart-define=ENABLE_FIREBASE=true --dart-define=API_BASE_URL=https://api.tudominio.com
```

5. Generar localizaciones (si cambias archivos ARB):

```bash
flutter gen-l10n
```

---

## ⚡ Uso como plantilla (bootstrap)

Para crear una nueva app basada en esta plantilla sin tocar el código original:

```bash
dart scripts/bootstrap.dart
```

Luego ingresa:

- Nombre de app
- ID de organización

### Reglas del bootstrap

- `appName` debe usar `snake_case` (ej: `mi_app`).
- `orgId` debe usar formato de dominio invertido (ej: `com.miempresa`).
- El script omite carpetas de build/herramientas (`build`, `.dart_tool`, `.git`, etc.).
- Ajusta reemplazos de nombre/ID y reorganiza el paquete Android (`MainActivity.kt`) al nuevo namespace.

### Post-bootstrap recomendado

En el proyecto recién creado, ejecuta:

```bash
dart scripts/setup_template.dart
```

Opciones rápidas:

```bash
dart scripts/setup_template.dart --skip-tests
dart scripts/setup_template.dart --skip-analyze
```

Este script automatiza:

- `flutter pub get`
- `flutter gen-l10n`
- `flutter test`
- `flutter analyze`

---

## 🛠️ Stack incluido

- **State Management**: `Provider` + `ChangeNotifier`
- **DI**: `GetIt`
- **Routing**: `GoRouter`
- **Networking**: `Dio`
- **UI**: Material 3 + Google Fonts
- **Backend**: Firebase (Auth + Firestore)
- **i18n**: multi-idioma (`en`/`es`)

---

## 🌍 Convenciones de i18n

- No hardcodear textos en UI.
- Centralizar claves de texto en recursos de localización.
- Mantener consistencia de naming por módulo/feature.
- Considerar pluralización y textos dinámicos desde el inicio.

---

## 🎨 Guía de estilo

- Usar `ColorScheme.fromSeed` (sin hardcodear nuevos colores fuera del sistema).
- Mantener tipografía oficial del proyecto (`Outfit`).
- Reutilizar widgets de `presentation/widgets` antes de crear nuevos.
- Mantener diseño responsive para móvil, tablet y desktop.
- Conservar coherencia visual entre pantallas nuevas y existentes.

---

## ✅ Calidad mínima por feature (Definition of Done)

Una tarea se considera terminada cuando cumple:

- [ ] Arquitectura respetada (sin romper reglas de dependencia)
- [ ] Textos internacionalizados
- [ ] Comportamiento responsive validado
- [ ] Tests agregados/actualizados (unit/widget según aplique)
- [ ] `flutter analyze` sin issues críticos
- [ ] Navegación y estados de error contemplados

---

## 🧭 Configuración de entorno (plantilla)

La plantilla utiliza `AppConfig.fromEnvironment()` con `--dart-define`:

- `APP_ENV`: `dev` (default) o `prod`
- `API_BASE_URL`: URL base de API (opcional)
- `ENABLE_FIREBASE`: `true/false` (default `false`)

Ejemplo recomendado para CI/CD:

```bash
flutter build apk --dart-define=APP_ENV=prod --dart-define=ENABLE_FIREBASE=true --dart-define=API_BASE_URL=https://api.tudominio.com
```

---

## 🧪 Testing y validación

Comandos recomendados:

```bash
flutter test
flutter analyze
```

Opcional (si se usa cobertura):

```bash
flutter test --coverage
```

---

*Mantenido con ❤️ para un desarrollo rápido, consistente y profesional.*
