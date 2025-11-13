# Laboratorio 5 - Respuestas a Preguntas Guía
## Sistemas Operativos - TEC

---

## 1. Comandos de Gestión de Usuarios

### useradd
**Función:** Crea una nueva cuenta de usuario en el sistema.

**Sintaxis básica:**
```bash
useradd [opciones] nombre_usuario
```

**Opciones comunes:**
- `-m`: Crea el directorio home del usuario
- `-g`: Especifica el grupo primario
- `-G`: Especifica grupos secundarios
- `-s`: Define el shell por defecto
- `-d`: Especifica el directorio home

**Ejemplo:**
```bash
useradd -m -g users -s /bin/bash juan
```

### userdel
**Función:** Elimina una cuenta de usuario del sistema.

**Sintaxis básica:**
```bash
userdel [opciones] nombre_usuario
```

**Opciones comunes:**
- `-r`: Elimina también el directorio home y archivos del usuario
- `-f`: Fuerza la eliminación incluso si el usuario está conectado

**Ejemplo:**
```bash
userdel -r juan
```

### passwd
**Función:** Cambia o establece la contraseña de un usuario.

**Sintaxis básica:**
```bash
passwd [opciones] [nombre_usuario]
```

**Opciones comunes:**
- `-l`: Bloquea la cuenta del usuario
- `-u`: Desbloquea la cuenta
- `-d`: Elimina la contraseña (sin contraseña)
- `-e`: Expira la contraseña (fuerza cambio en próximo login)
- `--stdin`: Lee la contraseña desde entrada estándar

**Ejemplo:**
```bash
echo "nuevaContraseña123" | passwd --stdin juan
```

### IDs de Usuarios

En Linux, cada usuario y grupo tiene asociado un identificador numérico único:

| Tipo de ID | Rango | Descripción |
|------------|-------|-------------|
| **UID 0** | 0 | Usuario root (superusuario) |
| **UID del sistema** | 1-999 | Usuarios del sistema (daemons, servicios) |
| **UID regulares** | 1000+ | Usuarios normales del sistema |
| **GID 0** | 0 | Grupo root |
| **GID del sistema** | 1-999 | Grupos del sistema |
| **GID regulares** | 1000+ | Grupos de usuarios normales |

**Ver el UID y GID de un usuario:**
```bash
id nombre_usuario
```

---

## 2. Grupos Primarios y Grupos Secundarios en Linux

### Grupo Primario (Primary Group)
- **Definición:** Es el grupo principal al que pertenece un usuario. Cada usuario DEBE tener exactamente UN grupo primario.
- **Uso:** Cuando el usuario crea archivos o directorios, estos heredan el grupo primario del usuario como propietario de grupo.
- **Archivo de configuración:** Se define en `/etc/passwd` (campo 4)
- **Identificación:** Se muestra con el comando `id` como `gid=`

**Ejemplo:**
```bash
# Usuario juan con grupo primario "developers" (GID 1001)
juan:x:1500:1001:Juan Perez:/home/juan:/bin/bash
```

### Grupos Secundarios (Secondary/Supplementary Groups)
- **Definición:** Son grupos adicionales a los que puede pertenecer un usuario. Un usuario puede pertenecer a MÚLTIPLES grupos secundarios.
- **Uso:** Permiten al usuario acceder a recursos compartidos con otros usuarios que pertenezcan a los mismos grupos.
- **Archivo de configuración:** Se definen en `/etc/group`
- **Identificación:** Se muestran con el comando `id` como `groups=`

**Ejemplo:**
```bash
# Juan pertenece a los grupos: developers (primario), docker, sudo (secundarios)
$ id juan
uid=1500(juan) gid=1001(developers) groups=1001(developers),1002(docker),27(sudo)
```

### Diferencias Clave

| Característica | Grupo Primario | Grupos Secundarios |
|----------------|----------------|--------------------|
| **Cantidad** | Solo UNO | Múltiples (0 o más) |
| **Asignación** | Obligatorio | Opcional |
| **Archivos nuevos** | Heredan este grupo | No afecta directamente |
| **Modificación** | `usermod -g` | `usermod -G` o `usermod -aG` |
| **Archivo config** | `/etc/passwd` | `/etc/group` |

---

## 3. Cuadro Comparativo entre Inode y ACL

| Aspecto | **Inode** | **ACL (Access Control List)** |
|---------|-----------|-------------------------------|
| **Definición** | Estructura de datos que almacena metadatos de archivos en el sistema de archivos | Sistema de permisos extendido que permite definir permisos específicos para múltiples usuarios y grupos |
| **Función principal** | Almacena información sobre el archivo: propietario, permisos, tamaño, timestamps, punteros a bloques de datos | Permite establecer permisos granulares más allá del modelo tradicional UGO (User, Group, Other) |
| **Permisos básicos** | Modelo tradicional: propietario (u), grupo (g), otros (o) con permisos rwx | Permisos extendidos para usuarios y grupos específicos adicionales |
| **Flexibilidad** | Limitado a 3 entidades (owner, group, others) | Alta flexibilidad: múltiples usuarios y grupos con diferentes permisos |
| **Almacenamiento** | Cada archivo/directorio tiene un inode único identificado por número | Se almacena como atributos extendidos asociados al inode |
| **Contenido** | Metadatos: UID, GID, permisos, tamaño, timestamps (atime, mtime, ctime), enlaces, punteros a bloques | Lista de entradas ACL especificando usuario/grupo y sus permisos específicos |
| **Comandos** | `ls -li` (ver número de inode), `stat` (información completa) | `getfacl` (ver ACLs), `setfacl` (modificar ACLs) |
| **Ejemplo de uso** | Almacenar que archivo.txt pertenece a user1:group1 con permisos 644 | Permitir que user2 tenga permiso de escritura en archivo.txt aunque no sea el propietario ni esté en el grupo |
| **Visualización** | `ls -l` muestra permisos básicos (ej: -rw-r--r--) | `ls -l` muestra un `+` al final si hay ACLs activas |
| **Compatibilidad** | Universal en todos los sistemas de archivos Unix/Linux | Requiere soporte del sistema de archivos (ext3/4, XFS, etc.) |
| **Complejidad** | Simple y directo | Más complejo de gestionar |
| **Rendimiento** | Mínimo overhead | Ligero overhead adicional |
| **Herencia** | Los nuevos archivos heredan del directorio padre según umask | ACLs default pueden heredarse a archivos creados en el directorio |
| **Ejemplo de comando** | `ls -li /etc/passwd` | `getfacl /var/www/html` |

**Relación entre ambos:**
- Los inodes son la estructura fundamental que contiene los permisos básicos
- Las ACLs son una extensión que se almacena JUNTO al inode para proporcionar permisos más detallados
- Ambos trabajan juntos: el inode tiene los permisos base, y las ACLs agregan reglas adicionales

---

## 4. Comando chmod - Cambio de Permisos

El comando `chmod` (change mode) modifica los permisos de acceso a archivos y directorios.

### Método Simbólico (Letras)

**Sintaxis:**
```bash
chmod [quién][operador][permiso] archivo
```

**Componentes:**
- **Quién:** `u` (user/propietario), `g` (group/grupo), `o` (others/otros), `a` (all/todos)
- **Operador:** `+` (agregar), `-` (quitar), `=` (establecer exactamente)
- **Permiso:** `r` (read/lectura), `w` (write/escritura), `x` (execute/ejecución)

**Ejemplos:**
```bash
# Agregar permiso de ejecución al propietario
chmod u+x script.sh

# Quitar permiso de escritura a otros
chmod o-w archivo.txt

# Dar permisos de lectura y escritura al grupo
chmod g+rw documento.txt

# Establecer permisos exactos: propietario rwx, grupo rx, otros nada
chmod u=rwx,g=rx,o= programa.sh

# Agregar ejecución para todos
chmod a+x script.sh

# Quitar todos los permisos a todos
chmod a-rwx secreto.txt
```

### Método Numérico (Octal)

**Sintaxis:**
```bash
chmod [número_octal] archivo
```

**Valores numéricos:**
- **r (read)** = 4
- **w (write)** = 2
- **x (execute)** = 1
- **- (sin permiso)** = 0

**Cálculo:** Se suman los valores para cada categoría (propietario, grupo, otros)

**Tabla de referencia:**

| Octal | Binario | Permisos | Significado |
|-------|---------|----------|-------------|
| 0 | 000 | --- | Sin permisos |
| 1 | 001 | --x | Solo ejecución |
| 2 | 010 | -w- | Solo escritura |
| 3 | 011 | -wx | Escritura y ejecución |
| 4 | 100 | r-- | Solo lectura |
| 5 | 101 | r-x | Lectura y ejecución |
| 6 | 110 | rw- | Lectura y escritura |
| 7 | 111 | rwx | Todos los permisos |

**Ejemplos:**
```bash
# 755: rwxr-xr-x (propietario todo, grupo y otros lectura/ejecución)
chmod 755 script.sh

# 644: rw-r--r-- (propietario rw, grupo y otros solo lectura)
chmod 644 documento.txt

# 600: rw------- (solo propietario lectura/escritura)
chmod 600 archivo_secreto.txt

# 777: rwxrwxrwx (todos los permisos para todos - NO RECOMENDADO)
chmod 777 archivo.txt

# 000: --------- (sin permisos para nadie)
chmod 000 bloqueado.txt

# 700: rwx------ (solo propietario tiene todos los permisos)
chmod 700 script_privado.sh
```

**Ejemplos comunes:**

| Permiso | Numérico | Simbólico | Uso típico |
|---------|----------|-----------|------------|
| rwxr-xr-x | 755 | u=rwx,g=rx,o=rx | Ejecutables, scripts |
| rw-r--r-- | 644 | u=rw,g=r,o=r | Archivos de texto, documentos |
| rw------- | 600 | u=rw,g=,o= | Archivos privados, claves SSH |
| rwxrwxrwx | 777 | a=rwx | Muy permisivo (evitar) |
| rwx------ | 700 | u=rwx,g=,o= | Directorios privados |

### Opciones adicionales de chmod

```bash
# -R: Recursivo (aplica a todos los archivos y subdirectorios)
chmod -R 755 /var/www/html

# -v: Verbose (muestra los cambios)
chmod -v 644 archivo.txt

# -c: Solo muestra cuando hay cambios
chmod -c 755 script.sh
```

---

## 5. Tablas de Particiones NTFS y EXT32

**Nota:** Existe un error en la pregunta. El sistema de archivos correcto es **EXT3** o **EXT4**, no "EXT32". A continuación se comparan NTFS y EXT3/EXT4.

### NTFS (New Technology File System)

**Desarrollador:** Microsoft
**Sistema Operativo:** Windows (NT, 2000, XP, Vista, 7, 8, 10, 11)

#### Características principales:
- **Journaling:** Mantiene un registro de cambios para recuperación ante fallos
- **Tamaño máximo de archivo:** 16 EB (exabytes) teóricamente
- **Tamaño máximo de partición:** 16 EB
- **Permisos:** Soporte completo de ACLs (Access Control Lists)
- **Compresión:** Soporta compresión transparente de archivos
- **Encriptación:** EFS (Encrypting File System) integrado
- **Cuotas de disco:** Permite límites por usuario
- **Metadatos:** Almacenados en MFT (Master File Table)

#### Funcionamiento de NTFS:

1. **MFT (Master File Table):**
   - Tabla central que contiene entradas para cada archivo y directorio
   - Cada entrada MFT tiene 1024 bytes
   - Almacena atributos del archivo (nombre, tamaño, timestamps, permisos, ubicación)
   - Los archivos pequeños pueden almacenarse completamente en la MFT

2. **Journaling:**
   - Registra transacciones antes de escribirlas al disco
   - Archivo `$LogFile` mantiene el registro de cambios
   - Permite recuperación rápida tras fallos del sistema

3. **Estructura:**
   - Boot sector: Información de arranque
   - MFT: Tabla maestra de archivos
   - Archivos del sistema: $MFT, $LogFile, $Bitmap, etc.
   - Área de datos: Almacenamiento de archivos

4. **Ventajas:**
   - Alta confiabilidad
   - Recuperación ante fallos
   - Seguridad avanzada
   - Soporte de archivos grandes

5. **Desventajas:**
   - Fragmentación con el tiempo
   - Soporte limitado en Linux (lectura/escritura con NTFS-3G)
   - Propietario de Microsoft

---

### EXT3/EXT4 (Extended File System)

**Desarrollador:** Linux Community
**Sistema Operativo:** Linux

#### EXT3 - Características:
- **Journaling:** Tres modos (journal, ordered, writeback)
- **Tamaño máximo de archivo:** 2 TB
- **Tamaño máximo de partición:** 32 TB
- **Compatibilidad:** Compatible con EXT2
- **Inodes:** Estructura de metadatos para archivos

#### EXT4 - Características (mejoras sobre EXT3):
- **Tamaño máximo de archivo:** 16 TB
- **Tamaño máximo de partición:** 1 EB (exabyte)
- **Extents:** Mejora rendimiento con archivos grandes
- **Delayed allocation:** Mejor rendimiento de escritura
- **Journal checksumming:** Mayor confiabilidad
- **Timestamps:** Nanosegundos de precisión
- **Desfragmentación online:** Mientras el sistema está montado

#### Funcionamiento de EXT3/EXT4:

1. **Estructura de bloques:**
   - **Boot block:** Primer bloque (información de arranque)
   - **Block groups:** Partición dividida en grupos de bloques

2. **Cada Block Group contiene:**
   - **Superblock:** Información del sistema de archivos (tamaño, bloques libres, inodes)
   - **Group descriptors:** Información del grupo
   - **Block bitmap:** Mapa de bloques libres/usados
   - **Inode bitmap:** Mapa de inodes libres/usados
   - **Inode table:** Tabla de inodes (metadatos de archivos)
   - **Data blocks:** Bloques de datos reales

3. **Inodes:**
   - Cada archivo/directorio tiene un inode único
   - Contiene: permisos, propietario, tamaño, timestamps, punteros a bloques de datos
   - No contiene el nombre del archivo (está en el directorio)

4. **Journaling en EXT3/EXT4:**
   - **Journal mode:** Registra tanto metadatos como datos (más lento, más seguro)
   - **Ordered mode:** Registra metadatos, datos se escriben antes (DEFAULT)
   - **Writeback mode:** Solo metadatos (más rápido, menos seguro)

5. **Ventajas:**
   - Open source y libre
   - Excelente rendimiento en Linux
   - Muy estable y maduro
   - Desfragmentación mínima (EXT4)
   - Recuperación robusta

6. **Desventajas:**
   - Soporte limitado en Windows (requiere software de terceros)
   - Sin compresión transparente nativa
   - Sin encriptación nativa (se usa LUKS o eCryptfs)

---

### Comparación NTFS vs EXT3/EXT4

| Característica | NTFS | EXT3/EXT4 |
|----------------|------|-----------|
| **SO Principal** | Windows | Linux |
| **Journaling** | Sí | Sí (3 modos) |
| **Tamaño máx. archivo** | 16 EB | 16 TB (EXT4) |
| **Tamaño máx. partición** | 16 EB | 1 EB (EXT4) |
| **Permisos** | ACLs avanzados | Permisos Unix + ACLs opcionales |
| **Compresión** | Nativa | No nativa |
| **Encriptación** | EFS nativo | Requiere LUKS/eCryptfs |
| **Fragmentación** | Más susceptible | Menos susceptible |
| **Metadatos** | MFT | Inodes |
| **Licencia** | Propietario | Open Source |
| **Rendimiento en Linux** | Limitado (NTFS-3G) | Nativo y óptimo |
| **Rendimiento en Windows** | Nativo y óptimo | Limitado (requiere drivers) |

---

### Conclusión

Ambos sistemas de archivos son robustos y confiables, pero están optimizados para sus respectivos sistemas operativos. NTFS es ideal para Windows con características empresariales avanzadas, mientras que EXT3/EXT4 es el estándar en Linux con excelente rendimiento y estabilidad.

---

**Documento preparado para:** Laboratorio 5 - Sistemas Operativos
**Instituto Tecnológico de Costa Rica**
