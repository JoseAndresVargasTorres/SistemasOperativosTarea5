# Laboratorio 5 - Sistemas Operativos
## Administración y Seguridad de la Información

**Instituto Tecnológico de Costa Rica**
**Curso**: CE 4303 - Principios de Sistemas Operativos
**Profesor**: Jason Leitón
**Fecha de entrega**: 20 de Noviembre, 2025

---

## Descripción

Este repositorio contiene todos los recursos necesarios para completar el Laboratorio 5 sobre Administración y Seguridad de la Información en Linux (CentOS).

---

## Contenido del Repositorio

### 📄 Documentos de Referencia

1. **`Laboratorio5_Sistemas_Operativos.pdf`**
   - Especificación oficial del laboratorio
   - Instrucciones y requisitos completos

2. **`RESPUESTAS_PREGUNTAS_GUIA.md`**
   - Respuestas completas a las 5 preguntas guía
   - Explicaciones detalladas sobre:
     - Comandos `useradd`, `userdel`, `passwd` e IDs de usuarios
     - Grupos primarios y secundarios
     - Comparación Inode vs ACL
     - Comando `chmod` (métodos simbólico y numérico)
     - Sistemas de archivos NTFS y EXT3/EXT4

3. **`GUIA_COMPLETA_INSTALACION.md`**
   - Guía paso a paso completa desde cero
   - Instalación de VirtualBox
   - Instalación de CentOS
   - Configuración inicial
   - Ejecución de todo el laboratorio
   - Creación del documento final

### 🔧 Scripts de Automatización

4. **`1_crear_usuarios_grupos.sh`**
   - Script para crear usuarios y grupos (Sección 4)
   - Crea 3 usuarios de prueba
   - Crea 3 grupos (Professors, Assistents, Students)
   - Crea 9 usuarios del laboratorio
   - Asigna usuarios a grupos
   - Verifica la configuración

5. **`4_practica_final.sh`**
   - Script para la práctica final (Sección 7 - Figura 1)
   - Crea usuarios A, B, C
   - Crea archivos F1, F2, F3
   - Configura ACLs según el diagrama
   - Incluye script de verificación automática

### 📖 Guías de Comandos

6. **`2_comandos_permisos.md`**
   - Guía detallada de la Sección 5 (Permisos)
   - Todos los comandos paso a paso
   - Explicaciones de cada resultado
   - Permisos en archivos y directorios
   - Tablas de referencia

7. **`3_comandos_ACL.md`**
   - Guía detallada de la Sección 6 (ACLs)
   - Todos los comandos paso a paso
   - Explicaciones de `getfacl` y `setfacl`
   - ACLs por defecto
   - Ejemplos prácticos completos

---

## Cómo Usar Este Repositorio

### Opción 1: Seguir la Guía Completa (Recomendado para principiantes)

1. Abre `GUIA_COMPLETA_INSTALACION.md`
2. Sigue TODOS los pasos en orden
3. Desde la instalación de VirtualBox hasta la entrega final

### Opción 2: Uso Rápido (Si ya tienes CentOS instalado)

1. **Clonar este repositorio en tu VM de CentOS:**
   ```bash
   git clone https://github.com/TU_USUARIO/SistemasOperativosTarea5.git
   cd SistemasOperativosTarea5
   ```

2. **Dar permisos de ejecución a los scripts:**
   ```bash
   chmod +x *.sh
   ```

3. **Ejecutar cada sección:**

   **Sección 3: Preguntas Guía**
   ```bash
   cat RESPUESTAS_PREGUNTAS_GUIA.md
   # Copia las respuestas a tu documento
   ```

   **Sección 4: Creación de Usuarios**
   ```bash
   sudo ./1_crear_usuarios_grupos.sh
   # Toma capturas de pantalla de todo
   ```

   **Sección 5: Permisos**
   ```bash
   cat 2_comandos_permisos.md
   # Ejecuta cada comando manualmente
   # Toma capturas de cada paso
   ```

   **Sección 6: ACLs**
   ```bash
   cat 3_comandos_ACL.md
   # Ejecuta cada comando manualmente
   # Toma capturas de cada paso
   ```

   **Sección 7: Práctica Final**
   ```bash
   sudo ./4_practica_final.sh
   # Ejecuta las pruebas manuales indicadas
   # Toma capturas de todo
   ```

4. **Compilar tu documento PDF con:**
   - Respuestas a las preguntas guía
   - Todas las capturas de pantalla
   - Código fuente de los scripts

---

## Estructura del Laboratorio

```
┌─────────────────────────────────────────┐
│  LABORATORIO 5 - ESTRUCTURA             │
└─────────────────────────────────────────┘

1. Preguntas Guía (Teóricas)
   └─> RESPUESTAS_PREGUNTAS_GUIA.md

2. Sección 4: Creación de Usuarios
   └─> 1_crear_usuarios_grupos.sh

3. Sección 5: Permisos
   ├─> 5.1 Archivos
   └─> 5.2 Directorios
   └─> 2_comandos_permisos.md

4. Sección 6: ACLs
   └─> 3_comandos_ACL.md

5. Sección 7: Práctica Final (Figura 1)
   └─> 4_practica_final.sh

6. Entregable
   └─> Documento PDF con capturas y respuestas
```

---

## Requisitos

### Software
- VirtualBox (o VMware)
- CentOS 7 o CentOS Stream 9
- Mínimo 2 GB RAM para la VM
- 20 GB de espacio en disco

### Conocimientos previos
- Comandos básicos de Linux
- Uso de terminal/consola
- Conceptos básicos de usuarios y permisos

---

## Checklist de Entrega

Antes de entregar, asegúrate de tener:

- [ ] **Preguntas Guía**: Todas respondidas con explicaciones completas
- [ ] **Sección 4**: Capturas de creación de usuarios y grupos
- [ ] **Sección 5**: Capturas de TODOS los pasos de permisos
- [ ] **Sección 6**: Capturas de TODOS los pasos de ACLs
- [ ] **Sección 7**: Capturas de la práctica final completa
- [ ] **Código fuente**: Scripts incluidos en el documento
- [ ] **Formato**: Documento en PDF
- [ ] **Revisión**: El profesor revisó tu trabajo antes de entregar
- [ ] **Plazo**: Entregado antes del 20 de Noviembre, 2025

---

## Notas Importantes

1. **DEBES tomar capturas de pantalla de CADA paso ejecutado**
2. **El profesor debe revisar tu trabajo ANTES de la entrega** (si no, nota = 0)
3. **El trabajo es INDIVIDUAL**
4. **Incluye el código fuente de los scripts en tu documento**
5. **Sube el PDF a TecDigital antes de la fecha límite**

---

## Archivos Generados Durante la Ejecución

El script de práctica final creará:

```
/var/practica_lab5/
├── F1                          # Archivo con ACLs: A(RW), B(R)
├── F2                          # Archivo con ACLs: A(R), B(RW), C(R)
├── F3                          # Archivo con ACLs: B(RWX), C(RX)
└── verificar_permisos.sh       # Script de verificación
```

---

## Solución de Problemas

### Error: "Permission denied" al ejecutar script
```bash
chmod +x nombre_del_script.sh
sudo ./nombre_del_script.sh
```

### Error: "command not found: finger"
```bash
sudo yum install finger -y
```

### Error: No puedo usar sudo
```bash
su -
# Ingresa contraseña de root
# Luego ejecuta los comandos
```

### La VM está muy lenta
- Asigna más RAM en VirtualBox (Settings > System)
- Asigna más CPUs (Settings > System > Processor)
- Cierra aplicaciones innecesarias en tu computadora

---

## Recursos Adicionales

- **Documentación CentOS**: https://docs.centos.org/
- **Manual de chmod**: `man chmod`
- **Manual de setfacl**: `man setfacl`
- **Tutorial de ACLs**: https://wiki.archlinux.org/title/Access_Control_Lists

---

## Contacto

**Profesor**: Jason Leitón
**Curso**: CE 4303 - Principios de Sistemas Operativos
**Instituto**: Tecnológico de Costa Rica

---

## Licencia

Este material es exclusivamente para uso académico del curso CE 4303.

---

**Última actualización**: Noviembre 2025

**¡Buena suerte con tu laboratorio!** 🚀
