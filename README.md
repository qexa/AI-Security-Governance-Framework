# AI Security Governance Framework

<p align="center">
  <strong>Security-as-Code for a RAG-based AI Agent</strong><br/>
  Triple-layer defense: <em>Threat Modeling → Adversarial Testing → Runtime Guardrails (Galileo)</em>
</p>

<p align="center">
  <a href="#overview">Overview</a> •
  <a href="#triple-layer-architecture">Architecture</a> •
  <a href="#quickstart">Quickstart</a> •
  <a href="#evidence-first-ci">Evidence</a> •
  <a href="#standards--governance-alignment">Standards</a> •
  <a href="#repository-layout">Layout</a>
</p>

<p align="center">
  <img alt="license" src="https://img.shields.io/badge/License-MIT-green.svg">
  <img alt="python" src="https://img.shields.io/badge/Python-3.11%2B-blue">
  <img alt="terraform" src="https://img.shields.io/badge/Terraform-1.8%2B-623CE4">
  <img alt="actions" src="https://img.shields.io/badge/GitHub%20Actions-Evidence--First-2088FF">
  <img alt="ai-security" src="https://img.shields.io/badge/AI%20Security-Guardrails%20%26%20Red%20Team-orange">
</p>

---

## Overview

This repository demonstrates an enterprise-ready approach to securing a **Retrieval-Augmented Generation (RAG)** AI Agent using **Security-as-Code**.

The goal is not “secure AI” as a document.
The goal is **executable security**: policy gates, evidence artifacts, and runtime enforcement you can automate across teams and business units.

This repo is built for:
- Reusable enterprise patterns (templates and modules you can replicate)
- Automation-first security (CI gates + drift signals + adversarial probes)
- Runtime governance (hallucination/PII guardrails using Galileo-style evaluation)
- Audit readiness (evidence artifacts generated and uploaded automatically)

---

## Risk Formula

\[
Risk = Probability \times Impact
\]

---

## Triple-Layer Architecture

```mermaid
flowchart LR
  U[User / App] -->|Prompt| GW[AI Gateway / Agent API]
  GW -->|Retrieval Query| R[(Vector DB / Doc Store)]
  R -->|Context| GW
  GW -->|LLM Call| MG[Model Gateway]
  MG -->|Response| GW
  GW -->|Output| U

  subgraph Layer1[Layer 1: Design-Time]
    TM[Threat Modeling (STRIDE)]
  end

  subgraph Layer2[Layer 2: Pre-Deploy CI/CD]
    CI[CI Gates: IaC Validate + Drift Signals]
    RT[Adversarial Probes (SLXP-style)]
    EV[evidence/ artifacts]
  end

  subgraph Layer3[Layer 3: Runtime]
    GA[Galileo Guardrails: Hallucination + PII]
    OPA[Policy-as-Code (OPA/Rego)]
  end

  TM -. requirements .-> CI
  TM -. requirements .-> GA
  CI --> EV
  RT --> EV
  GA --> EV
  OPA --> GW
```

### Layer 1 — Design-Time (Left-Shift)
Threat model the RAG agent and convert priority risks into executable requirements.

- STRIDE threats for retrieval, ingestion, model calls, and tool use
- Clear trust boundaries and high-value assets
- Output requirements that become CI gates and runtime guardrails

Artifacts:
- `architecture/threat-models/AI_RAG_ThreatModel.md`
- `docs/architecture/THREAT_MODELING_GUIDE.md`

### Layer 2 — Pre-Deploy (Active Defense in CI/CD)
Automate security gates before deployment.

- Terraform validate + drift signal checks
- IaC scans (checkov optional, tfsec pattern)
- SLXP-style adversarial report validation and severity gate
- Evidence folder output uploaded as GitHub Actions artifacts

Artifacts:
- `.github/workflows/ai-security-scan.yml`
- `red-teaming/slxp-probes/Red_Team_Report.json`
- `docs/ci/CI_SECURITY_GATES.md`
- `docs/ci/CI_EVIDENCE_ARTIFACTS.md`

### Layer 3 — Runtime (Observability + Guardrails using Galileo)
Measure and enforce safe behavior at runtime.

- Hallucination and PII risk thresholds
- Citation allow-list patterns (policy-as-code)
- Auditable decisions with correlation IDs

Artifacts:
- `observability/galileo-configs/guardrail_policy.yaml`
- `observability/main_eval.py`
- `policies/opa/agent_output_policy.rego`

---

## Quickstart

### Run runtime guardrails (demo mode)
```bash
python3 -m pip install --upgrade pip
pip install pyyaml
python3 observability/main_eval.py --policy observability/galileo-configs/guardrail_policy.yaml --demo
```

### Run local IaC scanning (optional)
```bash
bash scripts/run_checkov.sh
bash scripts/run_tfsec.sh
```

---

## Evidence-First CI

This repository follows an **evidence-first** CI pattern:
- Each job writes audit-friendly outputs to `evidence/`
- CI uploads evidence automatically as downloadable GitHub Actions artifacts

Docs:
- `docs/ci/CI_EVIDENCE_ARTIFACTS.md`

Download:
GitHub → Actions → open a workflow run → Artifacts.

---

## Standards & Governance Alignment

This framework translates governance requirements into **measurable, enforceable, and observable controls** by combining policy-as-code, CI/CD gating, and **runtime measurement using Galileo**.

### NIST AI Risk Management Framework (AI RMF)

| Function | How this repo supports it | Where |
|---|---|---|
| **GOVERN** | Policies, accountability, CI gates, evidence artifacts | `SECURITY.md`, `.github/workflows/*`, `evidence/`, `docs/ci/*` |
| **MAP** | System context, trust boundaries, STRIDE threats, misuse cases | `architecture/threat-models/*`, `docs/architecture/*` |
| **MEASURE** | **Galileo-driven evaluation signals** (hallucination/PII scoring, compliance checks) | `observability/galileo-configs/*`, `observability/main_eval.py` |
| **MANAGE** | Enforcement actions (block/sanitize), drift signals, severity-based CI gates | `.github/workflows/*`, `deployments/terraform/*`, `policies/opa/*`, `evidence/` |

### OWASP Top 10 for LLM / ML (Representative Coverage)

| OWASP Risk | Control Strategy | Where Implemented |
|---|---|---|
| Prompt Injection | Adversarial probes + runtime scoring/enforcement | `red-teaming/*`, `observability/*`, workflow gate |
| Sensitive Info Disclosure | PII detection and blocking thresholds | `observability/*`, `policies/opa/*` |
| Data / RAG Poisoning | Provenance threats + ingestion/retrieval controls | `architecture/*`, `docs/architecture/*` |
| Unbounded Consumption | Token/output constraints | `observability/*` |
| Excessive Agency | Tool-use boundaries and privilege controls | threat model + policy patterns |

### Why Galileo Matters
Policies define what should happen. CI controls what may be deployed. **Galileo measures what actually happens at runtime**, producing signals and decisions you can audit.

---

## Repository Layout

| Path | What it contains |
|---|---|
| `architecture/` | STRIDE threat model and security requirements |
| `deployments/terraform/` | Terraform modules, secure baseline, and drift-demo config |
| `red-teaming/` | Adversarial probe artifacts (SLXP-style JSON) |
| `observability/` | Runtime guardrail policies + enforcement code |
| `policies/opa/` | Policy-as-code examples (OPA/Rego) |
| `examples/` | Example RAG agent scaffold + Jenkins pipeline |
| `docs/` | Detailed documentation and cloud setup guides |
| `evidence/` | CI evidence folder (uploaded as GitHub Actions artifacts) |
