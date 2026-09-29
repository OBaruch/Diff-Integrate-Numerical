# Intent

[← Back to README](../../README.md) · **Intent** · [Spec](spec.md) · [Plan](plan.md)

## Why

`Diff-Integrate-Numerical` was uploaded in February 2021 as two loose MATLAB scripts and a license. It had no README and no explanation of what the scripts compute or why. As a portfolio piece, it could not be understood without reading Spanish-commented MATLAB line by line.

## Desired Outcome

A reader, human or automated, should be able to understand within a few minutes:

- what the project does (it compares numerical differentiation and integration methods and their errors);
- where it most likely came from (numerical methods coursework, inferred);
- how the code works and what it prints;
- what is known, what is inferred, and what is unknown.

## Guiding Principle

> **Modernize the repository, not the project.**

The original implementation is historical evidence. It is preserved exactly, including its known issues, while the organization and documentation around it are brought up to current standards.

## Non-Goals

- Fixing, optimizing, reformatting, or translating the MATLAB code.
- Adding CI, tests, containers, package managers, or other tooling.
- Presenting the project as more recent or more sophisticated than it is.

## Stakeholder

Baruch Lopez, the original author and repository owner.
