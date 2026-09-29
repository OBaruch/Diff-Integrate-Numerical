# Specification

[← Back to README](../../README.md) · [Intent](intent.md) · **Spec** · [Plan](plan.md)

This spec describes the target state of the repository, derived from what already exists.

## Baseline (As Found, 2021)

```
.
├── Diferenciacion.m   # MATLAB, Latin-1, CRLF, 34 lines
├── Integracion.m      # MATLAB, Latin-1, CRLF, 110 lines
└── LICENSE            # MIT, © 2021 Baruch Lopez
```

No documents, data, images, or outputs.

## Functional Behavior of the Preserved Code (Reference Only)

| ID | Behavior | Source |
|---|---|---|
| F-1 | Computes the forward, central, and second-order differences of a quadratic at `x = 572/333` for `h = 10^-1…10^-10` and prints a 10 × 6 table. | `src/Diferenciacion.m` |
| F-2 | Reports absolute errors of the first-derivative approximations against `d1faexacto`. | `src/Diferenciacion.m` |
| F-3 | Approximates `∫₀¹⁰ (572·x²·e^(−x) + 1/572) dx` with 8 rules (N = 594) and prints an 8 × 2 table of `[value, error]`. | `src/Integracion.m` |
| F-4 | Uses `vpa(integral(f,0,10))` as the reference value. | `src/Integracion.m` |

This behavior is documented, not changed.

## Requirements for the Reorganized Repository

| ID | Requirement | Acceptance criterion |
|---|---|---|
| R-1 | Original source preserved | `sha256sum src/*.m` matches the hashes in [AGENTS.md](../../AGENTS.md). |
| R-2 | Encoding and line endings preserved | `.gitattributes` marks `*.m` as `-text`, and `git ls-files --eol src/` shows `crlf`. |
| R-3 | Clear structure | Code in `src/`, documentation in `docs/`, and no empty or speculative folders (no `data/`, `assets/`, or `archive/`, because no such material exists). |
| R-4 | Professional README | Covers the overview, context, problem, objective, structure, original implementation note, technologies, how it works, I/O, running, documentation links, and a historical note. |
| R-5 | Evidence-based context | Origin labeled *Coursework / Assignment (inferred)*, and every claim tagged Confirmed, Inferred, or Unknown. |
| R-6 | Technical documentation | `docs/numerical-methods.md`, `docs/code-overview.md`, and `docs/project-context.md` exist. There is no `architecture.md`, because the project is too small to have an architecture. |
| R-7 | Improvements kept separate | `docs/possible-improvements.md` states explicitly that nothing was applied. |
| R-8 | Guardrails for automated agents | `AGENTS.md` makes `src/` read-only and gives the integrity check. |
| R-9 | No added infrastructure | No CI, Docker, Makefile, linters, or package manifests. |
| R-10 | Authorship | All commits are authored by Baruch Lopez. |
| R-11 | Language | All new documentation is in English. The original Spanish code is untouched. |

## Target Layout

```
.
├── README.md
├── AGENTS.md
├── LICENSE
├── .gitignore
├── .gitattributes
├── src/
│   ├── Diferenciacion.m
│   └── Integracion.m
└── docs/
    ├── project-context.md
    ├── numerical-methods.md
    ├── code-overview.md
    ├── possible-improvements.md
    └── sdlc/
        ├── intent.md
        ├── spec.md
        └── plan.md
```
