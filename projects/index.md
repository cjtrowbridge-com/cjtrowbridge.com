---
layout: simple
title: Projects
redirect_from:
  - /projects/current/
  - /projects/future/
  - /projects/past/
---

# Projects

Builds, experiments, research, and plans from across my project journal.

<div class="project-archive" markdown="0">
{% assign project_pages = site.pages | where: "type", "project" %}
{% assign posted_projects = project_pages | where: "status", "posted" %}
{% assign sorted_projects = posted_projects | sort: "lastUpdated" | reverse %}
{% for project in sorted_projects %}
  {% include project-card.html project=project %}
{% endfor %}
</div>
