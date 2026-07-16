#!/bin/bash

# CampusX Resources Push Script - Update GitHub
# Usage: ./scripts/push.sh "Commit message"

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Not in a git repository${NC}"
    exit 1
fi

# Default commit message
COMMIT_MSG="${1:-Update: New resources fetched on $(date '+%Y-%m-%d %H:%M:%S')}"

echo "📤 Pushing CampusX resources to GitHub..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 1: Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}📍 Current branch: $CURRENT_BRANCH${NC}"

# Step 2: Show what will be committed
echo ""
echo "📊 Files to commit:"
git status --short

# Step 3: Stage all changes
echo ""
echo "📝 Staging changes..."
git add .

# Step 4: Commit
echo ""
echo -e "${YELLOW}💬 Committing with message:${NC}"
echo "   '$COMMIT_MSG'"
git commit -m "$COMMIT_MSG" || {
    echo -e "${YELLOW}⚠️  No changes to commit${NC}"
    exit 0
}

# Step 5: Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
git push origin $CURRENT_BRANCH

echo ""
echo -e "${GREEN}✅ Push completed successfully!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔗 View on GitHub:"
echo "   https://github.com/JignasaBhunia/CampusX_DS/commits/$CURRENT_BRANCH"
echo ""
