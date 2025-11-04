PROTO_DIR := proto
GEN_DIR := gen
BUF := buf

clean:
	@echo "🧹 Cleaning generated code..."
	@rm -rf $(GEN_DIR)

go:
	@echo "🧩 Generating Go server stubs (Gateway)..."
	@$(BUF) generate --template ./buf.gen.go.yaml --path $(PROTO_DIR)/beacon/v1

analytics:
	@echo "📊 Generating Python client (Analytics Service)..."
	@$(BUF) generate --template ./buf.gen.python.yaml --path $(PROTO_DIR)/beacon/v1/analytics.proto
	@$(BUF) generate --template ./buf.gen.python.yaml --path $(PROTO_DIR)/beacon/v1/common/types.proto

crew:
	@echo "📱 Generating Dart client (Crew App)..."
	@$(BUF) generate --template ./buf.gen.dart.yaml --path $(PROTO_DIR)/beacon/v1/crew.proto

pwa:
	@echo "⚡ Generating TypeScript client (PWA)..."
	@$(BUF) generate --template ./buf.gen.ts.yaml --path $(PROTO_DIR)/beacon/v1/public.proto

all: go analytics crew pwa

push:
	@echo "🚀 Publishing schema to Buf.build..."
	@$(BUF) push

help:
	@echo "Usage:"
	@echo "  make pwa          Generate TypeScript client for PWA"
	@echo "  make crew         Generate Dart client for Crew App"
	@echo "  make analytics    Generate Python client for Analytics Service"
	@echo "  make go           Generate Go stubs for Gateway"
	@echo "  make generate     Generate all targets"
	@echo "  make clean        Remove generated code"
	@echo "  make publish      Push schema to Buf.build"
