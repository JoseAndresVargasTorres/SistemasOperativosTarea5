#!/bin/bash

# ============================================================================
# Script: Creación de Usuarios y Grupos - Laboratorio 5
# Descripción: Automatiza la creación de usuarios y grupos según especificación
# Autor: Laboratorio Sistemas Operativos
# Fecha: Noviembre 2025
# ============================================================================

echo "=========================================="
echo "  Laboratorio 5 - Creación de Usuarios"
echo "=========================================="
echo ""

# ============================================================================
# SECCIÓN 1: Verificar que se ejecuta como root/sudo
# ============================================================================
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Este script debe ejecutarse como root o con sudo"
    echo "Uso: sudo bash $0"
    exit 1
fi

echo "[PASO 1] Verificando permisos de administrador... OK"
echo ""

# ============================================================================
# SECCIÓN 2: Crear los primeros 3 usuarios de prueba
# ============================================================================
echo "[PASO 2] Creando 3 usuarios iniciales de prueba..."
echo ""

# Usuario 1
echo "  > Creando usuario: testuser1"
useradd testuser1
echo "password123" | passwd --stdin testuser1
echo "    - Usuario testuser1 creado con contraseña: password123"

# Usuario 2
echo "  > Creando usuario: testuser2"
useradd testuser2
echo "password456" | passwd --stdin testuser2
echo "    - Usuario testuser2 creado con contraseña: password456"

# Usuario 3
echo "  > Creando usuario: testuser3"
useradd testuser3
echo "password789" | passwd --stdin testuser3
echo "    - Usuario testuser3 creado con contraseña: password789"

echo ""
echo "[PASO 2] Completado - 3 usuarios creados"
echo ""

# ============================================================================
# SECCIÓN 3: Verificar creación de usuarios
# ============================================================================
echo "[PASO 3] Verificando usuarios creados..."
echo ""

for user in testuser1 testuser2 testuser3; do
    echo "  Información de $user:"
    echo "  ----------------------------------------"
    id $user
    echo ""
done

echo "[PASO 3] Completado"
echo ""

# ============================================================================
# SECCIÓN 4: Instalar el comando finger (si no está instalado)
# ============================================================================
echo "[PASO 4] Verificando e instalando herramienta 'finger'..."

if ! command -v finger &> /dev/null; then
    echo "  > Instalando finger..."
    yum install finger -y > /dev/null 2>&1
    echo "  > Finger instalado correctamente"
else
    echo "  > Finger ya está instalado"
fi

echo ""
echo "[PASO 4] Completado"
echo ""

# ============================================================================
# SECCIÓN 5: Mostrar información detallada con finger
# ============================================================================
echo "[PASO 5] Información detallada de usuarios (finger)..."
echo ""

for user in testuser1 testuser2 testuser3; do
    echo "  Finger de $user:"
    echo "  ----------------------------------------"
    finger $user
    echo ""
done

echo "[PASO 5] Completado"
echo ""

# ============================================================================
# SECCIÓN 6: Crear los grupos según la tabla especificada
# ============================================================================
echo "[PASO 6] Creando grupos del laboratorio..."
echo ""

# Grupo Profesores
echo "  > Creando grupo: Professors"
groupadd Professors
echo "    - Grupo Professors creado"

# Grupo Asistentes
echo "  > Creando grupo: Assistents"
groupadd Assistents
echo "    - Grupo Assistents creado"

# Grupo Estudiantes
echo "  > Creando grupo: Students"
groupadd Students
echo "    - Grupo Students creado"

echo ""
echo "[PASO 6] Completado - 3 grupos creados"
echo ""

# ============================================================================
# SECCIÓN 7: Crear usuarios y asignarlos a sus grupos
# ============================================================================
echo "[PASO 7] Creando usuarios del laboratorio y asignándolos a grupos..."
echo ""

# ---- PROFESORES ----
echo "  GRUPO PROFESSORS:"
echo "  > Creando usuario: Jason"
useradd Jason
echo "profpass1" | passwd --stdin Jason
usermod -aG Professors Jason
echo "    - Jason creado y agregado a Professors"

echo "  > Creando usuario: Luis"
useradd Luis
echo "profpass2" | passwd --stdin Luis
usermod -aG Professors Luis
echo "    - Luis creado y agregado a Professors"

echo "  > Creando usuario: Diego"
useradd Diego
echo "profpass3" | passwd --stdin Diego
usermod -aG Professors Diego
echo "    - Diego creado y agregado a Professors"

echo ""

# ---- ASISTENTES ----
echo "  GRUPO ASSISTENTS:"
echo "  > Creando usuario: Josue"
useradd Josue
echo "assistpass1" | passwd --stdin Josue
usermod -aG Assistents Josue
echo "    - Josue creado y agregado a Assistents"

echo "  > Creando usuario: Viviana"
useradd Viviana
echo "assistpass2" | passwd --stdin Viviana
usermod -aG Assistents Viviana
echo "    - Viviana creado y agregado a Assistents"

echo "  > Creando usuario: Steven"
useradd Steven
echo "assistpass3" | passwd --stdin Steven
usermod -aG Assistents Steven
echo "    - Steven creado y agregado a Assistents"

echo ""

# ---- ESTUDIANTES ----
echo "  GRUPO STUDENTS:"
echo "  > Creando usuario: Pedro"
useradd Pedro
echo "studpass1" | passwd --stdin Pedro
usermod -aG Students Pedro
echo "    - Pedro creado y agregado a Students"

echo "  > Creando usuario: Juan"
useradd Juan
echo "studpass2" | passwd --stdin Juan
usermod -aG Students Juan
echo "    - Juan creado y agregado a Students"

echo "  > Creando usuario: Harold"
useradd Harold
echo "studpass3" | passwd --stdin Harold
usermod -aG Students Harold
echo "    - Harold creado y agregado a Students"

echo ""
echo "[PASO 7] Completado - 9 usuarios creados y asignados"
echo ""

# ============================================================================
# SECCIÓN 8: Verificar grupos y membresías
# ============================================================================
echo "[PASO 8] Verificando grupos y sus miembros..."
echo ""

echo "  VERIFICACIÓN DE GRUPOS:"
echo "  ========================================"
echo ""

echo "  Grupo Professors:"
cat /etc/group | grep Professors
echo ""

echo "  Grupo Assistents:"
cat /etc/group | grep Assistents
echo ""

echo "  Grupo Students:"
cat /etc/group | grep Students
echo ""

echo "[PASO 8] Completado"
echo ""

# ============================================================================
# SECCIÓN 9: Mostrar información detallada de cada usuario
# ============================================================================
echo "[PASO 9] Información detallada de todos los usuarios creados..."
echo ""

usuarios=(Jason Luis Diego Josue Viviana Steven Pedro Juan Harold)

for user in "${usuarios[@]}"; do
    echo "  Usuario: $user"
    echo "  ----------------------------------------"
    echo "  ID info:"
    id $user
    echo ""
    echo "  Entrada en /etc/passwd:"
    cat /etc/passwd | grep "^$user:"
    echo ""
    echo "  Grupos:"
    cat /etc/group | grep $user
    echo "  ========================================"
    echo ""
done

echo "[PASO 9] Completado"
echo ""

# ============================================================================
# RESUMEN FINAL
# ============================================================================
echo "=========================================="
echo "  RESUMEN DE USUARIOS Y GRUPOS CREADOS"
echo "=========================================="
echo ""
echo "USUARIOS DE PRUEBA (3):"
echo "  - testuser1 (contraseña: password123)"
echo "  - testuser2 (contraseña: password456)"
echo "  - testuser3 (contraseña: password789)"
echo ""
echo "GRUPOS CREADOS (3):"
echo "  - Professors: Jason, Luis, Diego"
echo "  - Assistents: Josue, Viviana, Steven"
echo "  - Students: Pedro, Juan, Harold"
echo ""
echo "=========================================="
echo "  SCRIPT COMPLETADO EXITOSAMENTE"
echo "=========================================="
echo ""
echo "PRÓXIMOS PASOS:"
echo "  1. Toma capturas de pantalla de esta salida"
echo "  2. Ejecuta los comandos de verificación manualmente:"
echo "     - id <nombre_usuario>"
echo "     - finger <nombre_usuario>"
echo "     - cat /etc/passwd | grep <nombre_usuario>"
echo "     - cat /etc/group | grep <nombre_grupo>"
echo ""
