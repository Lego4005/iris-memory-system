#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up Git workflow configuration...${NC}"

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo -e "${BLUE}Initializing git repository...${NC}"
    git init
fi

# Configure git to use main as default branch
git config --local init.defaultBranch main

# Get GitHub username
echo -e "${BLUE}Checking git configuration...${NC}"
GIT_USERNAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -z "$GIT_USERNAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo -e "${RED}Git user configuration not found${NC}"
    echo -e "${BLUE}Please enter your GitHub username:${NC}"
    read -r USERNAME
    echo -e "${BLUE}Please enter your GitHub email:${NC}"
    read -r EMAIL

    git config --global user.name "$USERNAME"
    git config --global user.email "$EMAIL"
    echo -e "${GREEN}Git user configuration updated${NC}"
fi

# Update repository URLs in package.json if it exists
if [ -f "package.json" ]; then
    echo -e "${BLUE}Updating package.json repository URLs...${NC}"
    # Extract repository name from current directory
    REPO_NAME=$(basename "$PWD")
    USERNAME=$(git config --global user.name)

    # Use sed to update repository URL
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS version
        sed -i '' "s|\"url\": \".*\"|\"url\": \"git+https://github.com/$USERNAME/$REPO_NAME.git\"|" package.json
        sed -i '' "s|\"bugs\": {\"url\": \".*\"}|\"bugs\": {\"url\": \"https://github.com/$USERNAME/$REPO_NAME/issues\"}|" package.json
        sed -i '' "s|\"homepage\": \".*\"|\"homepage\": \"https://github.com/$USERNAME/$REPO_NAME#readme\"|" package.json
    else
        # Linux version
        sed -i "s|\"url\": \".*\"|\"url\": \"git+https://github.com/$USERNAME/$REPO_NAME.git\"|" package.json
        sed -i "s|\"bugs\": {\"url\": \".*\"}|\"bugs\": {\"url\": \"https://github.com/$USERNAME/$REPO_NAME/issues\"}|" package.json
        sed -i "s|\"homepage\": \".*\"|\"homepage\": \"https://github.com/$USERNAME/$REPO_NAME#readme\"|" package.json
    fi
    echo -e "${GREEN}package.json updated with new repository URLs${NC}"
fi

# Set up git hooks directory
if [ ! -d ".git/hooks" ]; then
    mkdir -p .git/hooks
fi

# Create commit-msg hook for commit message validation
echo -e "${BLUE}Setting up commit message hook...${NC}"
cat > .git/hooks/commit-msg << 'EOF'
#!/bin/bash

# Colors for output
RED='\033[0;31m'
NC='\033[0m' # No Color

# Commit message file
MSG_FILE=$1
MSG_CONTENT=$(cat "$MSG_FILE")

# Patterns to validate
CONVENTIONAL_PATTERN='^(feat|fix|docs|style|refactor|test|chore)(\([a-z]+\))?: .+'
PAIR_PATTERN='^pair\(iris\): .+'

if [[ ! $MSG_CONTENT =~ $CONVENTIONAL_PATTERN ]] && [[ ! $MSG_CONTENT =~ $PAIR_PATTERN ]]; then
    echo -e "${RED}Error: Commit message format is invalid${NC}"
    echo "It should match either:"
    echo "1. Conventional format: feat: message"
    echo "   Examples: feat: add feature, fix: resolve bug"
    echo "2. Pair programming format: pair(iris): message"
    echo "   Example: pair(iris): implement feature"
    exit 1
fi

# Check message length
if [ ${#MSG_CONTENT} -gt 72 ]; then
    echo -e "${RED}Error: Commit message is too long (max 72 characters)${NC}"
    exit 1
fi
EOF

# Make the hook executable
chmod +x .git/hooks/commit-msg

# Create pre-commit hook for linting and formatting
echo -e "${BLUE}Setting up pre-commit hook...${NC}"
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Running pre-commit checks...${NC}"

# Run prettier if available
if command -v prettier &> /dev/null && [ -f "package.json" ]; then
    echo "Running prettier..."
    npx prettier --write "**/*.{js,jsx,ts,tsx,json,md}" || exit 1
fi

# Run eslint if available
if command -v eslint &> /dev/null && [ -f "package.json" ]; then
    echo "Running eslint..."
    npx eslint . --ext .js,.jsx,.ts,.tsx || exit 1
fi

# Run TypeScript compiler if available
if command -v tsc &> /dev/null && [ -f "tsconfig.json" ]; then
    echo "Running TypeScript compiler..."
    npx tsc --noEmit || exit 1
fi

git add -A
EOF

# Make the hook executable
chmod +x .git/hooks/pre-commit

echo -e "${GREEN}Git workflow setup complete!${NC}"
echo -e "${BLUE}Remember to:${NC}"
echo "1. Create feature branches for new work"
echo "2. Follow commit message conventions"
echo "3. Run tests before merging"
echo "4. Keep documentation updated"
