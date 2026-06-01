# Project Post Governance Rules

These rules apply to all project posts at:

- `projects/current/*/index.md`
- `projects/past/*/index.md`
- `projects/future/*/index.md`

## Required Frontmatter Fields

Every project post must include these fields in YAML frontmatter:

- `pubdate: YYYY-MM-DD`
- `lastUpdated: YYYY-MM-DD`

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

## Sorting Policy

- Project index pages sort posts by `lastUpdated` in descending order.
- Most recently updated posts must appear first.
