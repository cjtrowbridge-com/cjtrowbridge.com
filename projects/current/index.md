---
layout: project
title: Current Projects
---

## <a href="/projects/current/">Current Projects</a>

<div markdown="0">

{% assign sorted_pages = site.pages | sort: "order" %}

{% for page in sorted_pages %}
  {% if page.path contains "projects/current/" and page.path != "projects/current/index.md" %}
    <div class="card">
        <div class="card-body">
            {{ page.content }}
        </div>
    </div>
  {% endif %}
{% endfor %}

</div>