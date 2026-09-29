# Code Overview

[← Back to README](../README.md)

This walkthrough documents the original scripts **as they are**. The code was not changed. Line numbers refer to the files in `src/`.

## File Facts

| File | Lines | Encoding | Line endings |
|---|---|---|---|
| `src/Diferenciacion.m` | 34 | ISO-8859-1 (Latin-1) | CRLF |
| `src/Integracion.m` | 110 | ISO-8859-1 (Latin-1) | CRLF |

Accented characters in the comments (for example `Método`, `Número`) are stored in Latin-1. An editor set to UTF-8 displays them as replacement characters, but the original bytes are intact.

Both scripts are **standalone**. They define no functions, read no files, and do not call each other.

---

## `src/Diferenciacion.m`

| Lines | Purpose |
|---|---|
| 1–3 | `clear all; clc; format long`: clears the workspace and the console, then switches to long display format. |
| 4 | `d=572;`: personalization parameter (see [project-context.md](project-context.md)). |
| 6 | `h=10.^(-(1:10));`: row vector of the ten step sizes. |
| 7 | `x=d/333;`: evaluation point, about 1.7177. |
| 8 | `f=@(x)(...)`: the quadratic polynomial being differentiated. |
| 13 | `DiferenciacionPorDefinicion`: forward difference, vectorized over `h`. |
| 16 | `DiferenciacionCentrada`: central difference. |
| 19 | `SegundaDerivada`: second-order central difference. |
| 20 | Commented-out `vpa([h' dfa' dfa2' dfa3'])`, left over from earlier variable names. |
| 23 | `d1faexacto`: the "exact" first derivative used as the reference. |
| 25, 27 | `errorEnDiferencias`, `errorEnCentrada`: absolute errors of the two first-derivative approximations. |
| 31–32 | `TITULO`: builds and displays a text header row. |
| 33–34 | `y=(vpa([...]))`: assembles a 10 × 6 table (columns: `h`, forward, central, second derivative, forward error, central error) and displays it with variable precision. |

### Note on the Reference Derivative

`d1faexacto(x) = 2x·e^(−x) − x²·e^(−x)` is the derivative of `x²·e^(−x)`, the same shape as the integrand in `Integracion.m`. It is not the derivative of the quadratic `f` defined on line 8.

| Quantity at x ≈ 1.717717 | Value |
|---|---|
| True derivative of the quadratic `f` | ≈ −0.091111 |
| `d1faexacto(x)` used by the script | ≈ +0.087024 |

The printed `errorEnDiferencias` and `errorEnCentrada` columns therefore level off at about 0.178, which is the gap between these two values, and do not converge to zero. The code is kept as written. The repository gives no reason for the mismatch. The quadratic may have been fitted to `x²·e^(−x)`-type data in an earlier exercise, but that cannot be confirmed.

The second derivative column (`SegundaDerivada`) has no error column. For the quadratic, its exact value is the constant `2 × 0.005043774869925 ≈ 0.0100875`.

---

## `src/Integracion.m`

| Lines | Purpose |
|---|---|
| 1–5 | `clear all`, `format long`, `d=572`, and `salida=[]` (declared but never used). `clc` is commented out. |
| 7 | `f=@(x)(d*x.^2.*exp(-x)+(1/d))`: the integrand. |
| 8–11 | Interval `a=0`, `b=10`, `N=594` subintervals, and `h=(b-a)/N`. |
| 12 | `intexacta=vpa(integral(f,a,b))`: the reference value from MATLAB's adaptive quadrature. |
| 14–22 | **Gauss–Legendre, 2 points** on the whole interval → `CuadraturaGauss2P`, `error7`. The counter `k` is declared but not used. |
| 24–33 | **Gauss–Legendre, 3 points** on the whole interval → `CuadraturaGauss3P`, `error8`. |
| 38 | Resets `h=(b-a)/N`, because the Gauss blocks overwrote `h`. |
| 40–45 | **Left rectangles** ("Puntos internos") → `IntegralPorIzq`, `error1`. |
| 47–52 | **Right rectangles** ("Puntos externos") → `IntegralPorDech`, `error2`. |
| 55–60 | **Midpoint** ("Puntos medios") → `IntegralPorCntr`, `error3`. |
| 63–67 | **Trapezoid** ("Trapecios") → `IntegralPorTrap`, `error4`. `y` is already the full weighted sum, and `sum(y*h)` multiplies it by `h`. |
| 70–80 | **Simpson 1/3**: loops over odd (`sumai`) and even (`sumap`) interior indices, then `IntegralPorSIM13`, `error5`. |
| 83–100 | **Simpson 3/8**: builds nodes in `x`, then accumulates weights 3, 3, 2 in three strided loops → `IntegralPorSIM38`, `error6`. Here a local variable named `sum` shadows MATLAB's built-in `sum` from this point on. |
| 106 | `Resultados`: an 8 × 2 matrix of `[approximation, error]` in the order left, right, midpoint, trapezoid, Simpson 1/3, Simpson 3/8, Gauss 2-pt, Gauss 3-pt. |
| 108–110 | Prints `h`, the reference integral (label spelled `Intergal exacta`), and `Resultados`. |

### Execution Flow

```
set parameters ─► reference integral (integral + vpa)
               ─► Gauss 2-pt ─► Gauss 3-pt
               ─► reset h ─► left ─► right ─► midpoint ─► trapezoid
               ─► Simpson 1/3 ─► Simpson 3/8
               ─► assemble Resultados ─► print
```

The order of the blocks matters. Simpson 3/8 is last because it rebinds `sum`, so any later use of `sum(...)` in the same script would fail.
