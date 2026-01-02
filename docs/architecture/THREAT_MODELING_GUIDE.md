# Threat Modeling Guide for RAG AI Agents (STRIDE)

This guide explains how to produce an enterprise-quality threat model for a RAG-based AI agent and convert it into executable controls.

## What you threat model in a RAG agent
- Prompt ingress and API boundary
- Retrieval query and context assembly
- Document ingestion and indexing pipeline
- Model gateway and inference boundary
- Tool-use / agent actions
- Logging, telemetry, and audit pipeline

## Convert threats to controls
Each high-risk threat should map to:
- CI gates (IaC scanning, adversarial probes, config validation)
- Runtime guardrails (hallucination/PII thresholds, citation allow-lists)
- Evidence artifacts (reports, logs, checksums)

This repo demonstrates that mapping end-to-end.
