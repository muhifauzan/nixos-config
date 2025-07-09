#!/usr/bin/env bash

# Quick test after fixing workspace option conflict

echo "🧪 Testing after workspace option fix"
echo "======================================"

cd /projects/personal/nixos-config

echo "📋 Testing flake check..."
if nix flake check --no-build 2>&1; then
    echo "✅ Flake check passed!"
else
    echo "❌ Flake check still failing. Let me show the error:"
    echo ""
    nix flake check --no-build 2>&1 | head -20
    exit 1
fi

echo ""
echo "📋 Testing monitor option evaluation..."
if nix eval .#nixosConfigurations.acinonyx.options.modules.monitors.type.description --raw 2>&1; then
    echo ""
    echo "✅ Monitor options are working!"
else
    echo "❌ Monitor option still failing:"
    nix eval .#nixosConfigurations.acinonyx.options.modules.monitors.type.description 2>&1
fi
