# OSS QA Case Study: Bandit #1432

Independent reproduction of an open CLI argument-handling issue in PyCQA Bandit.

## Issue

PyCQA/bandit #1432

## Environment

- Linux Mint / Ubuntu 24.04 base
- Python 3.12.3
- Bandit 1.9.4

## Objective

Compare normal severity/confidence arguments with repeated variants and observe whether Bandit handles them gracefully.

## Control

```bash
bandit -ii -ll demo.py
```

Observed result:

- command completes normally
- exit code: `0`

## Reproduction A

```bash
bandit -ii -ll -ii -ll demo.py
```

Observed result:

- Bandit terminates with `IndexError`
- exit code: `1`

Relevant traceback:

```text
bandit/cli/main.py:680
sev_level = constants.RANKING[args.severity - 1]
IndexError: list index out of range
```

## Reproduction B

```bash
bandit -ll -ii -ll -ii demo.py
```

Observed result:

- same `IndexError`
- exit code: `1`

## Observation

The failure is reproducible with repeated severity/confidence flags in more than one argument order.

This suggests that the behavior is related to accumulation of repeated flags rather than their specific order.

## Hypothesis

Repeated severity/confidence options may increase an internal numeric value beyond the valid `constants.RANKING` range without validation.

This is a hypothesis, not a confirmed root cause.

## Reproduce locally

```bash
./reproduce.sh
```

The script creates an isolated temporary Python environment, installs Bandit 1.9.4, runs the control and reproduction cases, and removes the temporary environment afterwards.

## Evidence

- `evidence/control.txt`
- `evidence/reproduction.txt`
- `notes/results.txt`

## Scope

This case study documents independent reproduction only. It does not claim a root cause or propose a fix yet.
