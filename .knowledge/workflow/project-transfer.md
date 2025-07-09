# Project Transfer Guide

## 🚀 Copying .knowledge to New Projects

### Overview
The `.knowledge` system is designed to be transferable while keeping project-specific knowledge separate. This guide explains what to copy, what to leave behind, and how to set up for a new project.

## 📁 What to Copy vs Leave Behind

### **COPY** (Transferable System)
```
SOURCE_PROJECT/.knowledge/
├── session/                    # Structure + formats (reset content)
│   ├── context.md             # Template format, clear content
│   ├── progress.md            # Template format, clear content  
│   ├── next-steps.md          # Template format, clear content
│   └── handoff.md            # Template format, clear content
├── workflow/                  # Complete directory (all files)
│   ├── session-setup.md      # This guide you're reading
│   ├── session-patterns.md   # Reusable approaches
│   ├── project-transfer.md   # Transfer instructions
│   ├── evolution-cycle.md    # Knowledge evolution process
│   ├── feedback-integration.md # Feedback processing
│   ├── maintenance.md        # Regular knowledge hygiene
│   ├── metrics.md           # Performance tracking
│   ├── feedback-requests.md # When to ask for help
│   └── evolution.md         # System improvement tracking
├── README.md                 # System overview
└── session-start.md         # Onboarding checklist
```

### **LEAVE BEHIND** (Project-Specific)
```
SOURCE_PROJECT/.knowledge/
├── .project/                 # Entire directory (project-specific)
│   ├── project-context.md   # Tech stack, team, setup
│   ├── architecture.md      # System design
│   ├── patterns.md         # Domain-specific patterns
│   └── tech-stack.md       # Technologies used
└── .archive/                # Entire directory (project history)
    └── *.md                 # All archived work
```

## 🔧 Transfer Process

### **STEP 1: Copy Structure**
```bash
# Copy transferable files to new project
cp -r SOURCE/.knowledge/session/ NEW_PROJECT/.knowledge/
cp -r SOURCE/.knowledge/workflow/ NEW_PROJECT/.knowledge/
cp SOURCE/.knowledge/README.md NEW_PROJECT/.knowledge/
cp SOURCE/.knowledge/session-start.md NEW_PROJECT/.knowledge/
```

### **STEP 2: Extract Knowledge Evolution Work**
- [ ] **Review session files** for knowledge system improvements
- [ ] **Extract transferable insights** to workflow/evolution.md
- [ ] **Update session-patterns.md** with new proven approaches
- [ ] **Archive knowledge work** to .archive/knowledge-evolution-YYYY-MM-DD.md

### **STEP 3: Reset Project-Specific Content**
- [ ] **Clear content from session files** (keep structure/format)
- [ ] **session/context.md**: Remove old problem, keep template structure
- [ ] **session/progress.md**: Remove old progress, keep tracking format
- [ ] **session/next-steps.md**: Remove old steps, keep action format
- [ ] **session-handoff.md**: Clear old context, keep handoff structure

### **STEP 4: Initialize New Project**
- [ ] **Follow `workflow/session-setup.md`** for complete initialization
- [ ] **Create new `.project/` directory** for project-specific knowledge
- [ ] **Initialize session files** with new project's first problem

## 🎯 New Project Directory Structure

### **After Transfer + Setup**:
```
NEW_PROJECT/.knowledge/
├── session/                  # Active work (new project content)
│   ├── context.md           # New project's current problem
│   ├── approach.md          # How solving current problem  
│   ├── progress.md          # New project's progress
│   └── next-steps.md        # New project's action items
├── .project/                # New project specifics
│   ├── project-context.md   # New tech stack/setup
│   └── architecture.md      # New system design
├── workflow/                # Transferred knowledge system
│   └── *.md                # All workflow files
├── .archive/                # Empty (will grow with new project)
├── README.md               # System overview
└── session-start.md        # Onboarding checklist
```

## ✅ Validation Checklist

### **Transfer Successful When**:
- [ ] **No old project content** in session files
- [ ] **New project problem** clearly defined in session/context.md
- [ ] **Fresh .project/ directory** with new project specifics
- [ ] **All workflow files** present and functional
- [ ] **Can start productive work** immediately
- [ ] **30-second context rebuild** works for new project

### **Common Transfer Mistakes**:
- ❌ Copying .project/ or .archive/ (brings old project knowledge)
- ❌ Not clearing session file content (brings old problems)
- ❌ Not running session-setup.md (incomplete initialization)
- ❌ Missing workflow files (broken knowledge system)

## 🔄 Maintenance After Transfer

### **Regular Updates** (in source project):
- Keep `workflow/` files current with improvements
- Update `session-patterns.md` with new proven approaches
- Refine `session-setup.md` based on transfer experience

### **Knowledge Evolution** (in new project):
- Adapt patterns to new domain/technology
- Capture new domain-specific patterns in `.project/`
- Feed improvements back to source project workflow/ files

---
*Transfer knowledge system, not project content*
