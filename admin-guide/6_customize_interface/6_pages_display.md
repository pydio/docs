---
slug: pages-display
title: Pages display
description: Cells v5's new Pages display — modernized authoring and browsing experience for internal pages.
menu: Pages display
language: und
weight: 6
menu_name: menu-admin-guide-v7-enterprise

---
Cells Pages let you publish internal HTML pages — landing pages, knowledge base articles, team announcements — directly from inside Cells. They live alongside files, share the same access control, and are visible to the users you grant access to.

Cells v5 introduces a **redesigned Pages display** with a richer authoring experience and a cleaner browsing layout.

## What's new in v5

- **Default namespaces installed on first run.** A first-time install (or v4 → v5 upgrade) automatically registers the Pages namespaces, so the feature is available without manual configuration. If a previous installation removed them, they are re-created on the next start.
- **Modernized browsing layout.** The Pages display has been refactored to make navigation between pages and sections feel as natural as browsing files.
- **Editor with Table-of-Contents hints.** The page editor now surfaces a Table of Contents hint when a page is long enough to benefit from one, making it easier to keep internal articles well-structured.
- **Cleaner integration with the rest of the interface.** Pages appear in the standard navigation and inherit the same workspace/security model — there is no separate access path to learn.

## Enabling Pages

Pages are enabled by default. To control which users see them:

1. Open the **Application Pages** menu under admin delegation (see [Admin delegation](/admin-guide/connecting-your-users/admin-delegation/)).
2. Choose the workspaces or roles that should have access to the Pages workspace.
3. Optionally adjust the Pages namespaces from the Metadata panel — Pages relies on the same namespace mechanism as regular metadata, so you can extend it with custom fields.

## Authoring

The editor is reachable from the Pages workspace — click **New page** to open it.

- Pages are written in the standard rich-text editor; advanced users can insert raw HTML where needed.
- Long pages display a Table-of-Contents hint at the top — accept it to insert an auto-generated TOC.
- Drafts are saved automatically on focus changes, the same way other Cells forms behave in v5.

## Upgrading from v4

The v4 → v5 migration framework takes care of the namespace registration on first start. If you customized Pages namespaces in v4, they are preserved; the v5 display picks them up unchanged.

## See also

- [Custom Metadata](/admin-guide/connecting-your-storage/metadata/) — Pages namespaces use the same Entity Values store as file metadata.
- [Admin delegation](/admin-guide/connecting-your-users/admin-delegation/) — controlling who can manage Pages.
