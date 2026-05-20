---
slug: v5-multi-tenancy
title: Multi-tenancy
description: Running multiple isolated tenants on a single Cells v5 deployment.
menu: Multi-tenancy
language: und
weight: 4
menu_name: menu-admin-guide-v7-enterprise

---
Cells v5 introduces **first-class multi-tenancy** at the platform level. A single Cells deployment can serve multiple isolated tenants — each with their own configuration, data, and identity scope — without the need for separate installations.

> **Multi-tenancy vs. Group Tenancy.** This page describes platform-level multi-tenancy (tenants share the binary but not the data/identity layer). For per-user visibility scoping inside a single tenant (e.g. preventing class A from seeing class B), see [[Ent] Group Tenancy](/admin-guide/connecting-your-users/ent-group-tenancy/) instead.

## What is isolated per tenant

In a multi-tenant deployment, each tenant has its own:

- **Configuration**: the `bootstrap.yaml` and runtime config can declare per-tenant overrides; tenants do not share frontend plugin parameters.
- **Data**: storage backends are addressed per tenant — datasources, search index, activity feeds, scheduler jobs and metadata namespaces are all scoped.
- **Identity**: users, roles, groups, workspaces and authentication credentials live in the tenant's own identity tables; admins of one tenant cannot see users of another.

The Cells process itself is shared (binary, runtime manager, registry), which keeps memory and operational overhead low compared to running separate Cells instances.

## Routing requests to a tenant

Incoming requests are routed to a tenant via a **configurable tenant header**. The header name is declared in the bootstrap (Enterprise build) and is typically set by your reverse proxy or API gateway based on the incoming hostname:

```
X-Pydio-Tenant: tenant-acme
```

Requests without a tenant header are routed to the default tenant.

## Operating a multi-tenant deployment

- **Provisioning a new tenant**: the Enterprise admin tools expose tenant creation/teardown commands; per-tenant DB schemas and namespaces are created on first start.
- **Backups**: back up per tenant — each tenant's database schema and working directory are independent.
- **Upgrades**: a single upgrade lifts all tenants together. Pre-flight checks (collation, reverse URL) must pass for every tenant before the migration framework runs.
- **Cross-tenant operations**: by design, there are none. Sharing a file across tenants requires going through standard external-sharing flows.

## When to use it

Multi-tenancy is a good fit when you:

- run Cells for multiple customers from a single SaaS deployment;
- need strict identity isolation between business units sharing infrastructure;
- want to consolidate operations onto one cluster while keeping data isolation contractual.

It is **not** the right fit if you only need per-group visibility scoping — that is what [[Ent] Group Tenancy](/admin-guide/connecting-your-users/ent-group-tenancy/) is for.

## See also

- [Bootstrap & Runtime](/admin-guide/advanced/bootstrap-and-runtime/) — where the tenant header is declared.
- [[Ent] Group Tenancy](/admin-guide/connecting-your-users/ent-group-tenancy/) — user visibility scoping inside a single tenant.
