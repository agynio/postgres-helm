# postgres-helm

Helm chart for deploying PostgreSQL instances on Kubernetes using the
agynio `service-base` library chart. The chart renders a `StatefulSet`
with an optional password `Secret`, a headless `Service`, and PVCs
provisioned through `volumeClaimTemplates`.

## Features

- Leverages the shared `service-base` helpers for naming and metadata.
- Supports passwords sourced from an existing Secret or generated from
  chart values.
- Configurable readiness and liveness probes based on `pg_isready`.
- PVC sizing, storage class, and mount points are fully configurable.
- Optional pod-level security context defaults tailored for
  `postgres:16.6-alpine`, with a gated volume-permissions init
  container to repair filesystem ownership when required.
- Common pod customisations (resources, affinity, tolerations, extra
  volumes, etc.) exposed through values.

## Requirements

- Helm 3.12 or newer
- Access to `oci://ghcr.io/agynio/charts` to pull the `service-base`
  dependency

## Usage

```bash
helm dependency build charts/postgres-helm
helm install platform-db charts/postgres-helm \
  --namespace platform \
  -f examples/platform-db.values.yaml
```

The chart enforces that either `postgres.password` is provided or an
`auth.existingSecret` is referenced. When no existing secret is given,
the chart creates one populated with `postgres.password` and the key
name defined by `auth.passwordKey`.

## Development

```bash
# Pull dependencies
helm dependency build charts/postgres-helm

# Lint the chart
helm lint charts/postgres-helm

# Render manifests with the example values
helm template platform-db charts/postgres-helm \
  -f examples/platform-db.values.yaml > /tmp/postgres.yaml
```

## Releasing

1. Update the chart version in `Chart.yaml` as needed.
2. Commit the changes to `main`.
3. Tag the repository with a semantic version (e.g. `v0.1.0`).

The GitHub Actions workflow in `.github/workflows/release.yaml`
packages the chart and pushes it to
`oci://ghcr.io/agynio/charts/postgres-helm` on every matching tag.
