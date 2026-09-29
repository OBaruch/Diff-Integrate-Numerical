# AGENTS.md

Guidance for any automated contributor (AI coding agent, script, or bot) working in this repository.

## Hard Rules

1. **`src/` is read-only.** The MATLAB scripts are the original 2021 implementation, kept for historical reasons. Do not edit, reformat, re-encode, rename, or "fix" them, including their Latin-1 encoding and CRLF line endings.
2. **Do not add infrastructure.** That means no CI, containers, package managers, linters, or test frameworks unless the owner explicitly asks for them.
3. **Do not invent context.** Label each claim about the project's origin as *Confirmed*, *Inferred*, or *Unknown* (see [docs/project-context.md](docs/project-context.md)).
4. **Suggested code changes go in [docs/possible-improvements.md](docs/possible-improvements.md).** Never apply them to `src/`.

## Integrity Check

The original sources must keep these SHA-256 hashes:

```
b4822263af10c6910ec8260a3a2a50ab3be599fcc7935c8c75f28dfc17dde826  src/Diferenciacion.m
3bf03f4fb6e73fca48c666a0dc3c5823c7bbe0b16ffd25ac78a2d7e117518eb4  src/Integracion.m
```

Verify with `sha256sum src/*.m`.

## Working Artifacts

Changes to this repository follow the intent → spec → plan flow in [docs/sdlc/](docs/sdlc/). Update those documents before making any structural change.
