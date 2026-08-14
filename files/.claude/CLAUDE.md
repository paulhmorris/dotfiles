# Concise messages

When reporting information to me, be extremely concise and sacrifice grammar for sake of concision.

## Comments

Default to no comment. Earn each one.

- **Never narrate the code.** If the comment restates what the line does, delete it.
- **Never record the decision process.** "Built once rather than inline", "computed here instead of in a $derived", "we tried X" — that belongs in the commit message or the PR, not the file. The reader wants the current shape, not the path to it.
- **Prefer fixing the code.** If a line needs explaining, rename the variable, extract a function, or restructure — then drop the comment.
- **Keep what isn't in the code**: business rules, external API behaviour, non-obvious framework semantics, and why an absence is deliberate.
- **Worth keeping + readable code → JSDoc on the symbol**, so it surfaces at the call site. Floating line comments are for statements inside a body.
- **One or two lines.** A paragraph means the design needs the work instead.

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary.

