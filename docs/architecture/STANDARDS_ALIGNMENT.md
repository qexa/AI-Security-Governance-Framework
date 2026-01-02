# Standards & Governance Alignment

This repo operationalizes AI governance using Security-as-Code and measurable runtime controls.

## NIST AI RMF
- GOVERN: policies, accountability, evidence-first CI gates
- MAP: STRIDE threat modeling for RAG/agents
- MEASURE: Galileo-style evaluation signals (hallucination/PII scoring)
- MANAGE: enforcement actions, severity-based gates, drift signals

## OWASP Top 10 for LLM/ML (Representative)
- Prompt Injection: probes + runtime controls
- Sensitive Info Disclosure: PII thresholds + redaction/block
- Data/RAG Poisoning: provenance controls + retrieval filtering
- Unbounded Consumption: token/output constraints
- Excessive Agency: least privilege tool-use boundaries

## Why Galileo
Galileo represents the runtime measurement/observability layer that turns AI risk into quantifiable signals and auditable decisions.
