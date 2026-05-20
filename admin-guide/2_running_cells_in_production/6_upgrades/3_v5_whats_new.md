---
slug: v5-whats-new-and-changed
title: What's new and changed in v5
description: Quick reference of the user-facing and breaking changes introduced in Cells v5.
menu: v5 — What's new
language: und
weight: 3
menu_name: menu-admin-guide-v7-enterprise

---
This page is a quick reference. For step-by-step upgrade guidance, see the [Cells v5 upgrade section](/admin-guide/running-cells-in-production/upgrades/major-versions-upgrade-informations/#cells-v5).

## At a glance

| Area                | What changed                                                                                  | Action on upgrade                                              |
|---------------------|-----------------------------------------------------------------------------------------------|----------------------------------------------------------------|
| Runtime             | New plugin-based engine driven by a single `bootstrap.yaml`                                   | Review your custom bootstrap if any (Kubernetes: re-render via Helm) |
| Reverse proxy       | External URL is **compulsory** behind a reverse proxy — no more implicit derivation           | Set External URL on every site **before** upgrading            |
| Primary database    | PostgreSQL is now a fully supported primary database                                          | Optional. Plan engine switch as a separate operation post-upgrade |
| Helm / Kubernetes   | Bundled subcharts deprecated; cells-controller workload added; OpenShift template available    | Externalize backends; allow controller RBAC for ConfigMaps/Secrets |
| Datasources         | GCS removed; structured datasources hidden behind an advanced flag                            | Migrate GCS-backed datasources to S3 (or equivalent) **before** upgrading |
| Migrations          | New v4 → v5 migration framework (SQL, PaT, policies, namespaces, metadata)                     | Runs automatically on first startup                            |
| Auth tokens         | Hydra JWKs regenerated; existing tokens invalidated                                           | Users log out; regenerate PATs used by scripts/clients         |
| Metadata            | New Entity Values store, redesigned info-panel UX                                             | Migrated automatically                                         |
| Pages               | New Pages display with default namespaces installed on first run                              | Nothing to do — new namespaces are created at first start      |
| Observability       | End-to-end OpenTelemetry (traces, logs, metrics) over OTLP                                    | Optional. Configure OTLP endpoint via `bootstrap.yaml`         |
| Legacy config       | Legacy config migrations deprecated                                                           | Upgrade goes through the v5 framework — do not chain old ones  |

## New features

- **Cloud-native clustering, fully rewritten** — stateless pods, externalized config/registry, replica-aware connectors, `cells-controller` workload.
- **Multi-tenancy** — tenants isolated across config/data/identity, configurable tenant header.
- **PostgreSQL** as a first-class primary database (PG 13+).
- **Routing flexibility** — Caddy and the Sites configuration are decoupled from the main HTTP server mux.
- **New brokers / queues** — NATS JetStream, gRPC PubSub, file-system PubSub broker, debounce and goqueue.
- **Vault-backed secrets** and **etcd-backed registry**.
- **Pages display** — modernized authoring experience, editor with Table-of-Contents hints.
- **Custom Metadata Entity Values** — togglable fields, focus-based editing, popover tagging, info-panel validation flows, pre-filled schema defaults.
- **Debounced search** on text-based fields, refreshed i18n (DE, FR, NO, PT-BR, JA, UK).
- **Enterprise: LLM/OpenAI integration**, scheduler syncer `dryRun` mode, refined policy/ACL semantics, additional S3 signature mode.

## Breaking changes & deprecation

- **Reverse URL compulsory** behind a reverse proxy — implicit detection from request headers removed.
- **Bundled Helm subcharts deprecated** — production deployments must use external services.
- **GCS datasources removed.**
- **Structured datasources** are now hidden behind an advanced configuration flag.
- **Legacy config migrations deprecated** — go through the v5 migration framework.
- **Misc API changes**: editor URL keys exposed on REST endpoints, presigned-URL flag on `/versions`, expanded CheckFileInfo response in the WOPI/Collabora integration.

## See also

- [Cells v5 upgrade — step-by-step](/admin-guide/running-cells-in-production/upgrades/major-versions-upgrade-informations/#cells-v5)
- [Bootstrap & Runtime](/admin-guide/advanced/bootstrap-and-runtime/)
- [Requirements — PostgreSQL](/admin-guide/quick-start/requirements/#postgresql-new-in-v5)
- [Cluster setup on Kubernetes](/admin-guide/running-cells-in-production/cluster-setup/k8s-advanced-parameters/)
