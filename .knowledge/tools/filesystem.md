# Filesystem Tool Usage Strategies

## 🎯 **CORE PRINCIPLE**: Use the Right Tool for the Task

**Performance Rule**: Minimize tool calls, maximize information per call
**Path Rule**: Always use full absolute paths to avoid access denied errors
**Error Rule**: Handle path failures gracefully with alternatives

---

## 📋 **TOOL INVENTORY & OPTIMAL USE CASES**

### 1. **EXPLORATION & DISCOVERY**

#### `filesystem:list_allowed_directories`
**When**: Session start, path confusion, debugging access issues
**Strategy**: Always call first when encountering path problems
```
Use for: Initial orientation, troubleshooting, verification
Frequency: Once per session or when paths fail
```

#### `filesystem:list_directory`
**When**: Understanding folder structure, finding files, quick inventory
**Strategy**: Use for rapid exploration and file discovery
```
Optimal for: Initial exploration, finding specific files, understanding structure
Avoid: When you need file sizes (use list_directory_with_sizes instead)
```

#### `filesystem:list_directory_with_sizes`
**When**: Archive cleanup, storage analysis, finding large files
**Strategy**: Use when size information affects decisions
```
Optimal for: Cleanup operations, storage optimization, file size analysis
Sort by: Size for cleanup tasks, name for organization
```

#### `filesystem:directory_tree`
**When**: Understanding hierarchical structure, documentation, complex navigation
**Strategy**: Use for comprehensive structure analysis
```
Optimal for: Architecture understanding, documentation, complex project layouts
Warning: Can be large - use sparingly for deep hierarchies
```

#### `filesystem:search_files`
**When**: Finding files by pattern, content hunting, cross-directory search
**Strategy**: Use broad patterns first, narrow with excludePatterns
```
Optimal for: Finding files by name pattern, hunting for specific content
Pattern tips: Start broad ("config"), narrow as needed
Exclude: Use excludePatterns for .git, node_modules, etc.
```

### 2. **READING & ANALYSIS**

#### `filesystem:read_file`
**When**: Single file content needed, analyzing specific files
**Strategy**: Use absolute paths, handle errors gracefully
```
Optimal for: Reading individual files, content analysis
Path handling: Always use full absolute path from project root
Error handling: If fails, check with list_directory first
```

#### `filesystem:read_multiple_files`
**When**: Comparing files, batch analysis, related file reading
**Strategy**: Group related files to reduce round trips
```
Optimal for: Reading session files together, comparing configurations
Efficiency: Better than multiple read_file calls
Failure handling: Individual file failures don't block others
```

#### `filesystem:get_file_info`
**When**: Need metadata without content, checking permissions, size analysis
**Strategy**: Use before reading large files or when metadata sufficient
```
Optimal for: Metadata analysis, permission checking, size verification
Use before: Reading large files to check size first
```

### 3. **MODIFICATION & MAINTENANCE**

#### `filesystem:write_file`
**When**: Creating new files, complete file replacement, initial content
**Strategy**: Use for new files or complete rewrites
```
Optimal for: New file creation, complete content replacement
Warning: Overwrites existing files without warning
Safety: Only use when complete replacement intended
```

#### `filesystem:edit_file`
**When**: Updating existing files, targeted changes, line-based modifications
**Strategy**: Use dryRun first for complex edits, ensure exact text matches
```
Optimal for: Real-time session updates, targeted file modifications
Critical: oldText must match EXACTLY including whitespace
Workflow: Use dryRun=true first for complex edits
Text matching: Must be perfectly unique in file
```

#### `filesystem:create_directory`
**When**: Setting up new structure, ensuring paths exist
**Strategy**: Create parent directories as needed
```
Optimal for: New project setup, ensuring directory structure
Behavior: Creates nested directories, succeeds if already exists
Safety: Safe to call multiple times
```

#### `filesystem:move_file`
**When**: Reorganizing files, renaming, archiving
**Strategy**: Use for cleanup, organization, file lifecycle management
```
Optimal for: File reorganization, archiving, renaming
Limitation: Fails if destination exists
Use for: Moving to archive, reorganizing structure
```

---

## 🚀 **USAGE PATTERNS BY SCENARIO**

### **Session Start Pattern**
```
1. list_allowed_directories (orientation)
2. list_directory on project root (overview)
3. read_multiple_files for session files
4. directory_tree if structure unclear
```

### **File Discovery Pattern**
```
1. search_files with broad pattern
2. list_directory on likely locations
3. read_file once located
4. get_file_info if size/permissions matter
```

### **Content Analysis Pattern**
```
1. list_directory to find related files
2. read_multiple_files for batch reading
3. search_files if pattern-based hunting needed
4. edit_file for real-time updates
```

### **Maintenance Pattern**
```
1. list_directory_with_sizes (sorted by size)
2. get_file_info for specific files
3. move_file for archiving
4. create_directory for organization
```

### **Real-time Documentation Pattern**
```
1. edit_file with dryRun=true (verify changes)
2. edit_file with actual changes
3. read_file to confirm results
4. Update multiple session files as needed
```

---

## ⚠️ **CRITICAL ERROR HANDLING**

### **Path Access Issues**
```
Problem: "Access denied - path outside allowed directories"
Solution:
1. Call list_allowed_directories
2. Use full absolute path from project root
3. Check path construction with list_directory
```

### **Edit File Failures**
```
Problem: oldText doesn't match exactly
Solution:
1. Use dryRun=true first
2. Check exact text with read_file
3. Include all whitespace and line endings
4. Ensure text is unique in file
```

### **File Not Found**
```
Problem: Path doesn't exist
Solution:
1. Use list_directory on parent
2. Use search_files if pattern unclear
3. Check spelling and case sensitivity
```

---

## 📊 **PERFORMANCE OPTIMIZATION**

### **Minimize Round Trips**
- Use `read_multiple_files` instead of multiple `read_file` calls
- Use `list_directory_with_sizes` when size matters
- Batch related operations

### **Path Efficiency**
- Always use absolute paths from allowed directories
- Cache directory listings when exploring
- Use `search_files` for pattern-based discovery

### **Real-time Updates**
- Use `edit_file` for incremental changes
- Use `write_file` only for new files or complete replacement
- Update session files immediately during work

---

## 🎯 **SUCCESS METRICS**

### **Efficiency Indicators**
- ✅ First tool call succeeds (good path management)
- ✅ Minimal round trips for related operations
- ✅ Appropriate tool selection for task

### **Reliability Indicators**
- ✅ No "access denied" errors
- ✅ Edit operations succeed on first try
- ✅ Real-time documentation maintained

### **System Health Indicators**
- ✅ Session files consistently updated
- ✅ Archive maintenance performed efficiently
- ✅ File organization maintained

---

*Created during session 2025-07-12 UTC - Real-time tool usage optimization*
