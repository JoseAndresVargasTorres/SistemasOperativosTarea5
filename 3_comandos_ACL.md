# Sección 6: Lista de Control de Acceso (ACL)
## Laboratorio 5 - Sistemas Operativos

---

## ¿Qué son las ACLs?

Las **Access Control Lists (ACL)** son un sistema de permisos extendido que permite definir permisos específicos para usuarios y grupos adicionales, más allá del modelo tradicional UGO (User, Group, Others).

**Ventajas:**
- Puedes dar permisos a usuarios específicos sin cambiar el propietario
- Puedes dar permisos a múltiples grupos
- Mayor granularidad en el control de acceso

---

## Comandos Principales

### getfacl - Obtener ACLs

**Sintaxis básica:**
```bash
getfacl [opciones] archivo_o_directorio
```

**Opciones comunes:**
- Sin opciones: Muestra las ACLs del archivo/directorio
- `-R`: Recursivo (muestra ACLs de todos los archivos en un directorio)
- `-d`: Muestra solo las ACLs por defecto
- `-c`: Omite los comentarios en la salida

**Ejemplos:**
```bash
# Ver ACLs de un archivo
getfacl /etc/motd

# Ver ACLs de un directorio
getfacl /var/tmp/collab

# Ver ACLs recursivamente
getfacl -R /var/www/html
```

**Salida típica:**
```
# file: /etc/motd
# owner: root
# group: root
user::rw-
user:rootadmin:rw-
group::r--
mask::rw-
other::r--
```

---

### setfacl - Establecer ACLs

**Sintaxis básica:**
```bash
setfacl [opciones] especificación archivo_o_directorio
```

**Opciones principales:**
- `-m`: Modificar (agregar/cambiar) ACLs
- `-x`: Eliminar ACLs específicas
- `-b`: Eliminar TODAS las ACLs
- `-d`: Trabajar con ACLs por defecto (para directorios)
- `-R`: Recursivo
- `--set`: Establecer ACLs completas (reemplaza todas)

**Sintaxis de especificación:**
```
u:usuario:permisos        # Usuario específico
g:grupo:permisos          # Grupo específico
o::permisos               # Otros
m::permisos               # Máscara (mask)
d:u:usuario:permisos      # ACL por defecto para usuario
d:g:grupo:permisos        # ACL por defecto para grupo
```

**Permisos:**
- `r` = lectura (read)
- `w` = escritura (write)
- `x` = ejecución (execute)
- `-` = sin permiso
- También se pueden usar números: 4=r, 2=w, 1=x

**Ejemplos:**
```bash
# Dar permiso rw al usuario "rootadmin" en un archivo
setfacl -m u:rootadmin:rw /etc/motd

# Dar permiso rx al grupo "developers"
setfacl -m g:developers:rx /opt/project

# Dar solo lectura al usuario "juan"
setfacl -m u:juan:r archivo.txt

# ACL por defecto en directorio (se hereda a archivos nuevos)
setfacl -m d:u:rootadmin:rw /var/tmp/collab

# Eliminar ACL de un usuario específico
setfacl -x u:juan archivo.txt

# Eliminar todas las ACLs
setfacl -b archivo.txt

# Múltiples ACLs a la vez
setfacl -m u:user1:rwx,u:user2:rx,g:group1:r archivo.txt
```

---

## SECCIÓN 6: Lista de Control de Acceso - Pasos del Laboratorio

### PREPARACIÓN: Asegurarse de tener un usuario no-root

**Antes de empezar, necesitas:**
1. Un usuario root o con sudo
2. Un usuario NO root (llamémoslo "rootadmin")

**Crear el usuario rootadmin si no existe:**
```bash
# Como root
sudo useradd rootadmin
sudo passwd rootadmin
# Ingresa una contraseña (ej: admin123)
```

---

### Paso 1: Investigar comandos getfacl y setfacl

**Ya se explicó arriba. Ejecuta estos ejemplos para familiarizarte:**

```bash
# Ver ACLs de tu directorio home
getfacl ~

# Ver ACLs de /etc
getfacl /etc
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 2: Intentar editar /etc/motd como usuario no-root

**Primero, cambia al usuario rootadmin:**

```bash
su - rootadmin
# Ingresa la contraseña de rootadmin
```

**Ahora intenta editar /etc/motd:**

```bash
vim /etc/motd
# o
nano /etc/motd
```

**Resultado esperado:**
- Podrás ABRIR el archivo (porque tiene permiso de lectura)
- NO podrás GUARDAR cambios (sin permiso de escritura)
- En vim: verás "E45: 'readonly' option is set"
- En nano: al guardar dirá "Error writing /etc/motd: Permission denied"

**Verificar permisos actuales:**
```bash
ls -l /etc/motd
```

**Salida típica:**
```
-rw-r--r-- 1 root root 0 Nov 13 10:00 /etc/motd
```
Solo root (propietario) puede escribir.

**Salir del editor sin guardar:**
- vim: Presiona ESC, luego escribe `:q!` y ENTER
- nano: Presiona Ctrl+X, luego N (no guardar)

**Volver a ser root:**
```bash
exit
# Ahora eres root nuevamente
```

**📸 TOMA CAPTURA DE PANTALLA DEL ERROR**

---

### Paso 3: Agregar ACL para que rootadmin pueda escribir en /etc/motd

**Como root, ejecuta:**

```bash
setfacl -m u:rootadmin:rw /etc/motd
```

**Qué hace:**
- `-m`: Modificar ACL
- `u:rootadmin:rw`: Dar permiso de lectura y escritura al usuario rootadmin

**Verificar que se aplicó:**
```bash
ls -l /etc/motd
```

**Ahora verás un `+` al final de los permisos:**
```
-rw-r--r--+ 1 root root 0 Nov 13 10:00 /etc/motd
           ^
           └─ El + indica que hay ACLs activas
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 4: Verificar la ACL con getfacl

```bash
getfacl /etc/motd
```

**Salida esperada:**
```
# file: etc/motd
# owner: root
# group: root
user::rw-
user:rootadmin:rw-          ← ACL que agregamos
group::r--
mask::rw-
other::r--
```

**Explicación:**
- `user::rw-`: Permisos del propietario (root)
- `user:rootadmin:rw-`: ACL específica para rootadmin
- `group::r--`: Permisos del grupo
- `mask::rw-`: Máscara (permisos máximos efectivos)
- `other::r--`: Permisos para otros

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 5: Escribir en /etc/motd como usuario no-root

**Cambia al usuario rootadmin:**
```bash
su - rootadmin
```

**Ahora AGREGA una línea al archivo:**
```bash
echo 'Welcome from rootadmin!' >> /etc/motd
```

**Verificar que se escribió:**
```bash
cat /etc/motd
```

**Salida esperada:**
```
Welcome from rootadmin!
```

**¡Funcionó! Ahora rootadmin puede escribir gracias a la ACL.**

**Volver a root:**
```bash
exit
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 6: Conectarse por SSH y ver el mensaje

**Abre una NUEVA terminal en tu máquina virtual o desde otro equipo:**

```bash
ssh usuario@ip_de_tu_maquina_virtual
# Por ejemplo: ssh rootadmin@localhost
```

**Al conectarte, deberías ver:**
```
Welcome from rootadmin!
Last login: ...
```

**Explicación:**
- `/etc/motd` significa "Message Of The Day"
- Su contenido se muestra al iniciar sesión por SSH
- Modificamos este archivo con el usuario rootadmin gracias a la ACL

**📸 TOMA CAPTURA DE PANTALLA DEL LOGIN SSH**

---

### Paso 7: Crear directorio colaborativo como root

**Volver a la sesión como root:**

```bash
sudo mkdir /var/tmp/collab
```

**Verificar que se creó:**
```bash
ls -ld /var/tmp/collab
```

**Salida esperada:**
```
drwxr-xr-x 2 root root 40 Nov 13 11:00 /var/tmp/collab
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 8: Mostrar ACLs del directorio

```bash
getfacl /var/tmp/collab
```

**Salida esperada (aún sin ACLs personalizadas):**
```
# file: var/tmp/collab
# owner: root
# group: root
user::rwx
group::r-x
other::r-x
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 9: Crear ACL por defecto para archivos futuros

**Como root:**

```bash
setfacl -m d:u:rootadmin:rw /var/tmp/collab
```

**Qué hace:**
- `-m d:u:rootadmin:rw`: Crea una ACL por **defecto** (default)
- Los archivos creados DENTRO de este directorio heredarán esta ACL
- rootadmin tendrá automáticamente permiso rw en archivos nuevos

**Explicación de ACLs por defecto:**
- Solo aplican a **directorios**
- Se heredan a archivos/subdirectorios creados dentro
- Se identifican con el prefijo `d:` (default)

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 10: Verificar la nueva ACL por defecto

```bash
getfacl /var/tmp/collab
```

**Salida esperada:**
```
# file: var/tmp/collab
# owner: root
# group: root
user::rwx
group::r-x
other::r-x
default:user::rwx
default:user:rootadmin:rw-      ← ACL por defecto que agregamos
default:group::r-x
default:mask::rwx
default:other::r-x
```

**Observa:**
- Las líneas normales: ACLs del propio directorio
- Las líneas `default:`: ACLs que se heredarán a archivos nuevos

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 11: Crear un archivo como root en el directorio

```bash
echo "rootfile contents" > /var/tmp/collab/rootfile
```

**Qué hace:**
- Crea un archivo llamado `rootfile`
- El contenido es "rootfile contents"
- El propietario será root

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 12: Verificar el contenido del archivo

```bash
cat /var/tmp/collab/rootfile
```

**Salida esperada:**
```
rootfile contents
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 13: Verificar ACL del archivo (heredada)

```bash
getfacl /var/tmp/collab/rootfile
```

**Salida esperada:**
```
# file: var/tmp/collab/rootfile
# owner: root
# group: root
user::rw-
user:rootadmin:rw-              ← ¡Se heredó la ACL por defecto!
group::r-x
mask::rw-
other::r-x
```

**Observa:**
- `user:rootadmin:rw-` se heredó automáticamente
- rootadmin puede leer y escribir este archivo aunque no sea el propietario

**También verifica con ls:**
```bash
ls -l /var/tmp/collab/rootfile
```

**Verás el `+` indicando ACLs:**
```
-rw-rw-r--+ 1 root root 18 Nov 13 11:05 /var/tmp/collab/rootfile
          ^
```

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 14: Escribir en el archivo como usuario no-root

**Cambia al usuario rootadmin:**
```bash
su - rootadmin
```

**Agrega contenido al archivo:**
```bash
echo 'rootadmin was here' >> /var/tmp/collab/rootfile
```

**Nota:**
- Sin la ACL, esto fallaría (Permission denied)
- Gracias a la ACL heredada, rootadmin puede escribir

**📸 TOMA CAPTURA DE PANTALLA**

---

### Paso 15: Verificar el contenido final

**Como rootadmin o como root:**
```bash
cat /var/tmp/collab/rootfile
```

**Salida esperada:**
```
rootfile contents
rootadmin was here
```

**¡Funciona! rootadmin pudo escribir en un archivo propiedad de root.**

**Volver a root:**
```bash
exit
```

**📸 TOMA CAPTURA DE PANTALLA**

---

## Comandos Adicionales Útiles

### Eliminar ACLs

```bash
# Eliminar ACL de un usuario específico
setfacl -x u:rootadmin /etc/motd

# Eliminar ACL de un grupo específico
setfacl -x g:developers /var/www

# Eliminar TODAS las ACLs de un archivo
setfacl -b /etc/motd

# Eliminar ACLs por defecto de un directorio
setfacl -k /var/tmp/collab
```

### Copiar ACLs de un archivo a otro

```bash
# Obtener ACLs de archivo1 y aplicarlas a archivo2
getfacl archivo1 | setfacl --set-file=- archivo2
```

### Establecer ACLs recursivamente

```bash
# Aplicar ACL a directorio y todo su contenido
setfacl -R -m u:rootadmin:rwx /var/www/html
```

### Ver solo usuarios/grupos con ACLs

```bash
getfacl /etc/motd | grep "user:" | grep -v "user::"
getfacl /etc/motd | grep "group:" | grep -v "group::"
```

---

## Tabla Resumen - Comandos ACL

| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `getfacl archivo` | Ver ACLs de un archivo | `getfacl /etc/motd` |
| `setfacl -m u:usuario:permisos archivo` | Agregar ACL de usuario | `setfacl -m u:juan:rw file.txt` |
| `setfacl -m g:grupo:permisos archivo` | Agregar ACL de grupo | `setfacl -m g:dev:rx /opt/app` |
| `setfacl -m d:u:usuario:permisos dir` | ACL por defecto en directorio | `setfacl -m d:u:juan:rw /shared` |
| `setfacl -x u:usuario archivo` | Eliminar ACL de usuario | `setfacl -x u:juan file.txt` |
| `setfacl -b archivo` | Eliminar TODAS las ACLs | `setfacl -b file.txt` |
| `setfacl -R ...` | Aplicar recursivamente | `setfacl -R -m u:juan:rx /data` |
| `ls -l` | Ver si hay ACLs (símbolo +) | `ls -l /etc/motd` |

---

## Permisos en ACLs

| Notación | Permisos | Significado |
|----------|----------|-------------|
| `r--` | 4 | Solo lectura |
| `-w-` | 2 | Solo escritura |
| `--x` | 1 | Solo ejecución |
| `rw-` | 6 | Lectura + escritura |
| `r-x` | 5 | Lectura + ejecución |
| `-wx` | 3 | Escritura + ejecución |
| `rwx` | 7 | Todos los permisos |
| `---` | 0 | Sin permisos |

---

## Diferencias: Permisos Tradicionales vs ACLs

| Característica | Permisos Tradicionales | ACLs |
|----------------|------------------------|------|
| **Usuarios** | Solo 1 (propietario) | Múltiples usuarios |
| **Grupos** | Solo 1 (grupo primario) | Múltiples grupos |
| **Flexibilidad** | Limitada | Alta |
| **Complejidad** | Simple | Más compleja |
| **Comando ver** | `ls -l` | `getfacl` |
| **Comando cambiar** | `chmod`, `chown` | `setfacl` |
| **Indicador** | Ninguno | `+` en `ls -l` |

---

## Consejos y Buenas Prácticas

1. **Verifica siempre con getfacl**: Después de usar setfacl, confirma con getfacl que se aplicó correctamente

2. **El símbolo +**: Si ves un `+` en `ls -l`, significa que hay ACLs activas

3. **ACLs por defecto**: Solo funcionan en directorios y se heredan a archivos nuevos

4. **Máscara (mask)**: Limita los permisos efectivos máximos. Si mask es `r--`, aunque pongas `rwx` en una ACL, solo tendrá `r--`

5. **Backup de ACLs**:
   ```bash
   # Guardar ACLs
   getfacl -R /directorio > acls_backup.txt

   # Restaurar ACLs
   setfacl --restore=acls_backup.txt
   ```

6. **Orden de evaluación de permisos**:
   - Si eres el propietario: se usan permisos del propietario
   - Si hay ACL para tu usuario: se usa esa ACL
   - Si estás en el grupo: se usan permisos del grupo
   - Si hay ACL para tu grupo: se usa esa ACL
   - Si nada aplica: se usan permisos de "otros"

---

## IMPORTANTE

- Toma capturas de TODOS los pasos
- Asegúrate de que las capturas muestren:
  - El comando ejecutado
  - La salida completa
  - Tu usuario en el prompt
- Estas capturas irán en tu documento PDF final

---

**Fin de la Sección ACL**
