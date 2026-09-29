# Project Context

[← Back to README](../README.md)

## Summary

| Item | Value | Status |
|---|---|---|
| Author | Baruch Lopez | Confirmed (`LICENSE`, git history) |
| Date | February 20, 2021 (initial commit and upload) | Confirmed (git history) |
| Language | MATLAB | Confirmed (`.m` syntax, `vpa`, `integral`) |
| Natural language of the code | Spanish | Confirmed (comments and identifiers) |
| Project type | Coursework / Assignment | **Inferred** |
| Institution / course / assignment | — | **Unknown** |

## Sources Available

The original repository has only three files:

| File | Kind | Role |
|---|---|---|
| `Diferenciacion.m` | Source code | Numerical differentiation experiment |
| `Integracion.m` | Source code | Numerical integration experiment |
| `LICENSE` | Legal | MIT License, © 2021 Baruch Lopez |

The repository has **no** PDFs, Word documents, slides, images, datasets, notebooks, or saved outputs. Everything below comes from the code, its comments, and the git metadata.

## Evidence for the Inferred Origin

These points suggest that the scripts were written for a numerical methods course. None of them confirms it.

1. **Topic selection.** The scripts cover forward, central, and second-order finite differences, followed by left, right, and midpoint rectangles, trapezoid, Simpson 1/3, Simpson 3/8, and 2- and 3-point Gauss–Legendre quadrature. That list matches the syllabus of a typical undergraduate *Numerical Methods* unit.
2. **Comparison-oriented output.** Each script tabulates approximations next to their absolute errors instead of solving an applied problem. This is the usual shape of a lab exercise.
3. **Personalization parameter.** Both scripts start with `d=572;`, and every function coefficient depends on it (`x = d/333`, `d*x.^2.*exp(-x) + 1/d`). Instructors often give each student a number, for example digits of their student ID, so that every student gets different results. This is an inference.
4. **Tuned constants.** `N = 594` is divisible by both 2 and 3, which Simpson 1/3 and Simpson 3/8 require. It looks deliberately chosen, possibly to satisfy an assignment requirement.
5. **Historical residue.** The commented line `%vpa([h' dfa' dfa2' dfa3'])` in `Diferenciacion.m` uses variable names that no longer exist. This suggests the script grew out of an earlier template or class example.

## Scope

- Two independent scripts. They share no code and no data, and neither calls the other.
- Fixed parameters, with no user input.
- Output goes only to the MATLAB Command Window.

## Open Questions (Unknown)

- The institution, course name, and assignment statement.
- Where the quadratic polynomial in `Diferenciacion.m` comes from. Its coefficients (`0.005043774869925`, `-0.108438359449052`, `0.584546100474274`) look like a fitted polynomial, possibly from an earlier interpolation or regression exercise, but the repository does not say.
- Why the "exact" derivative in `Diferenciacion.m` is the derivative of `x²·e^(−x)` rather than of the quadratic being differentiated. See [code-overview.md](code-overview.md#note-on-the-reference-derivative). It may have been left over from an earlier version of the exercise, but the repository does not say.
- Which MATLAB release was used.
