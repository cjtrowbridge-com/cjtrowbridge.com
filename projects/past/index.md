---
layout: project
title: Past Projects
---

## <a href="/projects/past/">Past Projects</a>

<div markdown="0">

{% assign sorted_pages = site.pages | sort: "order" %}

{% for page in sorted_pages %}
  {% if page.path contains "projects/past/" and page.path != "projects/past/index.md" %}
    <div class="card">
        <div class="card-body">
            {{ page.content }}
        </div>
    </div>
  {% endif %}
{% endfor %}

</div>