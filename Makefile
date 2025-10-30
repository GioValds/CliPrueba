# Flutter Testing Demo - Comandos de Desarrollo

.PHONY: test analyze format clean build integration coverage

# Análisis de código
analyze:
	@echo "🔍 Analizando código..."
	dart analyze .

# Formatear código
format:
	@echo "🎨 Formateando código..."
	dart format .

# Ejecutar todas las pruebas
test:
	@echo "🧪 Ejecutando todas las pruebas..."
	flutter test

# Pruebas unitarias específicas
test-unit:
	@echo "🔬 Ejecutando pruebas unitarias..."
	flutter test test/calculator_test.dart test/api_client_test.dart

# Pruebas de widget
test-widget:
	@echo "🎯 Ejecutando pruebas de widget..."
	flutter test test/widget_test.dart

# Pruebas de integración
test-integration:
	@echo "🌐 Ejecutando pruebas de integración..."
	flutter test integration_test/app_test.dart

# Cobertura de tests
coverage:
	@echo "📊 Generando cobertura..."
	flutter test --coverage
	genhtml coverage/lcov.info -o coverage/html
	@echo "📁 Reporte en: coverage/html/index.html"

# Limpiar proyecto
clean:
	@echo "🧹 Limpiando proyecto..."
	flutter clean
	rm -rf coverage/

# Ejecutar CI local
ci-local:
	@echo "🚀 Ejecutando CI local..."
	./scripts/ci_runner.sh

# Build para producción
build:
	@echo "🏗️ Compilando aplicación..."
	flutter build apk --release
	flutter build appbundle --release

# Dependencias
deps:
	@echo "📦 Instalando dependencias..."
	flutter pub get

# Help
help:
	@echo "Comandos disponibles:"
	@echo "  make analyze     - Analizar código"
	@echo "  make format      - Formatear código"
	@echo "  make test        - Ejecutar todas las pruebas"
	@echo "  make test-unit   - Solo pruebas unitarias"
	@echo "  make test-widget - Solo pruebas de widget"
	@echo "  make coverage    - Generar reporte de cobertura"
	@echo "  make ci-local    - Ejecutar pipeline CI local"
	@echo "  make clean       - Limpiar proyecto"
	@echo "  make build       - Compilar aplicación"