---
layout: project
title: Future Projects
---

## <a href="/projects/future/">Future Projects</a>

Projects that are not current, but either planned or else maybe someday.

<div markdown="0">

{% assign update_pages = site.pages | sort: "date" | reverse %}

{% for page in update_pages %}
  {% assign path_parts = page.path | split: "/" %}
  {% if page.path contains "projects/future/" and path_parts.size == 4 % and page.path != "projects/future/index.md" %}
    <hr>
    <p>
      <a href="{{ page.url }}">{{ page.title }}</a><br>
      {% if page.blurb %}<p>{{ page.blurb }}</p>{% endif %}
    </p>
  {% endif %}
{% endfor %}

</div>