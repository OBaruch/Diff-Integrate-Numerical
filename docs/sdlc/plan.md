# Plan

[← Back to README](../../README.md) · [Intent](intent.md) · [Spec](spec.md) · **Plan**

## Steps

| # | Step | Satisfies | Status |
|---|---|---|---|
| 1 | Inventory every file, and record the encoding, line endings, and SHA-256 of each source file. | R-1, R-2 | Done |
| 2 | Recover context from the code, comments, license, and git history. There are no PDF, Word, or image sources. | R-5 | Done |
| 3 | Independently re-derive the expected numerical results to understand behavior and spot inconsistencies, without changing code. | R-6 | Done |
| 4 | Move `*.m` to `src/` with `git mv`, which keeps the history and the content. | R-1, R-3 | Done |
| 5 | Add `.gitattributes` (`*.m -text`) and a minimal MATLAB `.gitignore`. | R-2, R-9 | Done |
| 6 | Write `README.md`. | R-4 | Done |
| 7 | Write `docs/project-context.md`, `numerical-methods.md`, and `code-overview.md`. | R-5, R-6 | Done |
| 8 | Write `docs/possible-improvements.md`, marked as not applied. | R-7 | Done |
| 9 | Write `AGENTS.md` with the read-only rule and hash check. | R-8 | Done |
| 10 | Verify the hashes again, check the relative links, and open a pull request from a dedicated branch. | R-1, R-10 | Done |

## Verification

```bash
sha256sum src/*.m          # must match AGENTS.md
git ls-files --eol src/    # must report i/crlf
git diff --stat main -- '*.m'   # renames only, 0 insertions / 0 deletions
```

## Decisions

- **No `data/`, `assets/`, `examples/`, or `archive/` folders.** The repository has no material for them, so creating them would add empty structure.
- **No `architecture.md`.** Two independent top-level scripts do not have an architecture worth describing, so the flow is covered in `code-overview.md`.
- **No `assignment.md`.** No assignment statement exists in the repository, and writing one would mean inventing it.
- **File names kept in Spanish** (`Diferenciacion.m`, `Integracion.m`). In MATLAB, a script's file name is how it is invoked, so renaming would change the original project.
- **The reference-derivative mismatch is documented, not fixed.** It is part of the historical record.
