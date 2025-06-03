# Mkdocs plugins build/setup

Setup a clean python env

```
python -m venv /home/pydio/.venv
```

Propagate python Envs

```
source /home/pydio/.venv/bin/activate
```

pip install mkdocs mike
pip install mkdocs-material mkdocs-redirects mkdocs-minify-plugin pymdown-extensions mkdocs-glightbox git+https://github.com/pydio/mkdocs-awesome-nav

Install specific plugin

```
pip install git+https://github.com/pydio/mkdocs-awesome-nav
```

`https://github.com/pydio/mkdocs-awesome-nav` is cloned repo.
The original `mkdocs-awesome-nav` relies on folder structure for menu and urls. The modification in this repo adds following features:

- Add slug value into frontmatter YAML or in sections .nav.yaml for url formatting. With slug, the url become more clean and easy to remember.
- Menu items' labels are independent from file/folder name.
- Add `weight` meta data for sorting. 


# Migration from old docs
## 1. Converting old docs to new repository

The documents of pydio cells are distributed in several github repositories. Before being able to use mkdocs, we need to copy them to a new repository.
The old documents are also in different format which is not compatible with mkdocs. `tools/converter.sh` allow us not only copy the document but also convert them to mkdocs compatible format.

- Converting `.yaml` file to frontmatter YAML in each `.md` file
- Add slug to frontmatter YAML. Use slug value for url construction
- Converting .md file of each section to .nav.yaml file. The .nav.yaml will be used for url formating, menu displaying
- Generate a map of old urls to new url. This data may be used for the automation of redirection.
- Copy images folder to the destination
- The article may include some links to other pages. This file also scans files for links then update them with new format.

- In old documentation, each section has an `overview` page with a small paragraph resuming the content of the section. A `[:summary]` placeholder is used to replaced the actual list of articles in the section. `tools/generate_toc.sh` tries to search for `[:summary]` placeholder and replace it by a list of articles with updated urls.

> Notice: these tools is used once when doing migration from old docs to mkdocs.