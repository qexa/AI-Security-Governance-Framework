package ai.agent.output

# Example output policy checks for an AI gateway / agent runtime.
# Demo controls:
# - block system prompt disclosure language
# - block SSN-like patterns
# - require citations from approved sources

default allow = true

approved_sources := {"approved_kb", "policy_repo", "public_docs"}

deny[msg] {
  contains(lower(input.output.text), "system prompt")
  msg := "Blocked: system prompt disclosure pattern detected."
}

deny[msg] {
  re_match("\\b\\d{3}-\\d{2}-\\d{4}\\b", input.output.text)
  msg := "Blocked: SSN-like pattern detected."
}

deny[msg] {
  some i
  src := input.output.citations[i].source
  not approved_sources[src]
  msg := sprintf("Blocked: citation source not approved: %v", [src])
}

allow {
  count(deny) == 0
}
