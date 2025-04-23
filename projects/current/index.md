---
layout: project
title: Current Projects
---


{% assign sorted_pages = site.pages | sort: "order" %}

{% for page in sorted_pages %}
  {% if page.path contains "projects/current/" and page.path != "projects/current/index.md" %}
    
    <fieldset>
    {{ page.output }}
    </fieldset>
    
  {% endif %}
{% endfor %}