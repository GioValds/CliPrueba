#!/bin/bash

# Simulador del pipeline de CI para ejecución local

echo "🧪 EJECUTANDO CI LOCAL - Flutter Testing Demo"

# Configuración
FLUTTER_VERSION=$(flutter --version | head -1)
echo "Flutter: $FLUTTER_VERSION"

# Ejecutar el runner principal
./scripts/ci_runner.sh

# Verificación adicional de métricas
echo ""
echo "📈 MÉTRICAS DEL PROYECTO:"
echo "----------------------------"

# Contar pruebas
UNIT_TESTS=$(find test -name "*_test.dart" | wc -l)
echo "• Pruebas unitarias: $UNIT_TESTS archivos"

# Calcular líneas de código aproximadas
LOC=$(find lib -name "*.dart" -exec cat {} \; | wc -l)
echo "• Líneas de código: $LOC"

# Verificar cobertura si existe
if [ -f "coverage/lcov.info" ]; then
    COVERAGE=$(lcov --summary coverage/lcov.info 2>/dev/null | grep "lines" | awk '{print $2}' || echo "N/A")
    echo "• Cobertura aproximada: $COVERAGE"
fi

echo ""
echo "✅ CI LOCAL COMPLETADO"
echo "📋 Next: git add . && git commit -m 'feat: add complete test suite' && git push"