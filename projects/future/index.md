---
layout: project
title: Future Projects
---

## <a href="/projects/future/">Future Projects</a>

Projects that are not current, but either planned or else maybe someday.

<div class="row" markdown="0">

{% assign project_pages = site.pages | where_exp: "page", "page.path contains 'projects/future/' and page.path != 'projects/future/index.md'" %}
{% assign sorted_pages = project_pages | sort: "lastUpdated" | reverse %}

{% for page in sorted_pages %}
  <div class="col-12">
    <div class="card">
        <div class="card-body">
            {{ page.content }}
        </div>
    </div>
  </div>
{% endfor %}

</div>
