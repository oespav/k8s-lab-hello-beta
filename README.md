# hello-beta

Owned by **team-beta**. A multi-version helloworld service, deployed by Argo CD
from this repo into namespace `team-beta` and exposed at
`https://tools.internal.localhost:9443/hello` (lab edge LB port) through the platform's shared `internal` gateway.

## Layout

```
chart/                      Helm chart: Deployments + Services per version, HTTPRoute
environments/lab/values.yaml  what runs in the lab cluster (versions, weights, hostname)
```

## Ship a change

1. Edit `environments/lab/values.yaml` (e.g. shift `weight` between v1 and v2).
2. Commit and push to `main`.
3. Argo CD syncs within ~30 s. Watch it in the Argo CD UI (app `hello-beta`) and
   in the traffic console.

## What the platform decides (not this repo)

- The namespace (`team-beta`) and that it may use the `internal` gateway
- That this repo may only create Deployments, Services, ConfigMaps,
  ServiceAccounts, HTTPRoutes, HPAs and PDBs, and only in `team-beta`
- That pods meet the `restricted` Pod Security Standard (the chart's
  `podSecurityContext`/`securityContext` do; a pod that doesn't is refused)
- The namespace's ResourceQuota and LimitRange (CPU/memory ceiling, pod count)

Those live in `platform-infra/argocd/tenants/team-beta.yaml`. Need something else?
Open a PR there.
