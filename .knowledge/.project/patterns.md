# NixOS Module Patterns

## 🎯 Core Patterns

### 1. Extension Registry Pattern
**Use when**: Adding modular, optional functionality

```nix
# Base module
options.service._extensions = mkOption {
  type = types.listOf types.deferredModule;
  default = [];
  internal = true;
};

# Extension registration  
config.service._extensions = [
  { options.feature = { ... }; }
];

# Dynamic type composition
serviceType = types.submoduleWith {
  modules = [ baseModule ] ++ cfg._extensions;
};
```

### 2. Option Extension Pattern
**Use when**: Extending existing option sets

```nix
# Extend existing options
options.modules.newOption = mkOption { ... };

# Don't redefine the entire modules block
# ❌ options.modules = { ... };
# ✅ options.modules.newOption = mkOption { ... };
```

### 3. Assertion Pattern
**Use when**: Validating configuration

```nix
config.assertions = [
  {
    assertion = condition;
    message = "Clear error message with solution";
  }
];
```

### 4. Enable Option Pattern
**Use when**: Optional features with dependencies

```nix
options.modules.feature.enable = mkEnableOption "feature";

config = mkIf cfg.feature.enable {
  # Feature implementation
};
```

## 🧪 Testing Patterns

### Type Validation
```bash
# Basic evaluation test
nix eval .#nixosConfigurations.host.options.modules.option

# Build test  
nix flake check

# Full build test
nixos-rebuild dry-build --flake .#host
```

### LSP Integration
- Use proper option descriptions for nixd
- Include examples in option definitions
- Test autocompletion manually in editor

## ⚠️ Common Pitfalls

### Option Conflicts
```nix
# ❌ This creates conflicts
options.modules = { optionA = ...; };
options.modules = { optionB = ...; };

# ✅ Extend instead
options.modules.optionA = ...;
options.modules.optionB = ...;
```

### Extension Load Order
- Extensions loaded via imports order
- Use `default = [];` for extension registries
- Test with multiple extensions

### Type System
- Use specific types over generic ones
- Add validation through assertions  
- Provide clear error messages

## 🔬 Advanced Type System Patterns

### submoduleWith Usage
```nix
types.submoduleWith {
  modules = [ baseModule ] ++ extensionModules;
  specialArgs = { inherit pkgs; };
  shorthandOnlyDefinesConfig = false;
}
```

### deferredModule Usage
```nix
# For modules that need late evaluation
types.deferredModule

# Or with static modules for documentation
types.deferredModuleWith { staticModules = [ docModule ]; }
```

### Cross-Module Assertions
```nix
config.assertions = [
  {
    assertion = let
      monitors = cfg.monitors;
      primaryCount = length (filter (m: m.primary) monitors);
    in primaryCount == 1;
    message = "Exactly one monitor must be primary";
  }
];
```

## 🎯 LSP Integration Details

### nixd Discovery Requirements
- nixd discovers options through option declarations
- Dynamic types via submoduleWith are supported
- Extension options must be properly declared
- Use detailed descriptions for documentation

### Type Information for LSP
```nix
options.field = mkOption {
  type = types.str;
  description = "Detailed description for LSP";
  example = "example value";
  default = "default";
};
```

## 🔧 Best Practices

### Extension Design
1. Use internal options for extension registries
2. Provide clear extension APIs
3. Validate extension compatibility
4. Document extension points

### Type Safety
1. Use specific types over generic ones
2. Provide validation through assertions
3. Use enum types for limited choices
4. Add type constraints where needed

### Documentation
- Include detailed descriptions
- Provide working examples
- Document extension interfaces
- Add default value explanations

### Performance
- Use lazy evaluation where possible
- Avoid deep recursion in type checking
- Cache expensive computations
- Minimize module evaluation overhead

### Maintainability
- Keep modules focused and small
- Use consistent naming conventions
- Separate options from implementations
- Archive completed experimental work
