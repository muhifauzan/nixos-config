# Session Patterns Library

## 🎯 Reusable Problem-Solving Approaches

### When to Use This
- Starting new development work
- Need proven approach for common problem types
- Want to avoid reinventing workflow patterns
- Looking for checklist templates

## 📋 Core Workflow Patterns

### **Pattern 1: Granular Step Approach**
**Use when**: Complex, multi-step problems that might get interrupted

**Structure**:
- Break work into <5 minute steps
- Mark each step ✅ immediately when complete
- Enable state comparison recovery (compare planned vs actual state)
- Track progress granularly in `session/progress.md`

**Example**: Our knowledge system restructure (Steps 1-11)

**Benefits**: Interruption-resistant, self-correcting, clear resumption

### **Pattern 5: Sequential Thinking Approach**
**Use when**: Complex problems requiring structured analysis

**Structure**:
1. **Problem decomposition** using sequential thinking tool
2. **Adaptive planning** with thought revision and branching
3. **Solution hypothesis generation** through structured reasoning
4. **Implementation planning** breaking thoughts into actionable steps
5. **Validation and iteration** based on results

**Example**: Complex system debugging, architecture decisions, workflow optimization

**Benefits**: Systematic thinking, adaptive planning, clear reasoning trail

---

### **Pattern 6: Time-Tracked Sessions**
**Use when**: Need productivity insights and session optimization

**Structure**:
1. **Session start timestamp** using time tool
2. **Regular progress checkpoints** with time tracking
3. **Context switch timing** to identify efficiency patterns
4. **Session end analysis** with duration and accomplishment correlation
5. **Pattern recognition** across multiple timed sessions

**Example**: Productivity optimization, team collaboration, workflow tuning

**Benefits**: Data-driven insights, productivity patterns, session optimization

---

### **Pattern 2: Debug-First Approach**  
**Use when**: System not working, unclear error messages

**Structure**:
1. **Gather actual error output** (not just "it doesn't work")
2. **Debug with specific tools** (debug scripts, detailed logs)
3. **Identify root cause** before attempting fixes
4. **Fix systematically** with verification at each step
5. **Test thoroughly** to confirm resolution

**Example**: Flake evaluation failures, LSP issues

**Benefits**: Avoids guess-and-check, systematic problem solving

---

### **Pattern 3: Architecture-First Approach**
**Use when**: Building new features or significant changes

**Structure**:
1. **Research existing patterns** in codebase and community
2. **Design architecture** before implementation
3. **Create extension points** for future flexibility  
4. **Implement incrementally** with testing at each step
5. **Document patterns** for future use

**Example**: Monitor API extension registry pattern

**Benefits**: Extensible, maintainable, follows established patterns

---

### **Pattern 4: Knowledge Evolution Approach**
**Use when**: Workflow inefficiencies or repeated problems

**Structure**:
1. **Identify pain points** during work (capture in real-time)
2. **Analyze patterns** across multiple chats/sessions
3. **Design systematic improvements** to knowledge/workflow
4. **Implement and test** improvements
5. **Integrate feedback** and iterate

**Example**: Our current knowledge system optimization

**Benefits**: Self-improving, systematic, feedback-driven

---

## 🎨 Problem Type → Pattern Mapping

### **Technical Implementation**
- **Unknown errors**: Debug-First Approach
- **New features**: Architecture-First Approach  
- **Complex changes**: Granular Step Approach
- **System integration**: Architecture-First + Debug-First

### **Workflow Problems**
- **Inefficiencies**: Knowledge Evolution Approach
- **Repeated issues**: Knowledge Evolution Approach
- **Context loss**: Granular Step Approach
- **Knowledge gaps**: Knowledge Evolution Approach

### **Learning/Research**
- **New technology**: Architecture-First (research phase)
- **Best practices**: Architecture-First (pattern research)
- **Debugging techniques**: Debug-First + Knowledge Evolution

## 🔧 Pattern Selection Guide

### **Quick Decision Tree**:
1. **Is it broken/erroring?** → Debug-First Approach
2. **Is it new/complex?** → Architecture-First or Granular Steps
3. **Is it a workflow problem?** → Knowledge Evolution Approach
4. **Is it multi-step and interruptible?** → Granular Step Approach

### **Pattern Combinations**:
- **Complex new feature**: Architecture-First + Granular Steps
- **Debugging workflow issues**: Debug-First + Knowledge Evolution
- **Large system changes**: All patterns as needed

## 📚 Pattern Templates

### **Granular Steps Template**:
```markdown
## Current Work: [Problem Description]

### Granular Action Items
- [ ] **STEP 1**: [<5 min task]
- [ ] **STEP 2**: [<5 min task]  
- [ ] **STEP 3**: [<5 min task]

### Abrupt Stop Detection
Each step small enough to complete quickly
If interrupted: Compare planned vs actual state
Recovery: Check last modified files vs step list
```

### **Debug-First Template**:
```markdown
## Debug Strategy: [System/Issue]

### Information Gathering
- [ ] Get actual error output (not summaries)
- [ ] Use debug tools: [specific tools]
- [ ] Document symptoms vs assumptions

### Root Cause Analysis  
- [ ] Analyze error patterns
- [ ] Check recent changes
- [ ] Verify assumptions

### Systematic Resolution
- [ ] Fix root cause (not symptoms)
- [ ] Test fix in isolation
- [ ] Verify broader system works
```

---
*Choose patterns based on problem type and combine as needed*
