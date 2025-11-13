# Sección 5: Permisos - Guía de Comandos Paso a Paso
## Laboratorio 5 - Sistemas Operativos

---

## IMPORTANTE: Captura de pantalla en cada paso

Para cada comando ejecutado, debes tomar una captura de pantalla que muestre:
1. El comando ejecutado
2. La salida/resultado del comando
3. Tu nombre de usuario en el prompt

---

## 5.1 Permisos en Archivos

### Paso 1: Crear archivo de prueba y verificar permisos

```bash
touch /tmp/test
ls -l /tmp/test
```

**Qué hace:**
- `touch /tmp/test`: Crea un archivo vacío llamado "test" en el directorio /tmp
- `ls -l /tmp/test`: Lista el archivo con formato largo mostrando permisos

**Resultado esperado:**
```
-rw-r--r-- 1 usuario grupo 0 Nov 13 10:30 /tmp/test
```

**Explicación del resultado:**
```
-rw-r--r--  1  usuario  grupo  0  Nov 13 10:30  /tmp/test
│││││││││  │    │        │     │      │           │
│││││││││  │    │        │     │      │           └─ Nombre del archivo
│││││││││  │    │        │     │      └─ Fecha y hora de modificación
│││││││││  │    │        │     └─ Tamaño en bytes (0 = vacío)
│││││││││  │    │        └─ Grupo propietario
│││││││││  │    └─ Usuario propietario
│││││││││  └─ Número de enlaces duros
│││││││││
││││││││└─ Otros: ejecutar (-)
│││││││└── Otros: escribir (-)
││││││└─── Otros: leer (r)
│││││└──── Grupo: ejecutar (-)
││││└───── Grupo: escribir (-)
│││└────── Grupo: leer (r)
││└─────── Propietario: ejecutar (-)
│└──────── Propietario: escribir (w)
└───────── Propietario: leer (r)

Primer carácter:
- = archivo regular
d = directorio
l = enlace simbólico
```

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2a: Agregar permiso de escritura a "otros" (método simbólico)

```bash
chmod o+w /tmp/test
ls -l /tmp/test
```

**Qué hace:**
- `chmod o+w`: Agrega (+) permiso de escritura (w) a otros (o)

**Resultado esperado:**
```
-rw-r--rw- 1 usuario grupo 0 Nov 13 10:30 /tmp/test
        ^^
        └─ Ahora "otros" tiene lectura y escritura
```

**Explicación:**
- Antes: `-rw-r--r--` (otros solo podían leer)
- Después: `-rw-r--rw-` (otros pueden leer Y escribir)

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2b: Establecer permisos 666 (método numérico)

```bash
chmod 666 /tmp/test
ls -l /tmp/test
```

**Qué hace:**
- `chmod 666`: Establece permisos rw-rw-rw-
  - 6 (propietario) = 4+2 = r+w = rw-
  - 6 (grupo) = 4+2 = r+w = rw-
  - 6 (otros) = 4+2 = r+w = rw-

**Resultado esperado:**
```
-rw-rw-rw- 1 usuario grupo 0 Nov 13 10:30 /tmp/test
```

**Explicación:**
- Todos (propietario, grupo, otros) pueden leer y escribir
- Nadie puede ejecutar el archivo

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2c: Quitar todos los permisos a todos

```bash
chmod a-rwx /tmp/test
ls -l /tmp/test
```

**Qué hace:**
- `chmod a-rwx`: Quita (-) lectura, escritura y ejecución (rwx) a todos (a=all)

**Resultado esperado:**
```
---------- 1 usuario grupo 0 Nov 13 10:30 /tmp/test
```

**Explicación:**
- El archivo existe pero NADIE puede leerlo, escribirlo ni ejecutarlo
- Ni siquiera el propietario (aunque root sí podría)

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2d: Intentar leer el archivo sin permisos

```bash
cat /tmp/test
```

**Qué hace:**
- `cat`: Intenta leer y mostrar el contenido del archivo

**Resultado esperado:**
```
cat: /tmp/test: Permission denied
```

**Explicación:**
- Como el archivo no tiene permisos de lectura, obtenemos error
- Esto demuestra que los permisos están funcionando

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2e: Dar permisos de lectura/escritura al propietario

```bash
chmod u+rw /tmp/test
ls -l /tmp/test
```

**Qué hace:**
- `chmod u+rw`: Agrega (+) lectura y escritura (rw) al usuario/propietario (u)

**Resultado esperado:**
```
-rw------- 1 usuario grupo 0 Nov 13 10:30 /tmp/test
```

**Explicación:**
- Ahora el propietario puede leer y escribir
- El grupo y otros aún no tienen permisos

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

## 5.2 Permisos en Directorios

### Paso 1: Crear directorio con subdirectorio

```bash
mkdir -p /tmp/mydirectory/mydir2
```

**Qué hace:**
- `mkdir -p`: Crea directorios, incluyendo padres si no existen
- Crea `/tmp/mydirectory` y dentro `/tmp/mydirectory/mydir2`

**Explicación:**
- Sin `-p`, si mydirectory no existe, fallaría
- Con `-p`, crea toda la estructura necesaria

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 2: Ver permisos del directorio (dos formas)

```bash
ls -l /tmp/mydirectory
echo "---"
ls -ld /tmp/mydirectory
```

**Qué hace:**
- `ls -l /tmp/mydirectory`: Lista el CONTENIDO del directorio
- `ls -ld /tmp/mydirectory`: Lista el DIRECTORIO mismo (con -d)

**Resultado esperado:**

**Comando 1 (`ls -l`):**
```
total 0
drwxr-xr-x 2 usuario grupo 40 Nov 13 10:35 mydir2
```
Muestra lo que HAY DENTRO de mydirectory (el subdirectorio mydir2)

**Comando 2 (`ls -ld`):**
```
drwxr-xr-x 3 usuario grupo 60 Nov 13 10:35 /tmp/mydirectory
```
Muestra información del PROPIO directorio mydirectory

**Explicación de permisos en directorios:**
```
drwxr-xr-x
│││││││││
│││││││││
││││││││└─ Otros: ejecutar (x) - Pueden entrar al directorio
│││││││└── Otros: escribir (-) - NO pueden crear/borrar archivos
││││││└─── Otros: leer (r) - Pueden listar contenido
│││││└──── Grupo: ejecutar (x) - Pueden entrar
││││└───── Grupo: escribir (-) - NO pueden crear/borrar
│││└────── Grupo: leer (r) - Pueden listar
││└─────── Propietario: ejecutar (x) - Puede entrar
│└──────── Propietario: escribir (w) - Puede crear/borrar archivos
└───────── Propietario: leer (r) - Puede listar
d = es un directorio
```

**En directorios:**
- **r (read)**: Permiso para LISTAR el contenido (ls)
- **w (write)**: Permiso para CREAR/ELIMINAR archivos dentro
- **x (execute)**: Permiso para ENTRAR al directorio (cd)

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 3: Quitar permiso de ejecución a todos

```bash
chmod a-x /tmp/mydirectory
ls -ld /tmp/mydirectory
```

**Qué hace:**
- `chmod a-x`: Quita permiso de ejecución (x) a todos (a)

**Resultado esperado:**
```
drw-r--r-- 3 usuario grupo 60 Nov 13 10:35 /tmp/mydirectory
```

**Explicación:**
- Sin permiso de ejecución (x), NADIE puede entrar al directorio
- Aunque tengan permiso de lectura, no sirve de nada sin ejecutar

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 4: Intentar acceder al directorio sin permiso de ejecución

```bash
cd /tmp/mydirectory
```

**Resultado esperado:**
```
bash: cd: /tmp/mydirectory: Permission denied
```

**Explicación:**
- Sin permiso de ejecución (x), no se puede entrar con `cd`
- Esto demuestra la importancia del permiso x en directorios

**Intenta también listar:**
```bash
ls /tmp/mydirectory
```

**Resultado esperado:**
```
ls: cannot access '/tmp/mydirectory/mydir2': Permission denied
mydir2
```

**Explicación:**
- Puedes ver los NOMBRES (por el permiso r)
- Pero NO puedes acceder a la información de los archivos (sin permiso x)

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 5: Restaurar acceso al directorio

```bash
chmod ug+x /tmp/mydirectory
ls -ld /tmp/mydirectory
```

**Qué hace:**
- `chmod ug+x`: Agrega permiso de ejecución al usuario (u) y grupo (g)

**Resultado esperado:**
```
drwxr-xr-- 3 usuario grupo 60 Nov 13 10:35 /tmp/mydirectory
```

**Explicación:**
- Propietario: rwx (puede listar, crear/borrar, entrar)
- Grupo: r-x (puede listar y entrar, pero NO crear/borrar)
- Otros: r-- (solo puede listar, NO puede entrar)

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 6: Verificar que otros NO tienen permiso de acceso

```bash
ls -ld /tmp/mydirectory
```

**Qué verificar:**
- Los últimos 3 caracteres deben ser `r--`
- Otros tienen lectura pero NO ejecución ni escritura

**Ahora intenta acceder:**
```bash
cd /tmp/mydirectory
pwd
```

**Resultado esperado:**
- Si eres el propietario o del grupo: funciona
- Si eres "otros": Permission denied

**📸 TOMA CAPTURA DE PANTALLA AQUÍ**

---

### Paso 7: Práctica con representación numérica

**Crear un archivo nuevo:**
```bash
touch /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt
```

**Asignar permisos con números:**
```bash
# Permisos 644 (rw-r--r--)
chmod 644 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt
```

**Modificar permisos:**
```bash
# Permisos 755 (rwxr-xr-x)
chmod 755 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt
```

```bash
# Permisos 600 (rw-------)
chmod 600 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt
```

**Eliminar todos los permisos:**
```bash
# Permisos 000 (---------)
chmod 000 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt
```

**Crear un directorio de prueba:**
```bash
mkdir /tmp/midirectorio
ls -ld /tmp/midirectorio
```

**Asignar permisos al directorio:**
```bash
# Permisos 755 (rwxr-xr-x) - común para directorios
chmod 755 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

```bash
# Permisos 700 (rwx------) - directorio privado
chmod 700 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

```bash
# Permisos 775 (rwxrwxr-x) - grupo puede escribir
chmod 775 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

**Eliminar permisos del directorio:**
```bash
chmod 000 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

**Restaurar permisos:**
```bash
chmod 755 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

**📸 TOMA CAPTURA DE PANTALLA DE CADA CAMBIO DE PERMISOS**

---

## Tabla de Referencia Rápida - Permisos Numéricos

| Número | Binario | Permisos | Significado |
|--------|---------|----------|-------------|
| 0 | 000 | --- | Sin permisos |
| 1 | 001 | --x | Solo ejecución |
| 2 | 010 | -w- | Solo escritura |
| 3 | 011 | -wx | Escritura + ejecución |
| 4 | 100 | r-- | Solo lectura |
| 5 | 101 | r-x | Lectura + ejecución |
| 6 | 110 | rw- | Lectura + escritura |
| 7 | 111 | rwx | Todos los permisos |

## Combinaciones Comunes

| Permisos | Numérico | Uso típico |
|----------|----------|------------|
| -rw------- | 600 | Archivos privados del usuario |
| -rw-r--r-- | 644 | Archivos legibles por todos |
| -rwx------ | 700 | Scripts privados ejecutables |
| -rwxr-xr-x | 755 | Programas/scripts públicos |
| -rwxrwxrwx | 777 | Todos los permisos (EVITAR) |
| drwx------ | 700 | Directorio privado |
| drwxr-xr-x | 755 | Directorio público |
| drwxrwxr-x | 775 | Directorio compartido con grupo |

---

## Resumen de Comandos Importantes

```bash
# Ver permisos de archivo
ls -l archivo

# Ver permisos de directorio
ls -ld directorio

# Cambiar permisos (simbólico)
chmod u+rwx archivo      # Agregar al usuario
chmod g-w archivo        # Quitar al grupo
chmod o=r archivo        # Establecer para otros
chmod a+x archivo        # Agregar a todos

# Cambiar permisos (numérico)
chmod 755 archivo        # rwxr-xr-x
chmod 644 archivo        # rw-r--r--
chmod 600 archivo        # rw-------

# Cambiar permisos recursivamente
chmod -R 755 directorio/

# Ver quién soy
whoami
id

# Ver grupos
groups
```

---

**¡IMPORTANTE!**
No olvides tomar capturas de pantalla de CADA comando y su resultado.
Estas capturas serán parte de tu documento final PDF.
