# Local Development Setup

## Runtime guardrails
```bash
python3 -m pip install --upgrade pip
pip install pyyaml
python3 observability/main_eval.py --policy observability/galileo-configs/guardrail_policy.yaml --demo
```

## Optional scanners
- checkov
- tfsec
- terraform
