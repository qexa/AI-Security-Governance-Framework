"""examples/rag-agent/app.py

Minimal RAG agent scaffold to demonstrate where security controls plug in.
Focus: enforcement points for retrieval policy, prompt injection checks, and output guardrails.

Run:
  pip install fastapi uvicorn pyyaml
  uvicorn app:app --reload
"""

from __future__ import annotations

import uuid
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="RAG Agent (Security Scaffold)")

class ChatRequest(BaseModel):
    user_id: str
    prompt: str

class ChatResponse(BaseModel):
    request_id: str
    answer: str
    citations: list[dict] = []

def retrieval_policy_check(user_id: str, query: str) -> None:
    # Replace with ABAC/RBAC enforcement.
    if not user_id:
        raise ValueError("user_id required")

def retrieve_context(query: str) -> tuple[str, list[dict]]:
    # Placeholder retrieval. Replace with vector DB + doc store.
    context = "Approved KB snippet about password reset policy."
    citations = [{"source": "approved_kb", "ref": "KB-123"}]
    return context, citations

def call_model(prompt: str, context: str) -> str:
    # Placeholder model call. Replace with model gateway invocation.
    return f"Answer based on context: {context}"

@app.post("/chat", response_model=ChatResponse)
def chat(req: ChatRequest) -> ChatResponse:
    request_id = str(uuid.uuid4())

    # 1) Identity-aware retrieval controls
    retrieval_policy_check(req.user_id, req.prompt)

    # 2) Retrieve context
    context, citations = retrieve_context(req.prompt)

    # 3) LLM call
    answer = call_model(req.prompt, context)

    # 4) Runtime guardrails should run here (see observability/main_eval.py)
    return ChatResponse(request_id=request_id, answer=answer, citations=citations)
