# obedmr.com

Personal Hugo blog for Bible studies, reflections, and technology notes.

The site currently uses the Blowfish theme, but content should stay as close as
possible to Hugo-native conventions so future theme changes are easier.

## Requirements

- Git
- Make
- curl

The Makefile installs and uses a pinned local Hugo Extended binary when needed:

```bash
make ensure-hugo
```

## Local Development

Run the local development server:

```bash
make serve
```

Defaults:

- Host: `127.0.0.1`
- Port: `1313`
- Base URL: `http://127.0.0.1:1313/`

You can override them:

```bash
make serve PORT=1314
```

Build the site without serving:

```bash
make build
```

Deploy the generated public site:

```bash
make deploy
```

Use a custom deploy message:

```bash
make deploy MSG="Update site content"
```

## Content Structure

Use Hugo leaf bundles for posts. A post lives in its own directory with an
`index.md` file:

```text
content/tech/my-new-post/
└── index.md
```

For translated bundled posts, put both languages in the same bundle:

```text
content/tech/my-new-post/
├── index.md
└── index.es.md
```

For simple standalone translated pages, use Hugo's filename suffix pattern:

```text
content/bible/weekly/intro.md
content/bible/weekly/intro.es.md
```

Current main sections:

- `content/bible/`
- `content/tech/`
- `content/reflections/`

Section landing pages are stored as `_index.md` files. For example:

```text
content/bible/_index.md
content/bible/_index.es.md
content/tech/_index.md
content/tech/_index.es.md
```

## Creating New Posts

Create a Bible post bundle:

```bash
./.tools/hugo-0.162.1/hugo new content --kind bible bible/weekly/my-new-study
```

Create a tech post bundle:

```bash
./.tools/hugo-0.162.1/hugo new content --kind tech tech/my-new-tech-post
```

Create a reflection post bundle:

```bash
./.tools/hugo-0.162.1/hugo new content --kind reflections reflections/my-new-reflection
```

The archetypes live in:

- `archetypes/default.md`
- `archetypes/bible/index.md`
- `archetypes/tech/index.md`
- `archetypes/reflections/index.md`

## Front Matter

Prefer portable Hugo fields:

```yaml
---
title: "Post Title"
date: 2026-09-05T10:00:00-06:00
draft: true
description: "Short SEO and social description."
summary: "Short list/card preview."
categories:
- bible
tags:
- bible
- treasure
translationKey: post-title
aliases:
- /old/url/
---
```

Notes:

- Use `draft: true` while writing.
- Remove `draft` or set `draft: false` when ready to publish.
- Use `description` for search/social previews.
- Use `summary` for list and card previews.
- Use `translationKey` to explicitly connect translated pages.
- Use `aliases` when moving content so older URLs keep working.
- Avoid theme-specific front matter unless a post really needs it.

## Summaries

Hugo supports manual summaries with:

```markdown
Opening paragraph used as the preview.

<!--more-->

Rest of the post.
```

This is useful when the first paragraph should become the preview. If you add a
`summary` field in front matter, Hugo/themes can use that directly for cards and
lists.

## Images

For the most portable setup, place post images inside the page bundle:

```text
content/bible/weekly/my-new-study/
├── index.md
└── cover.jpg
```

Recommended names for preview images:

- `cover.jpg`
- `cover.png`
- `thumbnail.jpg`
- `thumbnail.png`
- `feature.jpg`
- `feature.png`

The current site has a small adapter that lets bundled cover/thumbnail images
work with the theme. If a post has no image, the site falls back to default
Bible or tech images.

## Current Categories

These categories are currently used by posts:

- `bible`
- `weekly-treasure`
- `tech`
- `talks`
- `reflections`

Suggested use:

- Use `bible` for Bible studies and reflections.
- Use `weekly-treasure` for the weekly Bible study series.
- Use `tech` for technical writing.
- Use `talks` for conference/community talk notes.
- Use `reflections` for personal reflections that are not specifically Bible or tech.

## Current Tags

These tags are currently used by posts:

- `bible`
- `big-data`
- `c`
- `career`
- `cloud`
- `communication`
- `containers`
- `desarrollo`
- `development`
- `exodus`
- `golang`
- `hadoop`
- `infrastructure`
- `kubernetes`
- `learning`
- `open-source`
- `openstack`
- `oracion`
- `programming`
- `proverbios`
- `psalms`
- `python`
- `spark`
- `talks`
- `tech`
- `timoteo`
- `timothy`
- `treasure`
- `vagrant`
- `writing`

Suggested tagging style:

- Keep tags lowercase.
- Use hyphens for multi-word tags, for example `open-source`.
- Prefer a few meaningful tags instead of many broad tags.
- Reuse existing tags when they fit.

## Documentation

Useful Hugo documentation:

- [Content organization](https://gohugo.io/content-management/organization/)
- [Front matter](https://gohugo.io/content-management/front-matter/)
- [Page bundles](https://gohugo.io/content-management/page-bundles/)
- [Page resources](https://gohugo.io/content-management/page-resources/)
- [Multilingual content](https://gohugo.io/content-management/multilingual/)
- [Summaries](https://gohugo.io/content-management/summaries/)
- [Archetypes](https://gohugo.io/content-management/archetypes/)
- [URL management and aliases](https://gohugo.io/content-management/urls/)
- [Taxonomies](https://gohugo.io/content-management/taxonomies/)

Theme documentation:

- [Blowfish documentation](https://blowfish.page/docs/)
- [Blowfish front matter](https://blowfish.page/docs/front-matter/)
