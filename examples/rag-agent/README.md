# RAG Agent Security Scaffold

This example shows where security controls plug into a RAG agent:
- identity-aware retrieval checks
- provenance-aware retrieval and citations
- runtime output guardrails (hallucination + PII) using Galileo-style evaluation

Run:
```bash
pip install fastapi uvicorn pyyaml
uvicorn app:app --reload
```
