# AI RAG Threat Model (STRIDE) — Simulated ThreatModeler Export

## System Summary
This threat model covers a Retrieval-Augmented Generation (RAG) agent that:
- accepts user prompts via an API gateway
- retrieves context from a document store/vector index
- calls a model gateway for inference
- may invoke tools (APIs) on behalf of a user
- logs telemetry and safety signals for audit

## Trust Boundaries
- Internet/User → API Gateway
- Business Unit Apps → Shared AI Platform
- Agent Runtime → Retrieval Systems
- Agent Runtime → Model Gateway
- Agent Runtime → Tool APIs
- Runtime → Logging/Audit Store

## Assets
- System prompt and agent policies
- User prompts and session data
- Retrieval corpus and vector index
- API keys, IAM roles, and tokens
- Model outputs and citations
- Audit logs and evidence artifacts

## STRIDE Analysis (Selected Highlights)

### Spoofing
- Attacker spoofs user identity to access restricted corpora.
  - Controls: strong auth, MFA, token binding, identity-aware retrieval (ABAC/RBAC).

### Tampering
- Retrieval poisoning: attacker injects malicious documents into corpus.
  - Controls: ingestion approvals, provenance metadata, signed documents, integrity checks, quarantine pipeline.

### Repudiation
- Lack of correlation IDs makes actions non-attributable.
  - Controls: request_id per prompt, signed logs, immutable evidence storage.

### Information Disclosure
- Prompt injection causes disclosure of system prompt, secrets, or sensitive customer data.
  - Controls: prompt-injection probes in CI, runtime output policy (OPA), PII thresholds (Galileo), citation allow-lists.

### Denial of Service
- Unbounded token usage or tool-looping increases costs and blocks service.
  - Controls: token caps, rate limits, circuit breakers, tool-use budgets.

### Elevation of Privilege
- Agent tool-use crosses privilege boundary (e.g., calls admin API).
  - Controls: least privilege service identities, tool allow-lists, scoped tokens, policy checks before tool calls.

## Top Risks (Prioritized)
1) Prompt injection leading to sensitive disclosure (High likelihood / High impact)
2) Retrieval poisoning / untrusted provenance (Medium / High)
3) Excessive agency via tool misuse (Medium / High)
4) Missing audit evidence for runtime decisions (High / Medium)

## Requirements to Implement as Code
- CI gate on adversarial scan severity (fail on CRITICAL)
- IaC scanning + drift detection for storage/data layers
- Runtime guardrails (hallucination + PII) with evidence logs
- Citation allow-list enforced via policy-as-code
