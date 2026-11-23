# DAST baseline methodology

## 1. Purpose

Establish a repeatable first-pass security check for a web application and produce evidence that a human reviewer can triage.

## 2. Preconditions

- Written authorization and a defined scope.
- A local, staging, or dedicated test environment.
- Test accounts and roles documented.
- A communication channel and emergency contact.
- Agreement on data handling and evidence retention.

## 3. Execution

1. Confirm the target is reachable and the scope matches the authorization record.
2. Start the lab and wait for the target health check.
3. Run the ZAP baseline with HTML, JSON, and Markdown outputs.
4. Record the scan start time, target, ZAP version, and scope.
5. Triage every alert: true positive, false positive, or informational.
6. Reproduce confirmed issues with a minimal request.
7. Write findings with impact, evidence, remediation, and a retest step.
8. Retest after remediation and record the result.

## 4. Coverage and limits

A baseline scan covers crawling, passive checks, and a limited active scan. It does not cover:

- multi-step authentication and authorization chains;
- business-logic abuse;
- race conditions;
- client-side issues that require interaction;
- data exposure that requires domain knowledge.

## 5. Severity

Use CVSS as a starting point and adjust with business context.

| Severity | Guidance |
| --- | --- |
| Critical | Direct compromise of sensitive data or administrative control with low effort |
| High | Significant confidentiality, integrity, or availability impact |
| Medium | Limited impact or requires specific preconditions |
| Low | Minor information exposure or hardening gap |
| Informational | Best-practice observation with no direct impact |

## 6. Evidence

Capture the request, response, headers, timestamps, and reproduction steps. Redact credentials, tokens, personal data, and internal identifiers. Store evidence according to the agreed retention policy.

## 7. Reporting

Lead with the executive summary and the remediation plan. Put detailed findings in an appendix. Every finding needs a clear owner, a fix, and a verification step.
