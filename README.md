# MoviTV

Aplicación móvil para Android, hecha con **Flutter**, para descubrir **películas y series de TV**. Usa los datos de la API pública de **The Movie Database (TMDB)**.

## Desarrollador

- **Nombre:** Beimar Guido Ortega Sardinas
- **Materia:** Programación de Dispositivos Móviles 2
- **Proyecto:** Proyecto final de módulo

## Nombre de la aplicación

**MoviTV**. El paquete del proyecto se llama `movies_2see`.

## Funcionalidades

**Inicio (Home)**
- Película en tendencia del día, en una tarjeta grande con póster, año, géneros y sinopsis.
- Películas en cartelera (las 10 más recientes).
- Películas mejor valoradas (Top 10).
- Series en emisión.
- Series mejor calificadas.
- Para actualizar, se desliza la pantalla hacia abajo.
- **"Ver todos"** en cada sección abre una pantalla con la lista completa en cuadrícula.

**Detalle de película** (`MovieDetailsPage`)
- Póster en calidad original, con el título y los géneros (cada uno con su ícono).
- Sinopsis expandible con animación ("Ver más / Ver menos") y calificación con estrella.
- **Reparto (actores)**: foto, nombre y personaje.
- Datos: estreno, duración, estado, presupuesto y recaudación.
- Compañías de producción, países e idiomas.

**Detalle de serie** (`SerieDetailsPage`)
- Póster, título, géneros, sinopsis expandible y calificación.
- **Reparto (actores)** de la serie.
- Datos: primera y última emisión, temporadas, episodios, duración por episodio y estado.
- Plataformas donde se emite, creadores, compañías e idiomas.

## Efectos visuales y animaciones (diseño propio)

Además de lo visto en clase, la app tiene estos efectos. Todos están hechos solo con Flutter, sin paquetes extra:

| Efecto | Dónde se ve | Archivo |
|---|---|---|
| **Entrada en cascada:** los elementos aparecen deslizándose y desvaneciéndose, uno tras otro | Home (logo, secciones, tarjetas) y detalle (cabecera, sinopsis, actores, datos) | `core/widgets/effects/fade_slide_in.dart` |
| **Tarjetas que se "hunden" al presionarlas** | Tarjetas de películas, series y actores | `core/widgets/effects/pressable_scale.dart` |
| **Shimmer** (brillo animado) mientras cargan las imágenes | Todos los pósters | `core/widgets/effects/shimmer_box.dart` |
| **Logo con degradado dorado** | Encabezado del Home | `core/widgets/effects/gradient_text.dart` |
| **Calificación animada:** anillo que se llena y número que cuenta de 0 al puntaje, con color según la nota (verde ≥ 7, dorado ≥ 5, rojo < 5) | Detalle de película y serie | `core/widgets/effects/animated_rating.dart` |
| **Fondo cinematográfico:** el póster desenfocado detrás del contenido | Detalle de película y serie | `core/widgets/effects/blurred_backdrop.dart` |
| **Botón atrás redondo** sobre la imagen | Detalle de película y serie | `core/widgets/effects/circle_back_button.dart` |
| **Brillo dorado** (sombra de color) en las tarjetas principales | Tarjeta "En tendencia" y póster del detalle | `trending_movie_card.dart`, `head_image_movie.dart` |
| **Insignia "EN TENDENCIA HOY"** | Tarjeta principal del Home | `trending_movie_card.dart` |
| **Ranking #1, #2, #3…** (dorado para el Top 3) | "Top populares" y "Series mejor calificadas" | `movie_card.dart` |
| **Géneros con ícono que entran uno por uno** | Cabecera del detalle | `head_image_movie.dart`, `genre_card_widget.dart` |
| **Secciones desplegables** (Datos, Compañías, Países, Idiomas…): se abren y se cierran al tocar el título, y la flecha gira | Detalle de película y serie | `detail_section.dart` |
| **Pantalla "Ver todos" en cuadrícula**, con tarjetas que entran en cascada | Botón "Ver todos" de cada sección | `features/see_all/` |
| **Sinopsis expandible animada** ("Ver más / Ver menos") | Detalle de película y serie | `core/widgets/expandable_overview_text.dart` |

## Tema

- **Color primario:** `#D5A15B` (dorado), asignado por el docente.
- A partir del color primario se generó la paleta completa, que está en `lib/core/theme/app_colors.dart`:

| Uso | Color |
|---|---|
| Primario | `#D5A15B` |
| Secundario | `#B07A35` |
| Terciario (estrellas) | `#F2CF8E` |
| Fondo | `#0F0D0A` |
| Superficie | `#1A1611` |
| Texto principal | `#F7F1E8` |
| Texto secundario | `#C7BBA8` |

El tema está centralizado en `lib/core/theme/` (colores, tipografías, espaciados, bordes y extensión del tema). Para cambiar el aspecto de toda la app basta con editar esos archivos.

## Tecnologías y paquetes

| Paquete | Uso |
|---|---|
| `flutter_riverpod` 3 | Manejo de estado (`AsyncNotifier`, `.family`, `FutureProvider`) |
| `dio` | Peticiones HTTP a la API de TMDB |
| `go_router` | Navegación y rutas con parámetros (`/movie_details/:id`, `/serie_details/:id`) |
| `flutter_dotenv` | Variables de entorno (URL base, token, rutas de imágenes) |
| `sizer` | Tamaños responsivos (`.w`, `.h`, `.sp`) |
| `google_fonts` | Tipografías Bebas Neue (títulos) y Outfit (textos) |
| `font_awesome_flutter` | Paquete de íconos (instalado) |
| `cupertino_icons` | Íconos de iOS (viene por defecto) |

**Ícono de la app:** diseño propio (una TV dorada con un botón de play, con el color primario `#D5A15B`), que reemplaza al ícono por defecto de Flutter. Está en:
- Android: `android/app/src/main/res/mipmap-*/ic_launcher.png` y el ícono adaptativo `mipmap-anydpi-v26/ic_launcher.xml` (con `ic_launcher_foreground.png` y el color de fondo en `values/ic_launcher_background.xml`).
- Web: `web/favicon.png` y `web/icons/`.

**Íconos dentro de la app:** se usan los íconos de **Material Icons**, que vienen incluidos en Flutter. Por ejemplo, el enum `GenresIcons` asigna un ícono a cada género. **No se descargan íconos externos.**

**Fuentes:** **Bebas Neue** y **Outfit**, de **Google Fonts**. Se descargan con el paquete `google_fonts`; **no hay archivos de fuentes locales**.

**Archivos locales:**
- **`.env`**, declarado como asset en `pubspec.yaml`. Contiene la configuración de la API y **no se sube al repositorio** (está en `.gitignore`).
- **Imágenes del ícono de la app** (PNG), en `android/app/src/main/res/mipmap-*` y en `web/icons`.
- **No hay imágenes, fuentes ni íconos externos descargados.** Los pósters y las fotos de los actores se cargan desde internet (TMDB).

## API utilizada: TMDB v3

| Endpoint | Para qué |
|---|---|
| `/trending/movie/day` | Película en tendencia |
| `/movie/now_playing` | Películas en cartelera |
| `/movie/top_rated` | Películas mejor valoradas |
| `/tv/on_the_air` | Series en emisión |
| `/tv/top_rated` | Series mejor calificadas |
| `/genre/movie/list` y `/genre/tv/list` | Nombres de los géneros |
| `/movie/{id}` | Detalle de una película |
| `/movie/{id}/credits` | Actores de una película |
| `/tv/{id}` | Detalle de una serie |
| `/tv/{id}/credits` | Actores de una serie |

Del reparto solo se muestran las personas cuyo `known_for_department` es `Acting`, es decir, los actores.

## Arquitectura

Arquitectura por **features**. Cada feature tiene tres capas:

- **data:** modelos (`fromJson`, `toEntity`) e implementación del repositorio.
- **domain:** entidades y contrato del repositorio (clase abstracta).
- **presentation:** páginas, widgets y providers (estado).

```
lib/
├── main.dart                  # Carga .env, ProviderScope, Sizer y MaterialApp.router
├── core/
│   ├── constants/             # app_env.dart (variables .env), genres_icons.dart (enum de íconos)
│   ├── data/data_source/      # endpoints.dart (todas las rutas de la API)
│   ├── dio_options/           # dio_connector.dart (cliente Dio + provider)
│   ├── errors/                # api_exception.dart
│   ├── routes/                # app_routes.dart (go_router)
│   ├── theme/                 # colores, tipografía, espaciado, bordes, tema
│   ├── utils/                 # géneros y formatos (fechas, dinero, duración)
│   └── widgets/               # widgets globales reutilizables:
│       │                      #   expandable_overview_text, overview_popularity_widget,
│       │                      #   movie_poster, facts_card, message_scaffold
│       └── effects/           # efectos y animaciones (fade_slide_in, pressable_scale,
│                              #   shimmer_box, gradient_text, animated_rating,
│                              #   blurred_backdrop, circle_back_button)
└── features/
    ├── home/                  # Pantalla principal (HomeState + HomeNotifier)
    ├── trending_movies/       # Película en tendencia
    ├── play_now_movies/       # Películas en cartelera
    ├── top_rated_movies/      # Películas mejor valoradas
    ├── on_air_series/         # Series en emisión
    ├── top_rated_series/      # Series mejor calificadas
    ├── trending_series/       # Series en tendencia
    ├── genres/                # Lista de géneros (id → nombre)
    ├── movie_details/         # Detalle de película + widgets de cabecera y géneros
    ├── serie_details/         # Detalle de serie
    ├── cast/                  # Reparto (actores) de películas y series
    └── see_all/               # Pantalla "Ver todos" (lista completa en cuadrícula)
```

## Guía rápida: ¿dónde cambio…?

| Quiero cambiar… | Archivo |
|---|---|
| Los colores de la app | `lib/core/theme/app_colors.dart` |
| El tamaño o tipo de letra | `lib/core/theme/app_typography.dart` |
| Márgenes y espacios | `lib/core/theme/app_spacing.dart` |
| El nombre que se ve en la app | `lib/main.dart` (title) y `android/app/src/main/AndroidManifest.xml` (android:label) |
| El token o las URLs de la API | archivo `.env` |
| Una ruta de la API | `lib/core/data/data_source/endpoints.dart` |
| Las pantallas y su navegación | `lib/core/routes/app_routes.dart` |
| El Home (secciones y orden) | `lib/features/home/presentation/pages/home_page.dart` |
| Cuántas películas se muestran (10) | `lib/features/home/presentation/providers/home_provider.dart` |
| La tarjeta grande "En tendencia" | `lib/features/home/presentation/widget/trending_movie_card.dart` |
| Las tarjetas de las listas | `lib/features/home/presentation/widget/movie_card.dart` |
| El detalle de una película | `lib/features/movie_details/presentation/pages/movie_details_page.dart` |
| El detalle de una serie | `lib/features/serie_details/presentation/pages/serie_details_page.dart` |
| La cabecera del detalle (póster y géneros) | `lib/features/movie_details/presentation/widget/head_image_movie.dart` |
| Los íconos de cada género | `lib/core/constants/genres_icons.dart` |
| Las líneas de la sinopsis y "Ver más" | `lib/core/widgets/expandable_overview_text.dart` |
| Las tarjetas de los actores | `lib/features/cast/presentation/widgets/cast_card_widget.dart` |
| La velocidad de las animaciones | `lib/core/widgets/effects/` (parámetro `duration` o `milliseconds`) |
| Los mensajes de error | `lib/core/errors/api_exception.dart` |

## Cómo ejecutar el proyecto

1. Crear una cuenta en [themoviedb.org](https://www.themoviedb.org) y obtener el **API Read Access Token**.
2. Crear el archivo `.env` en la raíz del proyecto:
   ```
   TMDB_BASE_PATH=https://api.themoviedb.org/3
   TMDB_API_KEY=TU_TOKEN_DE_TMDB
   TMDB_IMG_URL_W500=https://image.tmdb.org/t/p/w500
   TMDB_IMG_URL_ORIGINAL=https://image.tmdb.org/t/p/original
   ```
3. Instalar las dependencias y ejecutar:
   ```
   flutter pub get
   flutter run
   ```
4. Generar el APK:
   ```
   flutter build apk --release
   ```
   El APK queda en `build/app/outputs/flutter-apk/app-release.apk`.
