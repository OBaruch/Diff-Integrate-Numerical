# Diff-Integrate-Numerical

Two MATLAB scripts that compare classic **numerical differentiation** and **numerical integration** methods against a reference value, printing the approximations next to their absolute errors.

> **Original implementation.** This repository keeps the project's original implementation. The source code has deliberately not been refactored or modernized, so the historical context and the original development approach are still visible.

## Project Overview

| Script | What it does |
|---|---|
| [`src/Diferenciacion.m`](src/Diferenciacion.m) | Approximates the first derivative (forward and central differences) and the second derivative (central second difference) of a function at one point, for step sizes `h = 10^-1 … 10^-10`, and reports the error of each first-derivative approximation. |
| [`src/Integracion.m`](src/Integracion.m) | Approximates a definite integral on `[0, 10]` with eight rules (left, right and midpoint rectangles, trapezoid, Simpson 1/3, Simpson 3/8, and 2-point and 3-point Gauss–Legendre) and reports each rule's absolute error against MATLAB's `integral`. |

## Project Context

**Project origin: Coursework / Assignment (inferred, not confirmed).**

- **Confirmed:** Baruch Lopez wrote the code (git history and `LICENSE`, 2021). It is in MATLAB, and its comments and identifiers are in Spanish.
- **Inferred:** The topics covered (finite differences, Newton–Cotes rules, Gaussian quadrature, error vs. step size) match a standard *Numerical Methods* course. The fixed parameter `d = 572` appears in both scripts and looks like a per-student value used to personalize an exercise.
- **Unknown:** The institution, course, and assignment statement. The repository has no PDF, Word, or other documents to confirm them.

See [docs/project-context.md](docs/project-context.md) for the evidence behind each point.

## Problem Statement

Show experimentally how accurate common numerical differentiation and integration formulas are. The scripts compute each approximation for a given function and parameter set, then measure how far it lands from a reference value.

## Objective

- Show how finite-difference errors change as the step size `h` shrinks (truncation error vs. round-off error).
- Compare the accuracy of the Newton–Cotes rules with Gauss–Legendre quadrature on the same integral.

## Repository Structure

```
.
├── README.md                  # This file
├── AGENTS.md                  # Guardrails for automated contributors (source is read-only)
├── LICENSE                    # MIT, © 2021 Baruch Lopez (original)
├── src/                       # Original MATLAB scripts (unchanged)
│   ├── Diferenciacion.m
│   └── Integracion.m
└── docs/
    ├── project-context.md     # Origin, evidence, confirmed / inferred / unknown
    ├── numerical-methods.md   # Math behind every formula used
    ├── code-overview.md       # Walkthrough of each script, variable by variable
    ├── possible-improvements.md  # Observations only, NOT applied
    └── sdlc/
        ├── intent.md          # Why this repository was reorganized
        ├── spec.md            # What the reorganized repository must satisfy
        └── plan.md            # How the reorganization was carried out
```

## Original Implementation

The files in `src/` are byte-for-byte identical to the files first uploaded in February 2021. The only change is their location, which moved from the repository root to `src/`. That includes the original ISO-8859-1 (Latin-1) encoding, the CRLF line endings, the Spanish comments, the typos, and the known issues. [`.gitattributes`](.gitattributes) keeps Git from normalizing them.

The source code is the original implementation, most likely written as part of university coursework (see *Project Context*).

## Technologies

- **MATLAB** (language, `.m` scripts)
- **Symbolic Math Toolbox**: required by `vpa(...)`, which both scripts use to show results at extended precision
- Built-in MATLAB functions: `integral`, `linspace`, `feval`, anonymous functions

No MATLAB version is recorded in the repository.

## How It Works

1. Each script is a self-contained, top-level script. It has no functions, no inputs, and no files, and it starts with `clear all`.
2. The function under study is defined as an anonymous function whose coefficients depend on `d = 572`.
3. Each method is applied in sequence, and its result and absolute error are stored in separate variables.
4. The results are printed to the Command Window:
   - `Diferenciacion.m` prints a header row (`TITULO`) and then a 10 × 6 matrix `y`: `h`, forward difference, central difference, second derivative, forward error, central error.
   - `Integracion.m` prints `h`, the reference integral, and an 8 × 2 matrix `Resultados` (approximation, error) in this order: left, right, midpoint, trapezoid, Simpson 1/3, Simpson 3/8, Gauss 2-pt, Gauss 3-pt.

[docs/numerical-methods.md](docs/numerical-methods.md) covers the formulas, and [docs/code-overview.md](docs/code-overview.md) walks through the code line by line.

## Inputs and Outputs

- **Inputs:** none at runtime. All parameters are hard-coded (`d = 572`, the interval `[0, 10]`, `N = 594`, and the step sizes `10^-1 … 10^-10`).
- **Outputs:** Command Window only. The scripts write no files, and the repository keeps no historical outputs.

## Running the Project

With MATLAB and the Symbolic Math Toolbox installed:

```matlab
cd src
Diferenciacion   % differentiation table
Integracion      % integration table
```

These commands follow directly from the scripts, but the repository does not record which MATLAB release was used originally. GNU Octave may also work with its `symbolic` package, but that has not been verified.

## Documentation

- [Project context](docs/project-context.md)
- [Numerical methods](docs/numerical-methods.md)
- [Code overview](docs/code-overview.md)
- [Possible improvements (not applied)](docs/possible-improvements.md)
- SDLC artifacts: [intent](docs/sdlc/intent.md) · [spec](docs/sdlc/spec.md) · [plan](docs/sdlc/plan.md)

## Historical Note

This repository was reorganized and documented at a later date to make it easier to read and to preserve the context of the original project. The original source code is unchanged.

## License

[MIT](LICENSE) © 2021 Baruch Lopez
