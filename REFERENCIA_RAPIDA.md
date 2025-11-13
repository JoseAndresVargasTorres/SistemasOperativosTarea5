# Referencia Rápida - Laboratorio 5
## Para estudiantes con experiencia en Linux

---

## Setup Rápido (5 minutos)

### 1. Preparación
```bash
# En tu VM de CentOS (como root o con sudo)
cd ~
git clone https://github.com/TU_USUARIO/SistemasOperativosTarea5.git
cd SistemasOperativosTarea5
chmod +x *.sh
```

### 2. Verificar requisitos
```bash
# Verificar que tienes las herramientas necesarias
which useradd usermod passwd groupadd
which chmod chown getfacl setfacl

# Si falta algo:
sudo yum install -y acl finger
```

---

## Ejecución Secuencial (30-45 minutos)

### Paso 1: Respuestas Teóricas (5 min)
```bash
cat RESPUESTAS_PREGUNTAS_GUIA.md > respuestas.txt
# Copia el contenido a tu documento Word/PDF
```

### Paso 2: Creación de Usuarios (5 min)
```bash
sudo ./1_crear_usuarios_grupos.sh | tee output_usuarios.txt
# CAPTURA: Toda la salida del script

# Verificaciones manuales:
id Jason
finger Luis
cat /etc/passwd | grep Diego
cat /etc/group | grep Professors
# CAPTURA: Cada verificación
```

### Paso 3: Permisos (10 min)
```bash
# Sigue 2_comandos_permisos.md paso a paso
# Ejecuta cada comando y toma captura

# Archivos:
touch /tmp/test && ls -l /tmp/test
chmod o+w /tmp/test && ls -l /tmp/test
chmod 666 /tmp/test && ls -l /tmp/test
chmod a-rwx /tmp/test && ls -l /tmp/test
cat /tmp/test  # Debe fallar
chmod u+rw /tmp/test && ls -l /tmp/test

# Directorios:
mkdir -p /tmp/mydirectory/mydir2
ls -l /tmp/mydirectory
ls -ld /tmp/mydirectory
chmod a-x /tmp/mydirectory
cd /tmp/mydirectory  # Debe fallar
chmod ug+x /tmp/mydirectory
ls -ld /tmp/mydirectory

# Práctica numérica:
touch /tmp/archivo1 && chmod 644 /tmp/archivo1 && ls -l /tmp/archivo1
chmod 755 /tmp/archivo1 && ls -l /tmp/archivo1
chmod 600 /tmp/archivo1 && ls -l /tmp/archivo1
mkdir /tmp/dir1 && chmod 755 /tmp/dir1 && ls -ld /tmp/dir1
chmod 700 /tmp/dir1 && ls -ld /tmp/dir1
```

### Paso 4: ACLs (10 min)
```bash
# Crear usuario rootadmin si no existe
sudo useradd rootadmin
echo "admin123" | sudo passwd --stdin rootadmin

# ACL en archivo
sudo setfacl -m u:rootadmin:rw /etc/motd
getfacl /etc/motd
su - rootadmin
echo 'Welcome from rootadmin!' >> /etc/motd
exit
cat /etc/motd

# ACL en directorio
sudo mkdir /var/tmp/collab
getfacl /var/tmp/collab
sudo setfacl -m d:u:rootadmin:rw /var/tmp/collab
getfacl /var/tmp/collab
sudo sh -c "echo 'rootfile contents' > /var/tmp/collab/rootfile"
getfacl /var/tmp/collab/rootfile
su - rootadmin
echo 'rootadmin was here' >> /var/tmp/collab/rootfile
exit
cat /var/tmp/collab/rootfile
```

### Paso 5: Práctica Final (10 min)
```bash
# Ejecutar script
sudo ./4_practica_final.sh | tee output_practica.txt
# CAPTURA: Salida completa

# Verificar
sudo bash /var/practica_lab5/verificar_permisos.sh
# CAPTURA: Verificación

# Pruebas manuales
su - B
cat /var/practica_lab5/F1  # OK
echo 'test' >> /var/practica_lab5/F1  # FAIL
exit

su - B
cat /var/practica_lab5/F2  # OK
echo 'B escribió' >> /var/practica_lab5/F2  # OK
exit

su - C
cat /var/practica_lab5/F2  # OK
echo 'test' >> /var/practica_lab5/F2  # FAIL
cat /var/practica_lab5/F3  # OK
exit
# CAPTURA: Todas las pruebas
```

---

## Comandos de Verificación Rápida

```bash
# Ver todos los usuarios creados
cat /etc/passwd | grep -E "(testuser|Jason|Luis|Diego|Josue|Viviana|Steven|Pedro|Juan|Harold|^A:|^B:|^C:)"

# Ver todos los grupos
cat /etc/group | grep -E "(Professors|Assistents|Students)"

# Ver ACLs de todos los archivos de la práctica
getfacl /var/practica_lab5/*

# Verificar estructura completa
tree /var/practica_lab5  # (instalar: yum install tree)
# o
ls -laR /var/practica_lab5
```

---

## Checklist de Capturas (Mínimo 40 capturas)

**Sección 4: Usuarios (10 capturas)**
- [ ] Script completo ejecutándose
- [ ] Salida de verificaciones
- [ ] id de al menos 3 usuarios
- [ ] finger de al menos 2 usuarios
- [ ] /etc/passwd entries
- [ ] /etc/group entries

**Sección 5: Permisos (15 capturas)**
- [ ] Cada paso de permisos en archivos (5 pasos)
- [ ] Cada paso de permisos en directorios (7 pasos)
- [ ] Práctica con representación numérica (3 ejemplos)

**Sección 6: ACLs (10 capturas)**
- [ ] Intentar editar /etc/motd (falla)
- [ ] setfacl en /etc/motd
- [ ] getfacl /etc/motd
- [ ] Escribir en /etc/motd exitosamente
- [ ] Login SSH mostrando mensaje
- [ ] ACL por defecto en directorio
- [ ] Archivo heredando ACL
- [ ] Pruebas de escritura

**Sección 7: Práctica Final (5 capturas)**
- [ ] Ejecución del script
- [ ] Script de verificación
- [ ] Pruebas con usuario B
- [ ] Pruebas con usuario C
- [ ] getfacl de los 3 archivos

---

## Comandos One-Liner Útiles

```bash
# Ver todos los permisos de un archivo en detalle
stat -c '%A %U:%G %n' /ruta/archivo

# Ver ACLs de múltiples archivos
for f in F1 F2 F3; do echo "=== $f ==="; getfacl /var/practica_lab5/$f; done

# Backup de ACLs
getfacl -R /var/practica_lab5 > backup_acls.txt

# Listar usuarios con UID >= 1000 (usuarios regulares)
awk -F: '$3 >= 1000 {print $1, "UID:", $3}' /etc/passwd

# Ver grupos de un usuario
groups Jason

# Ver miembros de un grupo
getent group Professors

# Verificar si un usuario puede leer/escribir/ejecutar
sudo -u B test -r /var/practica_lab5/F1 && echo "Puede leer" || echo "NO puede leer"
sudo -u B test -w /var/practica_lab5/F1 && echo "Puede escribir" || echo "NO puede escribir"
```

---

## Estructura del Documento Final PDF

```
1. PORTADA
   - Nombre, carné, fecha

2. PREGUNTAS GUÍA (6-8 páginas)
   - Pregunta 1: useradd, userdel, passwd, UIDs
   - Pregunta 2: Grupos primarios y secundarios
   - Pregunta 3: Tabla Inode vs ACL
   - Pregunta 4: chmod con letras y números
   - Pregunta 5: NTFS vs EXT3/4

3. SECCIÓN 4: CREACIÓN DE USUARIOS (3-4 páginas)
   - Capturas del script
   - Verificaciones con id, finger, etc.

4. SECCIÓN 5: PERMISOS (5-6 páginas)
   - 5.1 Archivos: capturas paso a paso
   - 5.2 Directorios: capturas paso a paso
   - Práctica numérica

5. SECCIÓN 6: ACLs (4-5 páginas)
   - ACL en archivo /etc/motd
   - ACL en directorio colaborativo
   - Todas las verificaciones

6. SECCIÓN 7: PRÁCTICA FINAL (3-4 páginas)
   - Ejecución del script
   - Verificaciones
   - Pruebas manuales

7. CÓDIGO FUENTE (2-3 páginas)
   - 1_crear_usuarios_grupos.sh
   - 4_practica_final.sh

8. CONCLUSIONES (1 página)

Total: ~25-30 páginas
```

---

## Solución Rápida de Problemas

| Error | Solución |
|-------|----------|
| Permission denied | `sudo` o `su -` |
| Command not found: finger | `sudo yum install finger` |
| Command not found: setfacl | `sudo yum install acl` |
| Usuario ya existe | `sudo userdel -r usuario && sudo useradd usuario` |
| ACL no funciona | Verificar que el filesystem soporte ACLs: `mount \| grep acl` |
| No puedo hacer SSH | `sudo systemctl start sshd` |

---

## Tiempo Estimado Total

- Setup inicial: 5 min
- Sección 4 (Usuarios): 15 min
- Sección 5 (Permisos): 20 min
- Sección 6 (ACLs): 20 min
- Sección 7 (Práctica): 15 min
- Capturas y documentación: 60-90 min

**Total: 2-3 horas** (sin contar preguntas teóricas ni instalación de VM)

---

## Tips Finales

1. **Automatiza las capturas**: Usa un script de captura automática si tu VM lo permite
2. **Nombra las capturas ordenadamente**: `01_script_usuarios.png`, `02_id_jason.png`, etc.
3. **Verifica antes de continuar**: Cada sección debe funcionar antes de pasar a la siguiente
4. **Backup**: Guarda copias de tus scripts y capturas en múltiples lugares
5. **Tiempo**: Empieza con anticipación, no dejes para última hora

---

**Última actualización**: Noviembre 2025
