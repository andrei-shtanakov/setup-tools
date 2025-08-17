.PHONY: all main full-setup update tools dev-tools linux-tools devops-tools make-executable clean

# Default target
all: main

# Make all scripts executable
make-executable:
	@echo "Making scripts executable..."
	@chmod +x update.sh tools.sh dev-tools.sh linux-tools.sh devops-tools.sh
	@echo "Scripts are now executable."

# Main setup (update + tools + dev-tools)
main: make-executable update tools dev-tools
	@echo "Main setup completed successfully!"

# Full setup (all scripts)
full-setup: make-executable update tools dev-tools linux-tools devops-tools
	@echo "Full workstation setup completed successfully!"

# Individual script targets
update: make-executable
	@echo "Running system update..."
	@./update.sh

tools: make-executable
	@echo "Installing essential tools..."
	@./tools.sh

dev-tools: make-executable
	@echo "Installing development tools..."
	@./dev-tools.sh

linux-tools: make-executable
	@echo "Installing Linux utilities..."
	@./linux-tools.sh

devops-tools: make-executable
	@echo "Installation DevOps tools..."
	@./devops-tools.sh

# Clean target (if needed)
clean:
	@echo "Nothing to clean."

# Help target
help:
	@echo "Available targets:"
	@echo "  main          - Run main setup (update + tools + dev-tools)"
	@echo "  full-setup    - Run full workstation setup (all scripts)"
	@echo "  update        - Update system packages"
	@echo "  tools         - Install essential tools"
	@echo "  dev-tools     - Install development tools"
	@echo "  linux-tools   - Install Linux utilities"
	@echo "  devops-tools  - Install Terraform, aws-cli, configure Git"
	@echo "  make-executable - Make all scripts executable"
	@echo "  help          - Show this help message"
