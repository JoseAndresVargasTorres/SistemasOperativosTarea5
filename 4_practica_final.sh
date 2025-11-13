#!/bin/bash

# ============================================================================
# Script: Práctica Final - Sección 7 (Figura 1)
# Descripción: Crea la estructura de usuarios, archivos y ACLs según diagrama
# Autor: Laboratorio Sistemas Operativos
# Fecha: Noviembre 2025
# ============================================================================

echo "=========================================="
echo "  Práctica Final - Figura 1"
echo "  Estructura de Usuarios, Archivos y ACLs"
echo "=========================================="
echo ""

# ============================================================================
# Verificar que se ejecuta como root/sudo
# ============================================================================
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Este script debe ejecutarse como root o con sudo"
    echo "Uso: sudo bash $0"
    exit 1
fi

echo "[VERIFICACIÓN] Ejecutando como root... OK"
echo ""

# ============================================================================
# SECCIÓN 1: Crear los usuarios propietarios A, B, C
# ============================================================================
echo "=========================================="
echo "[PASO 1] Creando usuarios propietarios"
echo "=========================================="
echo ""

# Usuario A
echo "  > Creando usuario A..."
if id "A" &>/dev/null; then
    echo "    - Usuario A ya existe, saltando..."
else
    useradd A
    echo "passwordA" | passwd --stdin A
    echo "    - Usuario A creado (contraseña: passwordA)"
fi

# Usuario B
echo "  > Creando usuario B..."
if id "B" &>/dev/null; then
    echo "    - Usuario B ya existe, saltando..."
else
    useradd B
    echo "passwordB" | passwd --stdin B
    echo "    - Usuario B creado (contraseña: passwordB)"
fi

# Usuario C
echo "  > Creando usuario C..."
if id "C" &>/dev/null; then
    echo "    - Usuario C ya existe, saltando..."
else
    useradd C
    echo "passwordC" | passwd --stdin C
    echo "    - Usuario C creado (contraseña: passwordC)"
fi

echo ""
echo "[PASO 1] Completado - 3 usuarios creados (A, B, C)"
echo ""

# ============================================================================
# SECCIÓN 2: Crear directorio base para los archivos
# ============================================================================
echo "=========================================="
echo "[PASO 2] Creando directorio base"
echo "=========================================="
echo ""

BASEDIR="/var/practica_lab5"

echo "  > Creando directorio: $BASEDIR"
if [ -d "$BASEDIR" ]; then
    echo "    - Directorio ya existe, eliminando contenido previo..."
    rm -rf "$BASEDIR"
fi

mkdir -p "$BASEDIR"
echo "    - Directorio $BASEDIR creado"

echo ""
echo "[PASO 2] Completado"
echo ""

# ============================================================================
# SECCIÓN 3: Crear archivos F1, F2, F3 con sus propietarios
# ============================================================================
echo "=========================================="
echo "[PASO 3] Creando archivos con propietarios"
echo "=========================================="
echo ""

# Archivo F1 - Propietario A
echo "  > Creando archivo F1 (propietario: A)..."
touch "$BASEDIR/F1"
chown A:A "$BASEDIR/F1"
echo "Contenido inicial de F1 - Propietario: A" > "$BASEDIR/F1"
echo "    - F1 creado y asignado a usuario A"

# Archivo F2 - Propietario A (según diagrama, F2 también es de A)
echo "  > Creando archivo F2 (propietario: A)..."
touch "$BASEDIR/F2"
chown A:A "$BASEDIR/F2"
echo "Contenido inicial de F2 - Propietario: A" > "$BASEDIR/F2"
echo "    - F2 creado y asignado a usuario A"

# Archivo F3 - Propietario B (según diagrama)
echo "  > Creando archivo F3 (propietario: B)..."
touch "$BASEDIR/F3"
chown B:B "$BASEDIR/F3"
echo "Contenido inicial de F3 - Propietario: B" > "$BASEDIR/F3"
echo "    - F3 creado y asignado a usuario B"

echo ""
echo "[PASO 3] Completado - 3 archivos creados"
echo ""

# ============================================================================
# SECCIÓN 4: Configurar permisos base de los archivos
# ============================================================================
echo "=========================================="
echo "[PASO 4] Configurando permisos base"
echo "=========================================="
echo ""

echo "  > Estableciendo permisos iniciales..."
# Dar permisos base: propietario puede todo, grupo y otros nada por ahora
chmod 600 "$BASEDIR/F1"
chmod 600 "$BASEDIR/F2"
chmod 600 "$BASEDIR/F3"

echo "    - F1: rw------- (600)"
echo "    - F2: rw------- (600)"
echo "    - F3: rw------- (600)"

echo ""
echo "[PASO 4] Completado"
echo ""

# ============================================================================
# SECCIÓN 5: Configurar ACLs según el diagrama de la Figura 1
# ============================================================================
echo "=========================================="
echo "[PASO 5] Configurando ACLs según Figura 1"
echo "=========================================="
echo ""

# ---------------------------------------------------------------------------
# Análisis del diagrama Figura 1:
#
# Proceso → Propietario (A, B, C)
# Archivo → ACL
#
# F1 → A: RW,  B: R
# F2 → A: R,   B:RW,  C:R
# F3 → B:RWX,  C: RX
# ---------------------------------------------------------------------------

echo "  [F1] Configurando ACLs para F1..."
echo "      - Propietario: A (ya tiene permisos completos)"
echo "      - Agregando: B con permiso de lectura (R)"

# F1: A tiene RW (ya es propietario), B tiene R
setfacl -m u:B:r "$BASEDIR/F1"

echo "      ✓ ACL aplicada: B puede leer F1"
echo ""

echo "  [F2] Configurando ACLs para F2..."
echo "      - Propietario: A con lectura (R)"
echo "      - Agregando: B con RW, C con R"

# F2: A tiene R (modificamos permisos del propietario), B tiene RW, C tiene R
chmod 400 "$BASEDIR/F2"  # Propietario solo lectura
setfacl -m u:B:rw "$BASEDIR/F2"
setfacl -m u:C:r "$BASEDIR/F2"

echo "      ✓ ACL aplicada: A solo lectura, B puede leer/escribir, C puede leer"
echo ""

echo "  [F3] Configurando ACLs para F3..."
echo "      - Propietario: B con RWX (lectura, escritura, ejecución)"
echo "      - Agregando: C con RX (lectura y ejecución)"

# F3: B tiene RWX (es propietario), C tiene RX
chmod 700 "$BASEDIR/F3"  # Propietario: rwx
setfacl -m u:C:rx "$BASEDIR/F3"

echo "      ✓ ACL aplicada: B tiene todos los permisos, C puede leer/ejecutar"
echo ""

echo "[PASO 5] Completado - ACLs configuradas"
echo ""

# ============================================================================
# SECCIÓN 6: Verificar configuración
# ============================================================================
echo "=========================================="
echo "[PASO 6] Verificación de la configuración"
echo "=========================================="
echo ""

echo "  ARCHIVOS CREADOS:"
echo "  ----------------------------------------"
ls -l "$BASEDIR"
echo ""

echo "  ACLs DE F1:"
echo "  ----------------------------------------"
getfacl "$BASEDIR/F1"
echo ""

echo "  ACLs DE F2:"
echo "  ----------------------------------------"
getfacl "$BASEDIR/F2"
echo ""

echo "  ACLs DE F3:"
echo "  ----------------------------------------"
getfacl "$BASEDIR/F3"
echo ""

echo "[PASO 6] Completado"
echo ""

# ============================================================================
# SECCIÓN 7: Pruebas de permisos
# ============================================================================
echo "=========================================="
echo "[PASO 7] Pruebas de Permisos"
echo "=========================================="
echo ""

echo "  Estas pruebas verifican que los permisos funcionen correctamente."
echo "  Las ejecutarás MANUALMENTE después de ejecutar este script."
echo ""

echo "  PRUEBAS A REALIZAR:"
echo "  ----------------------------------------"
echo ""

echo "  1. Prueba con usuario B leyendo F1:"
echo "     su - B"
echo "     cat $BASEDIR/F1          # Debe funcionar (B tiene lectura)"
echo "     echo 'test' >> $BASEDIR/F1   # Debe fallar (B no tiene escritura)"
echo "     exit"
echo ""

echo "  2. Prueba con usuario B escribiendo en F2:"
echo "     su - B"
echo "     cat $BASEDIR/F2          # Debe funcionar (B tiene lectura)"
echo "     echo 'B escribió esto' >> $BASEDIR/F2   # Debe funcionar (B tiene escritura)"
echo "     exit"
echo ""

echo "  3. Prueba con usuario C leyendo F2:"
echo "     su - C"
echo "     cat $BASEDIR/F2          # Debe funcionar (C tiene lectura)"
echo "     echo 'test' >> $BASEDIR/F2   # Debe fallar (C no tiene escritura)"
echo "     exit"
echo ""

echo "  4. Prueba con usuario C ejecutando F3 (si es script):"
echo "     su - C"
echo "     cat $BASEDIR/F3          # Debe funcionar (C tiene lectura)"
echo "     $BASEDIR/F3              # Debe funcionar si F3 es ejecutable (C tiene ejecución)"
echo "     echo 'test' >> $BASEDIR/F3   # Debe fallar (C no tiene escritura)"
echo "     exit"
echo ""

echo "[PASO 7] Instrucciones de prueba mostradas"
echo ""

# ============================================================================
# SECCIÓN 8: Crear script de verificación
# ============================================================================
echo "=========================================="
echo "[PASO 8] Creando script de verificación"
echo "=========================================="
echo ""

VERIFY_SCRIPT="$BASEDIR/verificar_permisos.sh"

cat > "$VERIFY_SCRIPT" << 'EOF'
#!/bin/bash
# Script de verificación automática de permisos

BASEDIR="/var/practica_lab5"

echo "=========================================="
echo "  VERIFICACIÓN DE PERMISOS"
echo "=========================================="
echo ""

echo "ESTRUCTURA DE ARCHIVOS:"
echo "----------------------------------------"
ls -la "$BASEDIR"
echo ""

echo "PERMISOS Y ACLs:"
echo "----------------------------------------"
echo ""

for archivo in F1 F2 F3; do
    echo "=== $archivo ==="
    ls -l "$BASEDIR/$archivo"
    getfacl "$BASEDIR/$archivo" 2>/dev/null | grep -E "^(user|group|other):"
    echo ""
done

echo "PROPIETARIOS:"
echo "----------------------------------------"
echo "F1: $(stat -c '%U' $BASEDIR/F1)"
echo "F2: $(stat -c '%U' $BASEDIR/F2)"
echo "F3: $(stat -c '%U' $BASEDIR/F3)"
echo ""

echo "RESUMEN DE PERMISOS (según Figura 1):"
echo "----------------------------------------"
echo "F1: A(RW) + B(R)"
echo "F2: A(R) + B(RW) + C(R)"
echo "F3: B(RWX) + C(RX)"
echo ""
EOF

chmod +x "$VERIFY_SCRIPT"
echo "  > Script de verificación creado: $VERIFY_SCRIPT"
echo "    Ejecútalo con: sudo bash $VERIFY_SCRIPT"
echo ""

echo "[PASO 8] Completado"
echo ""

# ============================================================================
# RESUMEN FINAL
# ============================================================================
echo "=========================================="
echo "  RESUMEN FINAL"
echo "=========================================="
echo ""
echo "✓ Usuarios creados: A, B, C"
echo "✓ Directorio base: $BASEDIR"
echo "✓ Archivos creados: F1, F2, F3"
echo "✓ ACLs configuradas según Figura 1"
echo ""
echo "ESTRUCTURA IMPLEMENTADA:"
echo "----------------------------------------"
echo ""
echo "  Propietarios:"
echo "    A ─→ F1 (rw)"
echo "    B ─→ F3 (rwx)"
echo "    C"
echo ""
echo "  Archivos y ACLs:"
echo "    F1 → A: RW,  B: R"
echo "    F2 → A: R,   B: RW,  C: R"
echo "    F3 → B: RWX, C: RX"
echo ""
echo "=========================================="
echo "  PRÓXIMOS PASOS"
echo "=========================================="
echo ""
echo "1. Ejecuta el script de verificación:"
echo "   sudo bash $VERIFY_SCRIPT"
echo ""
echo "2. Toma capturas de pantalla de:"
echo "   - La salida de este script"
echo "   - La salida del script de verificación"
echo "   - Las pruebas manuales de permisos (Paso 7)"
echo ""
echo "3. Verifica visualmente con:"
echo "   ls -l $BASEDIR"
echo "   getfacl $BASEDIR/F1"
echo "   getfacl $BASEDIR/F2"
echo "   getfacl $BASEDIR/F3"
echo ""
echo "=========================================="
echo "  SCRIPT COMPLETADO EXITOSAMENTE"
echo "=========================================="
echo ""
