# qa-security-lab

A local, repeatable DAST lab built with **OWASP ZAP** and **OWASP Juice Shop**. The target is intentionally vulnerable and runs on your machine. The repository is for practicing scan execution, triage, and reporting.

> Do not point ZAP at any system you do not own or have written authorization to test.

## What it demonstrates

- A disposable Docker Compose lab with a vulnerable target and a scanner on the same network.
- ZAP baseline scan with HTML, JSON, and Markdown reports.
- A CI job that runs the scan and uploads the report as an artifact.
- A triage workflow and reusable finding/report templates.
- A scope and authorization record that is completed before scanning.

## Architecture

```text
+----------------+        +----------------+
|  OWASP Juice   |        |   OWASP ZAP    |
|  Shop :3000    | <----> |  baseline scan |
+--------+-------+        +--------+-------+
         |                         |
         +---------- lab ----------+
                                   |
                                   v
                            reports/*.html
                            reports/*.json
                            reports/*.md
```

## Quick start

Prerequisites: Docker with the Compose plugin.

```bash
mkdir -p reports
docker compose run --rm zap
```

Reports are written to `reports/`:

- `zap-report.html` for reading;
- `zap-report.json` for automation;
- `zap-report.md` for pull requests or tickets.

You can also run the wrapper:

```bash
chmod +x scripts/run-scan.sh
./scripts/run-scan.sh
```

Juice Shop is available at <http://localhost:3000> while the lab is running.

## What the baseline covers

The ZAP baseline performs a spider, passive scanning, and a limited active scan. It is useful for a fast first pass, but it is **not** a full penetration test. It does not replace manual testing for:

- authentication and authorization chains;
- business-logic abuse;
- race conditions;
- client-side vulnerabilities that require interaction;
- data exposure that needs domain knowledge.

Treat every alert as a hypothesis and verify it manually before reporting it as a finding.

## CI

`.github/workflows/dast.yml` runs on every push and pull request:

1. validates the Compose file;
2. starts Juice Shop and waits for its health check;
3. runs the ZAP baseline;
4. verifies that a report was produced;
5. uploads the report as a workflow artifact;
6. tears the lab down.

The job does not fail on expected Juice Shop findings. The gate is that the scan ran and produced a report; the findings are reviewed by a human.

## Triage workflow

1. Reproduce the alert with a minimal request.
2. Confirm whether the issue is real, a false positive, or informational.
3. Assign severity using CVSS plus business context.
4. Capture evidence with secrets and personal data redacted.
5. Write the finding with a concrete remediation and verification step.
6. Retest after the fix and record the result.

## Templates

- [`templates/scope-and-authorization.md`](templates/scope-and-authorization.md)
- [`templates/methodology.md`](templates/methodology.md)
- [`templates/finding-template.md`](templates/finding-template.md)
- [`templates/report-template.md`](templates/report-template.md)
- [`samples/sample-findings.md`](samples/sample-findings.md) — illustrative examples, not a scan result

## Ethical use

This lab is intentionally vulnerable. Run it only on your own machine or in an isolated environment. Never use these scripts against production, third-party, or employer systems without explicit written authorization and a defined scope.

## License

MIT. See [LICENSE](LICENSE).

## Author

Rihan Yosral — QA Automation Engineer · <https://github.com/red-ruby-quay>
