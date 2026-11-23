# Illustrative findings

These examples are for report-writing practice. They are based on well-known vulnerability classes present in OWASP Juice Shop. They are **not** the output of a specific scan run and should not be copied into a real report without independent verification.

## F-001: SQL injection in the login form

| Field | Value |
| --- | --- |
| Severity | High |
| Category | Injection |
| Asset | `POST /rest/user/login` |

**Summary:** The login endpoint concatenates user input into a SQL query, allowing an attacker to bypass authentication or extract data.

**Reproduction:** Submit a crafted email value that changes the query logic, then observe that authentication succeeds without valid credentials.

**Impact:** An attacker can bypass authentication, enumerate accounts, or read data from the underlying database.

**Remediation:** Use parameterized queries or an ORM with bound parameters. Validate input, apply least-privilege database accounts, and add regression tests for injection payloads.

## F-002: Broken access control on basket resources

| Field | Value |
| --- | --- |
| Severity | High |
| Category | Broken access control |
| Asset | `GET /rest/basket/{id}` |

**Summary:** The endpoint authorizes the request but does not verify that the basket belongs to the authenticated user.

**Reproduction:** Authenticate as user A, request a basket owned by user B, and observe that the response contains user B's data.

**Impact:** An attacker can read or modify another user's basket and associated data.

**Remediation:** Enforce object-level authorization on every request. Derive the owner from the authenticated session, not from a client-supplied identifier, and add negative tests for cross-user access.

## F-003: Verbose error and missing security headers

| Field | Value |
| --- | --- |
| Severity | Medium |
| Category | Security misconfiguration |
| Asset | Application responses |

**Summary:** Error responses disclose stack traces or framework details, and the application is missing baseline security headers.

**Reproduction:** Trigger an application error and inspect the response body and headers.

**Impact:** Information disclosure helps an attacker map the stack; missing headers weaken defense in depth against clickjacking, MIME sniffing, and related attacks.

**Remediation:** Return generic error messages to clients, log details server-side, and add the appropriate security headers at the reverse proxy or application layer.
