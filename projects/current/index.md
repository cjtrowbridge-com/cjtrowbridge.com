---
layout: project
title: Current Projects
---

## <a href="/projects/current/">Current Projects</a>

<div class="row" markdown="0">

{% assign project_pages = site.pages | where_exp: "page", "page.path contains 'projects/current/' and page.path != 'projects/current/index.md'" %}
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
