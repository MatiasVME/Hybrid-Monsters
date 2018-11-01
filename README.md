
# Guia de Estilo y Estructura.

## Estructura del codigo.

Partimos con la Guia de estilo de Godot como base: http://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_styleguide.html

## Estructura del proyecto.

### Carpetas principales y ubicacion de archivos

El proyecto se estructura con las siguientes carpetas raices:

```
.
├── addons
├── CONTRIBUTING.md
├── default_env.tres
├── icon.png
├── icon.png.import
├── language
├── project.godot
├── README.md
├── scene
│   ├── actor
│   │   ├── boss
│   │   ├── enemy
│   │   │   ├── sheep
│   │   │   └── tigger
│   │   ├── pet
│   │   └── player
│   ├── autoload
│   ├── background
│   ├── gui
│   │   └── button
│   ├── hud
│   ├── item
│   └── level
├── shader
├── sound
│   ├── bgm
│   └── sfx
├── test
└── theme
```

### Nombres de archivos y carpetas

#### Archivos *.tres / *.res:

Se ubicaran en la carpeta mas adecuada de acuerdo a su funcion en caso de que se reutilice en varias escenas, o bien, junto a su archivo o escena correspondiente.
Debe tener un nombre que indique su uso. Unicamente usaremos archivos tipo *.tres para que se pueda visualizar en gitlab.

**Ejemplo:**

/img/tile/map.tres.
/img/particle/fire.tres
/scene/character/player/1/animation.tres

El caso de la fuente la estructura de su nombre sera “nombre_fuente_” + tamaño de la fuente.

**Ejemplo:**

arial_32.tres	comic_sans_16.tres

#### Se debe mantener el nombre lo mas corto posible.

**Bueno:**

blue_dragon.tscn	    search_enemy.gd

**Malo:**

blue_dragon_enemy.tscn	script_to_search_enemy.gd

#### Ningun archivo debe contener el nombre de sus carpetas contenedoras.

**Bueno:**

/scene/character/enemy/blue_dragon.tscn
/sound/effect/fire.ogg
/scene/level/1.tscn

**Malo:**

/scene/character/enemy/blue_dragon_enemy.tscn
/sound/effect/fire_sound.ogg
scene/level/level_1.tscn

#### Los nombres de las carpetas y archivos deben estar en ingles, usar siempre minusculas, y nunca empezar el nombre de la carpeta con numeros, a menos que sea su nombre unico.

**Bueno:**

credit.tscn 	credit.gd

**Malo:**

creditos.tscn	Credit.gd	1music.tscn

#### No usar plurales.

**Bueno:**

music	menu	item	level

**Malo:**

musics	menus	items	levels

#### Cuando la carpeta o archivo tenga mas de dos palabras usaremos “_” para separarlas.

**Bueno:**

blue_car.gd	inca_killer.tscn

**Malo:**

bluecar.gd	incakiller.tscn 
