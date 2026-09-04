# Project Post Governance Rules

These rules apply to all project posts at:

- `projects/YYYY-MM-DD-<slug>/index.md`, excluding the project archive at
  `projects/index.md`

## Required Frontmatter Fields

Every project post must include these fields in YAML frontmatter:

- `layout: project`
- `type: project`
- `title`: the article title
- `description`: a one-sentence summary used in cards and metadata
- `redirect_from`: the legacy category URLs for the project
- `pubdate: YYYY-MM-DD`
- `lastUpdated: YYYY-MM-DD`

Every project is published at `/projects/YYYY-MM-DD-<slug>/`, using its
immutable `pubdate` as the folder prefix. The former `current`, `future`, and
`past` categories are retained only as redirects so existing links continue
to work.

For a project named `<slug>`, use:

```yaml
redirect_from:
  - /projects/current/<slug>/
  - /projects/future/<slug>/
  - /projects/past/<slug>/
  - /projects/current/YYYY-MM-DD-<slug>/
  - /projects/future/YYYY-MM-DD-<slug>/
  - /projects/past/YYYY-MM-DD-<slug>/
```

Project posts should include these fields when suitable artwork is available:

- `image`: a root-relative path to the card and article image
- `imageAlt`: a concise description of the image

The shared card component provides a visual fallback when `image` is omitted.

Optional fields include:

- `tags`: a YAML list of subjects covered by the article
- `featured`: a boolean reserved for intentionally promoted projects

## Date Field Semantics

- `pubdate` is the original publish date.
- `pubdate` is write-once and must not be changed after first publication.
- `lastUpdated` is the most recent meaningful content update date.
- Any content change to a post must update `lastUpdated` to that date.

## Date Format Rules

- Use ISO format only: `YYYY-MM-DD`.
- Use zero-padded month and day.
- Use unquoted YAML dates for consistency.

## New Post Rules

- New posts must include both `pubdate` and `lastUpdated`.
- For a brand-new post, set `lastUpdated` equal to `pubdate`.
- The folder date must exactly match `pubdate`.
- New posts must reserve both dated and undated versions of all three legacy
  category URLs with `redirect_from`.

## Sorting Policy

- Project index pages sort posts by `lastUpdated` in descending order.
- Most recently updated posts must appear first.

## Article Body Rules

- Do not repeat the article title as the first heading in the body.
- Do not repeat the frontmatter image at the beginning of the body.
- Start with the article introduction or its first meaningful section.
