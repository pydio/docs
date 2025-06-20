# Pydio Docs Repository Structure
The Pydio documentation repository is organized into multiple branches and components for managing and building documentation.

# Main Branch
The main branch contains the MkDocs configuration, tools, and utilities to convert and aggregate documents.

## MkDocs Materials
* overrides/
* resources/
* mkdocs.yml
* requirements.txt
* resources/versions.json: We use Mike to deploy multiple versions of the docs.
Mike generates versions.json automatically; however, we maintain resources/versions.json to manually control versions and their labels.

This file overrides the Mike-generated versions.json.

## Document Conversion Tools
Located under the tools/ directory, these scripts handle the migration and aggregation of legacy documents from multiple repositories into a unified structure.

### git_script.sh

#### Prerequisites
Before running the script, clone the legacy repositories locally to:

```
LOCAL_REPO_ADMIN_GUIDE="/home/pydio/go/src/github.com/pydio/pydio-doc-admin-guide"
LOCAL_REPO_DEVELOPER_GUIDE="/home/pydio/go/src/github.com/pydio/pydio-doc-developer-guide"
LOCAL_REPO_KB="/home/pydio/go/src/github.com/pydio/pydio-doc-howto"
```

#### Functionality
`git_script.sh` scans these repositories across their respective branches and performs:

* Adds .nav.yaml files to each folder, containing frontmatter (slug, title, etc.).
* Inserts frontmatter metadata into each .md file:
* title, slug, weight (used to order pages).
* Fixes image links within .md files.
* Replaces [:summary] placeholders with actual section TOCs.


### local-build.sh
This script is used for local builds of the documentation using MkDocs and Mike.

#### Mkdocs plugins build/setup

Setup a clean python env

```
python -m venv /home/pydio/.venv
```

Propagate python Envs

```
source /home/pydio/.venv/bin/activate
```

pip install mkdocs mike
pip install mkdocs-material mkdocs-redirects mkdocs-minify-plugin pymdown-extensions mkdocs-glightbox

Install specific mkdocs plugin

```
pip install git+https://github.com/pydio/mkdocs-awesome-nav
```

`pydio/mkdocs-awesome-nav` is an specific plugin enabling following features:
- Understand the frontmatter of .md files such as title, slug, weight
- Understand the .nav.yaml of each section for menu & navigation bar

For example:

**Frontmatter:**

```
---
slug: install-static-binaries
title: Install Static Binaries
description: Installing Pydio Cells on your server using our pre-compiled binaries.
menu: Static Binaries
language: und
weight: 1
menu_name: menu-admin-guide-v7-enterprise

---
Page content

```

**.nav.yaml:**

```
title: Quick Start
abstract: This section provides a full-spectrum overview of Pydio Cells installation, configuration and usage.
menu: Quick Start
language: und
weight: 1
menu_name: menu-admin-guide-v7-enterprise

slug: quick-start
```

## Document Branches
The actual documentation contents are stored in version-specific branches:

* cells-v5

* cells-v4 (latest)

* pydio-v8

Each branch contains its own GitHub workflow file:

`.github/workflows/build-docs.yml` — triggers the documentation rebuild on push events.


## Artifact Branch

* gh-pages

GitHub Actions use MkDocs and Mike to build the documentation and store the resulting artifacts in this branch.

A separate GitHub Pages workflow listens to changes on gh-pages and triggers the website update process.

Live Documentation: https://pydio.github.io/docs

## Adding a new branch

When you need a new branch:
* Chekout new branch from one of document branches
* Update [main branch] resources/versions.json file

## Adding a new folder

At the top level, there are four repositories:
- Admin Guide
- CellsFlows
- Developer Guide
- Knowledge Base

MKdocs uses these repositories for items in the top bar

The left menu in the page reflects the folder struct in each frist-level repository

For instance:

```
admin-guide/
├── 1_quick_start
├── 2_running_cells_in_production
├── 3_connecting_your_users
├── 4_connecting_your_storage
├── 5_securing_your_data
├── 6_customize_interface
├── 7_advanced
├── images
└── urlmaps
```

* **images** : repository for all images
* **urlmaps**: A specific file containing the map of urls of legacy page to new format. Can be use for automatical redirection

When you browse `Admin Guide` page, you will see in the left-menu

```
- Quick Start
  ..
- Run Cells in Production
  ..
```

**FrontMatter** is a section in yaml instructs mkdocs to do following tasks:
- formating url with slugs
- labeling menu items by title
- ordering menu items by weight

For a `.md` file, frontmatter are at the top of file


```
---
slug: install-static-binaries
title: Install Static Binaries
description: Installing Pydio Cells on your server using our pre-compiled binaries.
weight: 1
---
Page content
```

For a repository, frontmatter is in `.nav.yaml` file at the top level of repository

```
title: Cells Installation
abstract: Getting started with Pydio Cells using pre-compiled binaries or cloud images.
weight: 1
slug: cells-installation
```

> Notice: only three meta are taken into account: `title`, `weight`, `slug`

### Introduction page
Each repository may have an introduction page. You can do by adding `index.md` file at the top level of the repository

For example:

```
This section provides a full-spectrum overview of Cells installation, configuration and usage.

- [Requirements](../requirements/)
- [Quick Admin Tour](../quick-admin-tour/)
- [Sharing Features](../sharing-features/)
- [Connect Desktop Sync](../connect-desktop-sync/)
- [Mobile Apps](../mobile-apps/)
- [Glossary](../glossary/)

```

> Notice: the menu item is clickable if an corresponding `index.md` exists

> WARNING: Don't add `slug` to frontmatter of a `index.md` file

> Notice: Adding a new topbar section, it's require addition copy line in .github/workflows/deploy-docs.yml file

```
      - name: Copy docs to docs repo
        run: |
          cp -r admin-guide docs
          cp -r cellsflows docs
          cp -r developer-guide docs
          cp -r knowledge-base docs
          
          # New section
          cp -r new-section docs
```
