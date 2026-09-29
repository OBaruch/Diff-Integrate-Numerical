# Numerical Methods

[← Back to README](../README.md)

This document describes the mathematics that the scripts implement. The notation is modern, and the code itself is unchanged.

---

## 1. Numerical Differentiation (`src/Diferenciacion.m`)

**Evaluation point:** `x = d / 333 = 572 / 333 ≈ 1.717717`

**Function:** a quadratic polynomial

```
f(x) = 0.005043774869925·x² − 0.108438359449052·x + 0.584546100474274
```

**Step sizes:** `h = 10^-1, 10^-2, …, 10^-10` (vectorized, so every formula is evaluated for all ten steps at once).

| Method (code variable) | Formula | Truncation error order |
|---|---|---|
| Forward difference (`DiferenciacionPorDefinicion`) | `[f(x+h) − f(x)] / h` | O(h) |
| Central difference (`DiferenciacionCentrada`) | `[f(x+h) − f(x−h)] / (2h)` | O(h²) |
| Second derivative (`SegundaDerivada`) | `[f(x+h) − 2f(x) + f(x−h)] / h²` | O(h²) |

The comments in the code call these "*Método con la definición (de diferencias)*", "*Método con el polinomio de Taylor (diferencias centradas)*" and "*Método de aproximación a la segunda derivada*".

**Expected behavior (theory).** As `h` shrinks, the truncation error falls, but round-off error in `f(x+h) − f(x)` grows roughly like `ε/h` (and like `ε/h²` for the second derivative). The total error therefore reaches a minimum at an intermediate `h` and then rises again. This trade-off is what the `h = 10^-1 … 10^-10` sweep is designed to show.

Because `f` is quadratic, the central formulas have no truncation error at all, so any deviation they show comes from floating-point round-off.

**Error measurement.** The script compares the forward and central results against

```
f'_ref(x) = 2x·e^(−x) − x²·e^(−x)      (derivative of x²·e^(−x))
```

which is **not** the derivative of the quadratic above. The [code overview](code-overview.md#note-on-the-reference-derivative) covers this in detail.

---

## 2. Numerical Integration (`src/Integracion.m`)

**Integral:**

```
I = ∫₀¹⁰ ( d·x²·e^(−x) + 1/d ) dx,   d = 572
```

**Partition:** `N = 594` subintervals, so `h = 10/594 ≈ 0.016835`.

**Reference value:** `intexacta = vpa(integral(f, a, b))`. This is MATLAB's adaptive numerical quadrature, not a symbolic antiderivative. For reference, the closed form is

```
I = d·(2 − 122·e^(−10)) + 10/d ≈ 1140.849293819
```

| Method (code variable) | Formula |
|---|---|
| Left rectangles (`IntegralPorIzq`) | `h · Σ_{i=0}^{N−1} f(x_i)` |
| Right rectangles (`IntegralPorDech`) | `h · Σ_{i=1}^{N} f(x_i)` |
| Midpoint (`IntegralPorCntr`) | `h · Σ_{i=0}^{N−1} f(x_i + h/2)` |
| Trapezoid (`IntegralPorTrap`) | `h · [ f(x_0)/2 + Σ_{i=1}^{N−1} f(x_i) + f(x_N)/2 ]` |
| Simpson 1/3 (`IntegralPorSIM13`) | `(h/3) · [ f(a) + 4Σ_odd f(x_i) + 2Σ_even f(x_i) + f(b) ]`, with N even |
| Simpson 3/8 (`IntegralPorSIM38`) | `(3h/8) · [ f(a) + 3Σ f(x_i), i mod 3 ≠ 0 + 2Σ f(x_i), i mod 3 = 0 + f(b) ]`, with N divisible by 3 |
| Gauss–Legendre, 2 points (`CuadraturaGauss2P`) | `(b−a)/2 · [ f(t₁) + f(t₂) ]`, nodes `±1/√3` mapped to `[a, b]` |
| Gauss–Legendre, 3 points (`CuadraturaGauss3P`) | `(b−a)/2 · [ 5/9·f(t₁) + 8/9·f(t₂) + 5/9·f(t₃) ]`, nodes `0, ±√(3/5)` |

The Gauss–Legendre rules are applied **once to the whole interval `[0, 10]`**, not as composite rules over the `N` subintervals. With only 2 or 3 function evaluations over a wide interval, their errors are expected to be much larger than those of the composite Newton–Cotes rules, which use about 600 evaluations. The results confirm this.

### Independent Reference Check

The values below were computed separately (in double precision, outside MATLAB) by re-implementing each formula. They are **not** original outputs of the project, which kept none. They are included only to show the expected order of magnitude of each error.

| Method | Approximation | Absolute error |
|---|---|---|
| Left rectangles | 1140.82739 | ≈ 2.2 × 10⁻² |
| Right rectangles | 1140.87110 | ≈ 2.2 × 10⁻² |
| Midpoint | 1140.84932 | ≈ 2.5 × 10⁻⁵ |
| Trapezoid | 1140.84924 | ≈ 4.9 × 10⁻⁵ |
| Simpson 1/3 | 1140.84930 | ≈ 1.5 × 10⁻⁶ |
| Simpson 3/8 | 1140.84930 | ≈ 3.4 × 10⁻⁶ |
| Gauss 2-pt (single interval) | 1610.30897 | ≈ 4.7 × 10² |
| Gauss 3-pt (single interval) | 1099.65850 | ≈ 4.1 × 10¹ |

The ranking follows theory. The rectangle rules are O(h). The midpoint and trapezoid rules are O(h²), with the midpoint error about half the trapezoid error. The Simpson rules are O(h⁴). Single-interval Gauss quadrature is very inaccurate on this peaked integrand.
