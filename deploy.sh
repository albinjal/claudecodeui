#!/bin/bash

# Claude Code UI Deployment Script
# This script builds and deploys the application

echo "🚀 Starting deployment..."

# Stop PM2 process if running
pm2 stop claude-code-ui || true

# Pull latest changes (if using git)
echo "📥 Pulling latest changes..."
git pull origin main || echo "No git repository found, skipping pull"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build the application
echo "🔨 Building application..."
npm run build

# Start/restart with PM2
echo "🟢 Starting application with PM2..."
pm2 start ecosystem.config.cjs --env production

# Save PM2 process list
pm2 save

# Reload nginx
echo "🔄 Reloading nginx..."
sudo systemctl reload nginx

echo "✅ Deployment complete!"
echo "🔍 Application status:"
pm2 status
