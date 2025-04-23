---
layout: project
title: Future Projects
---

## <a href="/projects/future/">Future Projects</a>

<div class="row" markdown="0">

{% assign sorted_pages = site.pages | sort: "order" %}

{% for page in sorted_pages %}
  {% if page.path contains "projects/future/" and page.path != "projects/future/index.md" %}
    <div class="col-md-6">
      <div class="card">
          <div class="card-body">
              {{ page.content }}
          </div>
      </div>
    </div>
  {% endif %}
{% endfor %}

</div>