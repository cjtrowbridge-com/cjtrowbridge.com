---
layout: simple
title: Cookbook
---

<!--
Import each recipe as cookbook/recipe-slug/index.md. Keeping a recipe in its
own folder gives it a clean URL and a home for photos or other recipe assets.
Each recipe needs Jekyll frontmatter so it is published and listed:

---
layout: simple
title: Recipe Name
---
-->

## Cookbook

<ul>
{% assign recipes = site.pages | sort: "title" %}
{% for recipe in recipes %}
  {% if recipe.path contains "cookbook/" and recipe.path != "cookbook/index.md" %}
    <li><a href="{{ recipe.url }}">{{ recipe.title }}</a></li>
  {% endif %}
{% endfor %}
</ul>
