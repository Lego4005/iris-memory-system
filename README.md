# Iris Memory System

Memory management and persistence system for Iris AI, featuring context tracking, state management, and MCP integration.

## Features

- Context tracking
- State management
- MCP integration
- Memory persistence

## Installation

```bash
npm install
```

## Usage

```bash
npm run build
npm start
```

## Development

```bash
npm run dev
```

## Development Workflow

This project follows a structured development workflow with specific branching and commit patterns. See [Git Workflow Guidelines](git-workflow.md) for detailed information about:

- Branching strategy
- Commit message patterns
- Pair programming practices
- Code review process
- Memory bank integration

### Quick Start for Development

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name main
   ```

2. Make changes and commit using conventional commit format:
   ```bash
   git commit -m "feat: Add your feature"
   # For pair programming:
   git commit -m "pair(iris): Implement specific functionality"
   ```

3. Push changes and merge when complete

### Setting Up in a New Project

When copying these files to a new or existing project:

1. Copy the required files:
   ```bash
   cp setup-git-workflow.sh /path/to/your/project/
   cp git-workflow.md /path/to/your/project/
   ```

2. Make the setup script executable:
   ```bash
   chmod +x setup-git-workflow.sh
   ```

3. Run the setup script:
   ```bash
   ./setup-git-workflow.sh
   ```

The setup script will:
- Initialize git if needed
- Configure your git user information
- Update package.json repository URLs
- Set up commit message validation
- Configure pre-commit hooks for linting and formatting

## License

Apache-2.0