# Feedback Integration - MANDATORY PROCESSING

## 🚨 NO FEEDBACK GETS IGNORED - EVER

**Reality**: Claude tends to create feedback files and then forget about them
**Solution**: Mandatory processing system with accountability

### 📋 MANDATORY FEEDBACK PROCESSING
**For EVERY feedback item - no exceptions:**

1. **IMMEDIATE CAPTURE** 📝
   - [ ] Create feedback file: `workflow/session-feedback-YYYY-MM-DD.md`
   - [ ] **FORCE VISIBILITY**: Add to session/next-steps.md: `- [ ] FEEDBACK: Process X (see workflow/session-feedback-...)`
   - [ ] **NO SKIPPING**: Mark as highest priority in progress.md

2. **FORCED ANALYSIS** 🔍 (No hand-waving)
   - [ ] **Impact**: High/Medium/Low (be specific, not vague)
   - [ ] **Evidence**: What exactly proves this is a problem?
   - [ ] **Cost**: How much effort to fix? (Force realistic estimates)
   - [ ] **Urgency**: Block work now vs improve later vs can ignore

3. **HONEST DECISION** ✅ (No wishy-washy maybe-later)
   - [ ] **IMPLEMENT NOW**: Add specific action items with deadlines
   - [ ] **SCHEDULE**: Move to workflow/evolution.md with specific timeline  
   - [ ] **REJECT**: Document why with clear reasoning (valid choice!)

4. **MANDATORY IMPLEMENTATION** 🔧
   - [ ] **Actually make changes** (not just plan to make changes)
   - [ ] **Test changes work** (don't assume they're better)
   - [ ] **Update cross-references** (fix what you break)
   - [ ] **Document results** (what actually happened vs what you expected)

5. **ARCHIVE COMPLETION** 📁
   - [ ] **Mark feedback item COMPLETE** in feedback file
   - [ ] **Move to .archive/** with clear outcome documentation
   - [ ] **Remove from next-steps.md** (clean up your mess)
   - [ ] **Update evolution.md** if system-wide improvement

### 🚨 ACCOUNTABILITY ENFORCEMENT

**Every session start - MANDATORY CHECK:**
- [ ] Any `workflow/session-feedback-*.md` files? **STOP EVERYTHING** and process them first
- [ ] Any feedback items in next-steps.md older than 1 session? **RED FLAG** - why ignored?
- [ ] Any feedback in evolution.md without timeline? **BROKEN PROCESS** - fix immediately

**Feedback processing time limits:**
- **Simple fixes**: Same session, no excuses
- **Medium changes**: Next session, with progress update  
- **Complex restructures**: 3 sessions max with milestones
- **Rejections**: Document immediately with honest reasoning

### 🎯 FAILURE MODE PREVENTION

**Common Claude feedback failures:**
- ❌ "I'll process this later" (creates feedback debt)
- ❌ "This is low priority" (without proper analysis)
- ❌ "The system works fine" (ignoring improvement opportunities)
- ❌ "It's too complex to fix now" (without breaking it down)

**Required anti-patterns:**
- ✅ **Process immediately** or schedule with specific timeline
- ✅ **Be honest about impact** - some feedback is low value, that's OK
- ✅ **Admit system problems** - they exist, denying helps no one
- ✅ **Break down complex changes** into manageable pieces

### 📊 FEEDBACK METRICS (Track honestly)

**In workflow/metrics.md - update every session:**
- **Feedback backlog**: How many unprocessed items? (Target: 0)
- **Processing time**: Average time from creation to resolution
- **Implementation rate**: % of feedback that leads to actual changes
- **Impact accuracy**: Were predicted impacts correct?

### 🔄 SYSTEM EVOLUTION THROUGH FEEDBACK

**The goal**: Make feedback processing so systematic that even an amnesiac Claude will:
- ✅ **Never lose feedback** - forced visibility prevents forgetting
- ✅ **Process honestly** - mandatory analysis prevents hand-waving
- ✅ **Follow through** - time limits and tracking prevent abandonment
- ✅ **Learn patterns** - metrics reveal what feedback types matter most

---
**Remember: Ignoring feedback breaks the evolution cycle**
**Remember: "I'll do it later" means "I'll forget about it"**
**Remember: Honest rejection is better than dishonest deferral**
