# 🚀 Claude Session Start - MANDATORY PROCEDURES

## ⚠️ READ THIS: You are amnesiac and optimistic by default
- **You don't remember previous sessions** - act accordingly
- **You tend to be overconfident** - be skeptical of your abilities  
- **You may hide problems** - the system only works with brutal honesty
- **Follow ALL steps** - no shortcuts, no "I'll do it later"

## 📁 CRITICAL: Understand the Folder Structure
**You MUST understand this to avoid path confusion:**

```
<PROJECT_ROOT>/                                      ← YOU START HERE (NixOS flake project)
├── .knowledge/                                      ← KNOWLEDGE SYSTEM FOLDER
│   ├── .archive/                                   ← Historical files (check size!)
│   ├── session/                                    ← Current session context
│   │   ├── current.md                             ← Narrative overview (quick scan)
│   │   ├── completed.md                           ← Detailed checklists
│   │   └── next.md                                ← Specific action items
│   ├── .project/                                   ← Project-specific knowledge
│   ├── workflow/                                   ← Pending feedback files
│   ├── session-start.md                           ← THIS FILE
│   └── session-handoff.md                         ← Handoff instructions
├── flake.nix                                       ← Main project files
├── modules/
└── hosts/
```

**Key Concepts:**
- **You start in**: The project root directory (contains `flake.nix`)
- **Knowledge system**: Everything under `.knowledge/` subdirectory
- **Relative paths**: All commands use paths relative to project root
- **Archive location**: `.knowledge/.archive/` (NOT just `.archive/`)

**To verify you're in the right place:**
- ✅ `ls flake.nix` should show the main flake file
- ✅ `ls .knowledge/session-start.md` should show this file
- ❌ If these fail, you're in the wrong directory

### 🚨 MANDATORY HICCUP REPORTING
**You MUST report immediately:**
- [ ] **Path confusion**: Can't find expected files? Report the exact path you tried
- [ ] **Conflicting references**: Documentation mentions files that don't exist? Report it
- [ ] **Import errors**: Can't access files the system says should exist? Report it
- [ ] **Broken cross-references**: Links to non-existent files? Report it

**Template for reporting**: "HICCUP: Tried to access [exact path], but [what happened]. Expected [what based on docs]."

---

## 📋 MANDATORY PHASE 1: SYSTEM HEALTH (Do NOW)

### ⚠️ REQUIRED CHECKS (Complete ALL before reading session files)

**Step 1: Archive Bloat Check** 
```bash
ls .knowledge/.archive/ | wc -l
```
- **Count**: _____ files
- **Action Required**: If >30 files, STOP and clean up first
- **Path Check**: If command fails, you're probably in wrong directory
- **Honesty Check**: Are you tempted to skip this? That's exactly why it's mandatory.

**Step 2: Maintenance Debt Check**
- [ ] Any `workflow/session-feedback-*.md` files? (pending feedback to process)
- [ ] When was last archive cleanup? Look for recent cleanup files in .archive/
- [ ] Any files >500 lines that need splitting?

**Step 3: Performance Reality Check**
- [ ] **Time this session start**: Record start time (UTC only - timezone data exposes location)
- [ ] **Previous context rebuild time**: How long did it actually take last time?
- [ ] **Honesty**: Will you actually track these metrics or just say you will?

### 🚨 FORCED HONESTY QUESTIONS
**Answer these EVERY session (builds accountability):**

1. **Maintenance Honesty**: "Am I actually following the procedures I documented, or just pretending I will?"
   - Answer: ________________

2. **Problem Hiding**: "What's currently broken/confusing that I might not want to admit?"
   - Answer: ________________  

3. **Overconfidence Check**: "What am I assuming I can do without actually testing?"
   - Answer: ________________

4. **Hiccup Reporting**: "What path confusion, conflicting references, or broken links did I encounter during onboarding?"
   - Answer: ________________ (Use HICCUP template if any found)

## 📋 MANDATORY PHASE 2: SESSION CONTEXT (Read in order)

### Current Work Status (30 seconds max)
- [ ] Read `session/current.md` - Narrative overview of current status
- [ ] Read `session/completed.md` - Detailed achievement tracking  
- [ ] Read `session/next.md` - Specific action items
- [ ] Check `session-handoff.md` - Previous session's real state

### Project Knowledge (if needed)
- `.project/project-context.md` - Technologies and setup
- `.project/architecture.md` - System design
- `.archive/` - Historical context (only if relevant)

## 📋 MANDATORY PHASE 3: SESSION SETUP

### Work Planning
- [ ] **Problem clarity**: Can you explain the current problem in one sentence?
- [ ] **Success criteria**: What does "done" look like for this session?
- [ ] **Time estimate**: How long do you think this will take? (Track accuracy)
- [ ] **Complexity assessment**: Simple/Medium/Complex? (Forces realistic expectations)

### Accountability Setup
- [ ] **Start time recorded**: ____:____ (track actual session length)
- [ ] **Friction logging**: Commit to noting what slows you down
- [ ] **Reality check**: What could go wrong? What might you be missing?

### 🚨 MANDATORY DOCUMENTATION CHECKPOINTS
**These are REQUIREMENTS, not suggestions:**
- [ ] **After any major progress**: IMMEDIATELY update session/completed.md
- [ ] **After solving any problem**: IMMEDIATELY update session/current.md
- [ ] **Before claiming "done"**: MUST update session/next.md
- [ ] **Before any celebration**: MUST update session-handoff.md

**Enforcement**: If you skip documentation, the work doesn't count as complete!

## 🚨 FAILURE MODES TO WATCH FOR

### Classic Claude Amnesia Problems
- ❌ "I'll proactively do maintenance" (you won't remember)
- ❌ "This will only take X minutes" (usually wrong)
- ❌ "I followed all the procedures" (did you really?)
- ❌ "Everything is working fine" (avoiding admitting problems)
- ❌ "I'll update the documentation later" (you won't - do it NOW)
- ❌ "The technical work is done" (not done until documented)

### Required Honesty
- ✅ **Admit confusion** immediately, don't pretend to understand
- ✅ **Report actual time** taken, not estimates
- ✅ **Document friction** in real-time, not at the end
- ✅ **Call out inconsistencies** in the knowledge system
- ✅ **Question assumptions** rather than accepting them

## 📊 END-OF-SESSION REQUIREMENTS

### MANDATORY UPDATES (No exceptions)
- [ ] **session/completed.md**: What actually got done?
- [ ] **session/next.md**: Clear, specific next actions
- [ ] **session/current.md**: Updated narrative overview
- [ ] **session-handoff.md**: Honest assessment for next session
- [ ] **Performance metrics**: Actual time, efficiency, problems encountered
- [ ] **COMPLETION CHECKLIST**: Run `workflow/completion-checklist.md` to verify ALL system consistency

### FORCED REFLECTION
1. **What didn't work?** (Be specific, not vague)
2. **What took longer than expected?** (Reality vs estimates)
3. **What knowledge was missing/wrong?** (System gaps to fix)
4. **What would you tell the next Claude?** (Honest handoff)

### ARCHIVE MAINTENANCE (When triggered)
- **>30 files in .archive/**: Mandatory cleanup before new work
- **Files >500 lines**: Split into focused pieces
- **Broken cross-references**: Fix immediately, don't defer
- **Outdated information**: Remove or update, don't accumulate

## 🎯 SUCCESS = SYSTEM IMPROVES WITHOUT MEMORY

**The goal**: Even an amnesiac Claude following these procedures will:
- ✅ Maintain knowledge system health automatically
- ✅ Report problems honestly and immediately  
- ✅ Track real performance metrics, not aspirational ones
- ✅ Improve the system through systematic evolution
- ✅ Never pretend competence they don't have

---
**Remember: You have no memory. The system must work despite this.**
**Remember: You tend to be optimistic. Force reality checks.**
**Remember: Honesty makes the system better. Hiding problems makes it worse.**
