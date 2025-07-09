# Knowledge Maintenance - AMNESIA-PROOF PROCEDURES

## 🚨 REALITY CHECK FOR CLAUDE
**You don't remember previous sessions. You are optimistic by default. The system must force good behavior.**

### 🤖 MANDATORY MAINTENANCE (Not suggestions - requirements)
**EVERY SESSION START** - No shortcuts allowed:

1. **Archive bloat check** (<2 minutes, no excuses):
   - [ ] Count files: `ls .archive/ | wc -l` 
   - [ ] If >30 files: STOP. Clean up first. Don't defer.
   - [ ] Document what you found: "Archive has X files, cleaned/didn't clean because..."

2. **Performance reality check** (<1 minute):
   - [ ] Previous session metrics: How long did context rebuild ACTUALLY take?
   - [ ] System friction: What slowed you down last time?
   - [ ] Honesty: Are you about to claim "everything works fine" without checking?

3. **Pending work check** (<1 minute):
   - [ ] Any workflow/session-feedback-*.md files to process?
   - [ ] Any broken cross-references you've been ignoring?
   - [ ] Any "TODO" items that keep getting deferred?

**EVERY SESSION END** - Mandatory reality documentation:

4. **Brutal honesty logging** (force transparency):
   - [ ] What actually confused you? (Not "nothing", be specific)
   - [ ] What took longer than estimated? (Track prediction accuracy)
   - [ ] What procedures did you skip? (Admit it, don't hide it)
   - [ ] What knowledge was wrong/missing? (System isn't perfect)
   - [ ] **PRIVACY**: Use UTC time only in all documentation (timezone exposes location)

### 📊 Validate Knowledge Quality
**Do this every 2-3 sessions:**

1. **Check for contradictions**:
   - Compare `active/` vs `core/` on same topics
   - Look for conflicting solutions in archives
   - Note discrepancies between sessions

2. **Test documented solutions**:
   - Try commands/steps from knowledge files
   - Verify examples still work (esp. nix commands)
   - Check if assumptions are still valid

3. **Review recent questions to human**:
   - Are you asking same things repeatedly?
   - Do knowledge files answer questions you asked?
   - Update knowledge if it's missing key info

**Ask human when you find**: Wrong info, outdated solutions, persistent confusion

### 🔄 Update Knowledge
**Every session end:**

1. **Update active files**:
   - `progress.md` - mark completed ✅
   - `next-steps.md` - update action items
   - `session-handoff.md` - current context

2. **Add new knowledge**:
   - Solutions to problems you solved
   - Patterns that worked well
   - Mistakes to avoid

3. **Fix stale info**:
   - Update examples that failed
   - Correct outdated assumptions
   - Remove obsolete workarounds

### 🧹 Cleanup Process
**When files get >300 lines or info feels overwhelming:**

1. **Archive completed work**:
   - Move resolved problems to `.archive/YYYY-MM-DD-topic.md`
   - Keep only essential parts (under 200 lines)
   - Remove redundant information

2. **Consolidate related info**:
   - Merge scattered notes on same topic
   - Create single source of truth
   - Remove duplicate explanations

3. **Delete unused files**:
   - Archives older than 6 months with no references
   - Failed experiments that won't be retried
   - Superseded information
   - Debugging scripts no longer relevant

4. **Archive hygiene**:
   - Keep .archive/ under 30 files total
   - Group related archives when possible
   - Remove .gitkeep files and other cruft
   - Prioritize quality over quantity in history

### 📈 Evaluate Performance
**Track these metrics in `metrics.md`:**

1. **Context rebuild time**: From fresh session to productive work
2. **Knowledge hit rate**: Found info in `.knowledges` vs asked human
3. **Error frequency**: Mistakes per session (should decrease)
4. **Question quality**: Fewer basic questions, more advanced

**Abrupt Stop Detection (No Interruption Method):**
1. **Compare planned vs actual state**: Read next step, check project reality
2. **Examples**: 
   - Plan says "STEP 8" but files not moved → Resume STEP 7
   - Plan complete but workflow broken → Add debugging steps
3. **Benefits**: Self-correcting, no workflow disruption, flexible adaptation
4. **Implementation**: Mark each step ✅ immediately when completed

**Red flags** (ask human for help):
- Context rebuild >2 minutes consistently
- Same errors across multiple sessions
- Knowledge system feels confusing
- Hit rate decreasing over time

### 🚀 Evolve the System
**Monthly or when patterns emerge:**

1. **Optimize based on usage**:
   - Which files do you read most?
   - What info is hard to find?
   - Where do you waste time?

2. **Update templates**:
   - Add new problem patterns
   - Improve existing formats
   - Create shortcuts for common tasks

3. **Refine structure**:
   - Move frequently-used info to `core/`
   - Split overly complex files
   - Add cross-references

**Document changes in `evolution.md`** - what you tried and outcomes

### 🚨 Emergency Cleanup
**When system breaks down:**

1. **Context overload**: Can't find info quickly
   - Archive 50% of current content
   - Focus on essentials only
   - Rebuild gradually

2. **Conflicting information**: Multiple "truths"
   - Ask human to clarify
   - Consolidate into single source
   - Mark confidence levels

3. **Outdated knowledge**: Solutions don't work
   - Test all documented procedures
   - Update or remove broken ones
   - Ask human about current best practices

---
**Remember**: This system serves YOU. If it's not helping, change it.
