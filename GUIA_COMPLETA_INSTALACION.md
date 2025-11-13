# Guía Completa de Instalación y Ejecución
## Laboratorio 5 - Sistemas Operativos
### Instituto Tecnológico de Costa Rica

---

## Índice

1. [Requisitos Previos](#1-requisitos-previos)
2. [Instalación de VirtualBox](#2-instalación-de-virtualbox)
3. [Descarga de CentOS](#3-descarga-de-centos)
4. [Creación de la Máquina Virtual](#4-creación-de-la-máquina-virtual)
5. [Instalación de CentOS](#5-instalación-de-centos)
6. [Configuración Inicial](#6-configuración-inicial)
7. [Transferir Scripts a la VM](#7-transferir-scripts-a-la-vm)
8. [Ejecución del Laboratorio](#8-ejecución-del-laboratorio)
9. [Capturas de Pantalla](#9-capturas-de-pantalla)
10. [Creación del Documento Final](#10-creación-del-documento-final)

---

## 1. Requisitos Previos

### Hardware recomendado:
- **RAM**: Mínimo 4 GB (8 GB recomendado)
- **Espacio en disco**: Al menos 20 GB libres
- **Procesador**: Compatible con virtualización (Intel VT-x o AMD-V)

### Software necesario:
- **VirtualBox** (gratuito) o **VMware Workstation Player**
- **CentOS 7** o **CentOS Stream 9** (ISO)
- Conexión a Internet para descargas

---

## 2. Instalación de VirtualBox

### Para Windows:

1. Ve a: https://www.virtualbox.org/wiki/Downloads
2. Descarga "VirtualBox for Windows hosts"
3. Ejecuta el instalador
4. Sigue el asistente de instalación (dejar opciones por defecto)
5. Al finalizar, reinicia tu computadora

### Para macOS:

1. Ve a: https://www.virtualbox.org/wiki/Downloads
2. Descarga "VirtualBox for macOS hosts"
3. Abre el archivo .dmg descargado
4. Instala VirtualBox.pkg
5. Si macOS bloquea la instalación, ve a Preferencias del Sistema > Seguridad y permite

### Para Linux (Ubuntu/Debian):

```bash
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack
```

**📸 CAPTURA**: VirtualBox instalado (pantalla principal)

---

## 3. Descarga de CentOS

### Opción 1: CentOS 7 (Más estable, recomendado para el lab)

1. Ve a: https://www.centos.org/download/
2. Selecciona "CentOS Linux 7"
3. Elige "x86_64"
4. Descarga "DVD ISO" (aproximadamente 4.5 GB)
5. Alternativa más rápida: CentOS 7 Minimal ISO (1 GB)

**URL directa (mirror):**
```
http://mirrors.kernel.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
```

### Opción 2: CentOS Stream 9 (Más reciente)

1. Ve a: https://www.centos.org/centos-stream/
2. Descarga CentOS Stream 9 DVD ISO

**Recomendación**: Usa CentOS 7 para evitar incompatibilidades con los comandos del laboratorio.

**📸 CAPTURA**: Descarga completada de la ISO

---

## 4. Creación de la Máquina Virtual

### Pasos en VirtualBox:

1. **Abrir VirtualBox**
   - Haz clic en "Nueva" (o "New")

2. **Configurar información básica:**
   - Nombre: `CentOS_Lab5`
   - Tipo: `Linux`
   - Versión: `Red Hat (64-bit)`
   - Haz clic en "Siguiente"

3. **Memoria RAM:**
   - Asigna 2048 MB (2 GB) como mínimo
   - Recomendado: 4096 MB (4 GB)
   - Haz clic en "Siguiente"

4. **Disco duro:**
   - Selecciona "Crear un disco duro virtual ahora"
   - Haz clic en "Crear"

5. **Tipo de archivo de disco:**
   - Selecciona "VDI (VirtualBox Disk Image)"
   - Haz clic en "Siguiente"

6. **Almacenamiento:**
   - Selecciona "Reservado dinámicamente"
   - Haz clic en "Siguiente"

7. **Tamaño del disco:**
   - Asigna 20 GB
   - Haz clic en "Crear"

### Configuración adicional:

1. **Selecciona la VM** `CentOS_Lab5` en VirtualBox
2. Haz clic en "Configuración" (Settings)

3. **Sistema (System):**
   - Procesador: Asigna 2 CPUs si es posible
   - Habilita "PAE/NX"

4. **Almacenamiento (Storage):**
   - Haz clic en el icono del CD (vacío)
   - Haz clic en el icono del CD a la derecha
   - Selecciona "Choose a disk file..."
   - Busca y selecciona la ISO de CentOS descargada

5. **Red (Network):**
   - Adaptador 1: NAT (por defecto, está bien)
   - Para SSH desde el host, cambia a "Bridged Adapter"
   - O mantén NAT y configura port forwarding:
     - Haz clic en "Avanzado" > "Port Forwarding"
     - Agrega regla: Host Port: 2222, Guest Port: 22

6. Haz clic en "Aceptar"

**📸 CAPTURA**: Configuración de la VM completa

---

## 5. Instalación de CentOS

### Iniciar la instalación:

1. **Selecciona** la VM `CentOS_Lab5`
2. Haz clic en "Iniciar" (Start)
3. La VM arrancará desde la ISO

### Proceso de instalación de CentOS 7:

1. **Pantalla de bienvenida:**
   - Selecciona "Install CentOS 7"
   - Presiona Enter

2. **Idioma:**
   - Selecciona tu idioma preferido (Español o English)
   - Haz clic en "Continuar"

3. **Resumen de instalación:**

   **a. Fecha y Hora:**
   - Configura tu zona horaria
   - Clic en "Hecho"

   **b. Selección de Software:**
   - Selecciona "Server with GUI" (con interfaz gráfica) o "Minimal Install" (solo terminal)
   - **Recomendado**: Server with GUI para facilitar capturas de pantalla
   - Clic en "Hecho"

   **c. Destino de Instalación:**
   - Selecciona el disco de 20 GB
   - Deja "Automatically configure partitioning"
   - Clic en "Hecho"

   **d. Red y Nombre de Host:**
   - Activa la interfaz Ethernet (ON)
   - Nombre de host: `centos-lab5`
   - Clic en "Hecho"

4. **Iniciar instalación:**
   - Haz clic en "Begin Installation"

5. **Durante la instalación:**

   **a. Contraseña de Root:**
   - Haz clic en "Root Password"
   - Establece una contraseña (ejemplo: `root123`)
   - **ANÓTALA** - la necesitarás
   - Si es débil, haz clic dos veces en "Done"

   **b. Crear Usuario:**
   - Haz clic en "User Creation"
   - Nombre completo: `Admin`
   - Nombre de usuario: `admin`
   - Contraseña: `admin123`
   - Marca "Make this user administrator"
   - Clic en "Hecho"

6. **Esperar instalación:**
   - El proceso toma 10-20 minutos
   - Cuando termine, haz clic en "Reboot"

7. **Primer inicio:**
   - Si tiene GUI: Completa el asistente de bienvenida
   - Acepta la licencia
   - Finaliza configuración

**📸 CAPTURA**: Sistema instalado y funcionando

---

## 6. Configuración Inicial

### 6.1 Iniciar sesión

**Si instalaste con GUI:**
- Inicia sesión con usuario `admin` (contraseña: `admin123`)
- Abre una Terminal

**Si instalaste Minimal:**
- El login será directamente en terminal
- Usuario: `admin`, contraseña: `admin123`

### 6.2 Actualizar el sistema (OPCIONAL)

```bash
sudo yum update -y
```

**Nota**: Esto puede tomar varios minutos. Puedes saltarlo si tienes poco tiempo.

### 6.3 Instalar herramientas necesarias

```bash
# Instalar editor de texto
sudo yum install -y vim nano

# Instalar herramientas de red
sudo yum install -y net-tools openssh-server

# Habilitar SSH
sudo systemctl start sshd
sudo systemctl enable sshd

# Verificar IP de la máquina
ip addr show
```

**Anota la dirección IP** (algo como 10.0.2.15 o 192.168.x.x)

**📸 CAPTURA**: Terminal con la salida de `ip addr show`

### 6.4 Configurar firewall para SSH (si es necesario)

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

---

## 7. Transferir Scripts a la VM

Tienes 3 opciones:

### Opción 1: Usar SCP desde tu máquina host (RECOMENDADO)

**En tu máquina host (Windows/Mac/Linux), abre una terminal:**

```bash
# Navega a la carpeta donde están los scripts
cd /ruta/a/SistemasOperativosTarea5

# Copia los archivos a la VM
scp -P 2222 *.sh *.md admin@localhost:/home/admin/

# O si usas Bridged Adapter:
scp *.sh *.md admin@IP_DE_TU_VM:/home/admin/
```

**Contraseña**: `admin123`

### Opción 2: Clonar el repositorio Git (si lo subiste a GitHub)

**Dentro de la VM:**

```bash
# Instalar git
sudo yum install -y git

# Clonar el repositorio
cd ~
git clone https://github.com/TU_USUARIO/SistemasOperativosTarea5.git
cd SistemasOperativosTarea5
```

### Opción 3: Crear los scripts manualmente

**Dentro de la VM, crear cada archivo:**

```bash
cd ~
mkdir lab5
cd lab5

# Crear script 1
nano 1_crear_usuarios_grupos.sh
# Copia y pega el contenido del script
# Ctrl+O para guardar, Ctrl+X para salir

# Repetir para cada script y archivo .md
```

### Verificar archivos transferidos

```bash
ls -la ~/
# o
ls -la ~/SistemasOperativosTarea5/
```

**📸 CAPTURA**: Listado de archivos transferidos

---

## 8. Ejecución del Laboratorio

### 8.1 Preparar los scripts

```bash
# Ir al directorio de trabajo
cd ~/SistemasOperativosTarea5
# o
cd ~/lab5

# Dar permisos de ejecución a los scripts
chmod +x *.sh
```

### 8.2 Ejecutar Sección 4: Creación de Usuarios

```bash
sudo ./1_crear_usuarios_grupos.sh
```

**Qué hace este script:**
- Crea 3 usuarios de prueba (testuser1, testuser2, testuser3)
- Crea grupos (Professors, Assistents, Students)
- Crea usuarios del laboratorio (Jason, Luis, Diego, Josué, Viviana, Steven, Pedro, Juan, Harold)
- Asigna usuarios a sus grupos
- Verifica la creación con varios comandos

**IMPORTANTE**: Toma capturas de pantalla de:
- La ejecución completa del script
- La verificación de usuarios con `id`
- La salida de `finger`
- El contenido de `/etc/passwd` y `/etc/group`

**📸 CAPTURA**: Múltiples capturas de la ejecución del script

### Comandos de verificación manual:

```bash
# Ver información de un usuario
id Jason

# Ver con finger
finger Jason

# Ver en /etc/passwd
cat /etc/passwd | grep Jason

# Ver grupos
cat /etc/group | grep Professors
```

**📸 CAPTURA**: Cada comando de verificación

---

### 8.3 Ejecutar Sección 5: Permisos

**Abre el archivo de guía:**

```bash
cat 2_comandos_permisos.md
# O ábrelo con un editor
less 2_comandos_permisos.md
```

**Sigue PASO A PASO** los comandos en el archivo:

#### 5.1 Permisos en Archivos:

```bash
# Paso 1
touch /tmp/test
ls -l /tmp/test

# Paso 2a
chmod o+w /tmp/test
ls -l /tmp/test

# Paso 2b
chmod 666 /tmp/test
ls -l /tmp/test

# Paso 2c
chmod a-rwx /tmp/test
ls -l /tmp/test

# Paso 2d
cat /tmp/test

# Paso 2e
chmod u+rw /tmp/test
ls -l /tmp/test
```

**📸 CAPTURA**: Cada paso con su salida

#### 5.2 Permisos en Directorios:

```bash
# Paso 1
mkdir -p /tmp/mydirectory/mydir2

# Paso 2
ls -l /tmp/mydirectory
ls -ld /tmp/mydirectory

# Paso 3
chmod a-x /tmp/mydirectory
ls -ld /tmp/mydirectory

# Paso 4
cd /tmp/mydirectory
# Observa el error

# Paso 5
chmod ug+x /tmp/mydirectory
ls -ld /tmp/mydirectory

# Paso 6
ls -ld /tmp/mydirectory

# Paso 7
touch /tmp/miarchivo.txt
chmod 644 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt

chmod 755 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt

chmod 600 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt

chmod 000 /tmp/miarchivo.txt
ls -l /tmp/miarchivo.txt

mkdir /tmp/midirectorio
chmod 755 /tmp/midirectorio
ls -ld /tmp/midirectorio

chmod 700 /tmp/midirectorio
ls -ld /tmp/midirectorio

chmod 775 /tmp/midirectorio
ls -ld /tmp/midirectorio
```

**📸 CAPTURA**: Cada cambio de permisos

---

### 8.4 Ejecutar Sección 6: ACLs

**Abre el archivo de guía:**

```bash
less 3_comandos_ACL.md
```

**Ejecuta los pasos:**

```bash
# Paso 2: Intentar editar /etc/motd como usuario no-root
su - rootadmin
vim /etc/motd
# Observa que no puedes guardar
exit

# Paso 3: Agregar ACL
sudo setfacl -m u:rootadmin:rw /etc/motd

# Paso 4: Verificar ACL
getfacl /etc/motd

# Paso 5: Escribir como rootadmin
su - rootadmin
echo 'Welcome from rootadmin!' >> /etc/motd
cat /etc/motd
exit

# Paso 6: Conectar por SSH (abrir nueva terminal)
ssh rootadmin@localhost

# Paso 7-15: Continuar con los pasos del directorio colaborativo
sudo mkdir /var/tmp/collab
getfacl /var/tmp/collab
sudo setfacl -m d:u:rootadmin:rw /var/tmp/collab
getfacl /var/tmp/collab
sudo echo "rootfile contents" > /var/tmp/collab/rootfile
cat /var/tmp/collab/rootfile
getfacl /var/tmp/collab/rootfile
su - rootadmin
echo 'rootadmin was here' >> /var/tmp/collab/rootfile
exit
cat /var/tmp/collab/rootfile
```

**📸 CAPTURA**: TODOS los pasos de ACLs

---

### 8.5 Ejecutar Sección 7: Práctica Final

```bash
# Ejecutar script de práctica final
sudo ./4_practica_final.sh
```

**Este script crea:**
- Usuarios A, B, C
- Archivos F1, F2, F3
- ACLs según el diagrama

**Verificar con el script incluido:**

```bash
sudo bash /var/practica_lab5/verificar_permisos.sh
```

**Realizar pruebas manuales:**

```bash
# Prueba 1: Usuario B lee F1
su - B
cat /var/practica_lab5/F1
echo 'test' >> /var/practica_lab5/F1
# Debe fallar
exit

# Prueba 2: Usuario B escribe en F2
su - B
echo 'B escribió esto' >> /var/practica_lab5/F2
cat /var/practica_lab5/F2
exit

# Prueba 3: Usuario C lee F2
su - C
cat /var/practica_lab5/F2
echo 'test' >> /var/practica_lab5/F2
# Debe fallar
exit

# Prueba 4: Usuario C lee F3
su - C
cat /var/practica_lab5/F3
exit
```

**📸 CAPTURA**: Ejecución del script y todas las pruebas

---

## 9. Capturas de Pantalla

### Herramientas para capturar:

**En VirtualBox:**
- Máquina > Realizar captura de pantalla
- O usa la tecla de impresión de pantalla de tu sistema operativo

**Organizar las capturas:**

1. Crea una carpeta: `Capturas_Lab5`
2. Nombra las capturas de forma ordenada:
   ```
   01_instalacion_centos.png
   02_configuracion_red.png
   03_script_usuarios_inicio.png
   04_script_usuarios_fin.png
   05_verificacion_usuario_jason.png
   06_permisos_paso1.png
   ...
   50_practica_final_completa.png
   ```

### Capturas OBLIGATORIAS mínimas:

1. Sistema instalado
2. Ejecución completa del script de usuarios
3. Verificaciones de usuarios con `id`, `finger`, `/etc/passwd`
4. TODOS los pasos de permisos en archivos
5. TODOS los pasos de permisos en directorios
6. TODOS los pasos de ACLs
7. Ejecución del script de práctica final
8. Verificaciones de la práctica final
9. Pruebas manuales de permisos

**Total estimado**: 40-60 capturas de pantalla

---

## 10. Creación del Documento Final

### Estructura del documento PDF:

```
LABORATORIO 5 - SISTEMAS OPERATIVOS
Administración y Seguridad de la Información

Nombre: [Tu nombre completo]
Carné: [Tu carné]
Fecha: [Fecha de entrega]

================================================================================

SECCIÓN 1: PREGUNTAS GUÍA
================================================================================

1. Comandos useradd, userdel, passwd e IDs de usuarios
   [Respuesta completa con ejemplos]

2. Grupos primarios y grupos secundarios en Linux
   [Respuesta completa con ejemplos]

3. Cuadro comparativo entre Inode y ACL
   [Tabla comparativa]

4. Comando chmod - Métodos por letras y números
   [Explicación completa con ejemplos]

5. Tablas de particiones NTFS y EXT3/EXT4
   [Explicación de funcionamiento]

================================================================================

SECCIÓN 2: CREACIÓN DE USUARIOS
================================================================================

[Insertar capturas de pantalla con descripción]

Captura 1: Ejecución del script de creación de usuarios
[Imagen]
Descripción: Se ejecutó el script 1_crear_usuarios_grupos.sh...

Captura 2: Verificación del usuario Jason
[Imagen]
Descripción: Comando id Jason muestra...

[... más capturas ...]

================================================================================

SECCIÓN 3: PERMISOS EN ARCHIVOS
================================================================================

[Capturas de cada paso con explicación]

================================================================================

SECCIÓN 4: PERMISOS EN DIRECTORIOS
================================================================================

[Capturas de cada paso con explicación]

================================================================================

SECCIÓN 5: LISTAS DE CONTROL DE ACCESO (ACL)
================================================================================

[Capturas de cada paso con explicación]

================================================================================

SECCIÓN 6: PRÁCTICA FINAL (FIGURA 1)
================================================================================

[Capturas del script y verificaciones]

================================================================================

CONCLUSIONES
================================================================================

[Tus conclusiones sobre el laboratorio]

================================================================================

CÓDIGO FUENTE
================================================================================

Script 1: 1_crear_usuarios_grupos.sh
[Contenido del script]

Script 2: 4_practica_final.sh
[Contenido del script]
```

### Herramientas para crear el PDF:

**Opción 1: Microsoft Word / LibreOffice Writer**
- Crea el documento en Word/Writer
- Inserta las capturas
- Exporta como PDF

**Opción 2: Google Docs**
- Crea el documento en Google Docs
- Inserta las imágenes
- Archivo > Descargar > PDF

**Opción 3: LaTeX (avanzado)**
- Usa Overleaf.com
- Plantilla de reporte
- Inserta las capturas

---

## 11. Checklist Final

Antes de entregar, verifica:

- [ ] Todas las preguntas guía están respondidas completamente
- [ ] Tienes capturas de TODOS los pasos ejecutados
- [ ] Las capturas son claras y legibles
- [ ] Cada captura tiene una descripción/explicación
- [ ] Incluiste el código fuente de los scripts
- [ ] El documento está en formato PDF
- [ ] El documento tiene portada con tu nombre y carné
- [ ] Revisaste ortografía y redacción
- [ ] El profesor revisó tu trabajo antes de la entrega
- [ ] Subiste el archivo a TecDigital antes de la fecha límite

---

## 12. Solución de Problemas Comunes

### Problema: No puedo conectarme por SSH

**Solución:**
```bash
# En la VM
sudo systemctl status sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# Verifica IP
ip addr show
```

### Problema: "Permission denied" al ejecutar scripts

**Solución:**
```bash
chmod +x *.sh
```

### Problema: Los comandos fallan con "command not found"

**Solución:**
```bash
# Instalar herramientas faltantes
sudo yum install finger
sudo yum install acl
```

### Problema: No puedo usar `sudo`

**Solución:**
```bash
# Inicia sesión como root
su -
# Contraseña de root

# O agrega tu usuario al grupo wheel
usermod -aG wheel admin
```

### Problema: La VM está muy lenta

**Solución:**
- Asigna más RAM en VirtualBox (Settings > System > Memory)
- Asigna más CPUs (Settings > System > Processor)
- Cierra aplicaciones en tu computadora host

---

## 13. Recursos Adicionales

### Documentación oficial:
- CentOS: https://docs.centos.org/
- VirtualBox: https://www.virtualbox.org/manual/
- SSH: https://www.openssh.com/manual.html

### Tutoriales recomendados:
- Linux Journey: https://linuxjourney.com/
- Guru99 Linux: https://www.guru99.com/unix-linux-tutorial.html

### Comandos de referencia rápida:
```bash
# Gestión de usuarios
man useradd
man usermod
man userdel

# Permisos
man chmod
man chown

# ACLs
man setfacl
man getfacl
```

---

## 14. Contacto y Ayuda

**Profesor**: Jason Leitón

**Fecha de entrega**: 20 de Noviembre, 2025

**IMPORTANTE**:
- El laboratorio debe ser revisado por el profesor ANTES de la entrega
- Si no lo haces, la nota será cero
- Agenda una cita con tiempo

---

**¡Mucho éxito con tu laboratorio!**

---

**Creado por**: Asistente Claude
**Versión**: 1.0
**Fecha**: Noviembre 2025
