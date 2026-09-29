# Possible Improvements

[← Back to README](../README.md)

> **None of these improvements were applied.** They are recorded here only as observations. The code in `src/` is intentionally kept as the original implementation.

## Correctness Observations

1. **Mismatched reference derivative.** In `Diferenciacion.m`, `d1faexacto` is the derivative of `x²·e^(−x)`, not of the quadratic `f`. Because of this, the error columns cannot show convergence. Using `f'(x) = 2·0.005043774869925·x − 0.108438359449052` as the reference would fix it. See [code-overview.md](code-overview.md#note-on-the-reference-derivative).
2. **No reference for the second derivative.** `SegundaDerivada` has no error column, although its exact value (`≈ 0.0100875`) is known in closed form.
3. **"Exact" integral is numerical.** `integral` is adaptive quadrature. The closed form `d·(2 − 122·e^(−10)) + 10/d` would give a truly exact reference.
4. **Gauss–Legendre is not composite.** Both Gauss rules are applied once over `[0, 10]`, so they are not comparable with the composite Newton–Cotes rules. Applying them per subinterval would make the comparison fair.

## Code-Quality Observations

- `sum` is used as a variable name in the Simpson 3/8 block, which shadows the built-in function.
- Some variables are never used: `salida`, and the counters `k` in the Gauss blocks.
- `h` is reassigned several times with different meanings in `Integracion.m`.
- The same `linspace(a,b,N+1)` call is repeated in every block.
- `clear all` also clears breakpoints and loaded functions. `clearvars` does less collateral damage.
- There are typos in comments and output (`CONPMPARDO`, `Intergal`).
- The files are Latin-1 encoded. Modern MATLAB defaults to UTF-8.
- Each method could be a reusable function (`forwardDiff(f,x,h)`, `simpson13(f,a,b,N)`, …), with parameters passed as arguments instead of hard-coded.
- `vpa` is used only for display and pulls in the Symbolic Math Toolbox as a dependency. `fprintf` with `%.15g` would avoid that.
- The results could be plotted as log–log error vs. `h`, which would make the truncation and round-off trade-off visible.
