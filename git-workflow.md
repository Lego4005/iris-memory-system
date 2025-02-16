# Git Workflow Guidelines

## Repository Configuration

### Default Settings
- Default repository owner: Lego4005 (personal account)
- Default visibility: public (unless explicitly marked private)
- Default branch: main

## Commit Patterns

### Regular Development
```
feat: Add new feature
fix: Fix bug
docs: Update documentation
chore: Maintenance tasks
refactor: Code refactoring
test: Add or update tests
style: Code style updates
```

### Pair Programming Commits
Format: `pair(iris): Brief description`

Examples:
```
pair(iris): Implement memory context manager
pair(iris): Add state persistence layer
pair(iris): Refactor context loading system
```

## Branching Strategy

### Branch Types
- `main`: Production-ready code
- `feature/*`: New feature development
- `fix/*`: Bug fixes
- `docs/*`: Documentation updates

### Branch Naming
```
feature/add-memory-context
feature/implement-state-manager
fix/context-loading-error
docs/update-api-docs
```

### Workflow Steps
1. Create feature branch from main
   ```bash
   git checkout -b feature/feature-name main
   ```

2. Regular commits during development
   ```bash
   git commit -m "feat: Add specific feature component"
   git commit -m "pair(iris): Implement specific functionality"
   ```

3. Before merging:
   - Review changes
   - Run tests
   - Update documentation

4. Merge back to main
   ```bash
   git checkout main
   git merge feature/feature-name
   ```

## Automated Workflows

### Pre-commit Hooks
- Code formatting (Prettier)
- Linting (ESLint)
- Type checking (TypeScript)

### Commit Message Validation
- Enforce conventional commit format
- Require scope for pair programming commits
- Validate description length and format

## Development Guidelines

### Feature Development
1. Create new branch for each feature
2. Make regular, small commits
3. Update relevant documentation
4. Add necessary tests
5. Merge when feature is complete

### Pair Programming Sessions
1. Use pair programming commit format
2. Document key decisions
3. Regular commits for trackable progress
4. Update technical documentation

### Code Review Process
1. Self-review changes
2. Run automated tests
3. Check documentation updates
4. Verify against requirements
5. Merge if all checks pass

## Memory Bank Integration

### Context Updates
- Update memory bank files after significant changes
- Document architectural decisions
- Track system evolution
- Maintain technical context

### State Management
- Regular checkpoints during development
- Document state transitions
- Track context changes
- Maintain system patterns