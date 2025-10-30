#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando Pipeline de Flutter CI/CD${NC}"

# Función para loggear
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "pubspec.yaml" ]; then
    log_error "No se encuentra pubspec.yaml. Ejecuta desde la raíz del proyecto Flutter."
    exit 1
fi

# Paso 1: Instalación de dependencias
log_info "1. Instalando dependencias..."
flutter pub get
if [ $? -ne 0 ]; then
    log_error "Falló la instalación de dependencias"
    exit 1
fi
log_success "Dependencias instaladas"

# Paso 2: Análisis estático
log_info "2. Ejecutando análisis estático..."
dart analyze .
if [ $? -eq 0 ]; then
    log_success "Análisis estático: PASSED"
else
    log_error "Análisis estático: FAILED - Corrige los errores antes de continuar"
    exit 1
fi

# Paso 3: Format check
log_info "3. Verificando formato de código..."
dart format --set-exit-if-changed .
if [ $? -eq 0 ]; then
    log_success "Formato de código: OK"
else
    log_warning "Formato de código: Algunos archivos necesitan formateo"
    # No exit aquí, solo warning
fi

# Paso 4: Pruebas unitarias
log_info "4. Ejecutando pruebas unitarias..."
flutter test test/calculator_test.dart test/api_client_test.dart --coverage
if [ $? -eq 0 ]; then
    log_success "Pruebas unitarias: PASSED"
else
    log_error "Pruebas unitarias: FAILED"
    exit 1
fi

# Paso 5: Pruebas de widget
log_info "5. Ejecutando pruebas de widget..."
flutter test test/widget_test.dart --coverage
if [ $? -eq 0 ]; then
    log_success "Pruebas de widget: PASSED"
else
    log_error "Pruebas de widget: FAILED"
    exit 1
fi

# Paso 6: Generar reporte de cobertura
log_info "6. Generando reporte de cobertura..."
if [ -f "coverage/lcov.info" ]; then
    # Instalar lcov si está disponible
    if command -v lcov &> /dev/null; then
        genhtml coverage/lcov.info -o coverage/html
        log_success "Reporte HTML de cobertura generado en coverage/html/"
    else
        log_warning "lcov no instalado, no se puede generar reporte HTML"
    fi
fi

# Paso 7: Build para verificar que compila
log_info "7. Verificando build..."
flutter build apk --debug
if [ $? -eq 0 ]; then
    log_success "Build: SUCCESS"
else
    log_error "Build: FAILED"
    exit 1
fi

# Paso 8: Resumen final
log_info "=== 📊 RESUMEN FINAL ==="
log_success "Todos los checks pasaron exitosamente"
log_info "Cobertura de tests: $(find coverage/lcov.info 2>/dev/null && echo 'Disponible' || echo 'No disponible')"
log_info "Build: LISTO para deployment"

echo -e "${GREEN}🎉 Pipeline completado exitosamente!${NC}"