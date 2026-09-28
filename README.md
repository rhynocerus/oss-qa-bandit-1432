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
