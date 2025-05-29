---
layout: project
title: Projects
---

## <a href="/projects/">Projects:</a>

**[Current Projects](/projects/current/)**  
<div class="row" markdown="0">
  {% assign sorted_pages = site.pages | sort: "date" | reverse %}
  {% for page in sorted_pages %}
    {% if page.path contains "projects/current/" and page.path != "projects/current/index.md" %}
      <div class="card">
          <div class="card-body">
              <a href="{{ page.url }}">{{ page.title }}</a>
              {% if page.blurb %}<p>{{ page.blurb }}</p>{% endif %}
          </div>
      </div>
    {% endif %}
  {% endfor %}
</div>

**[Past Projects](/projects/past/)**  
<div class="row" markdown="0">
  {% assign sorted_pages = site.pages | sort: "date" | reverse %}
  {% for page in sorted_pages %}
    {% if page.path contains "projects/past/" and page.path != "projects/past/index.md" %}
      <div class="card">
          <div class="card-body">
              <a href="{{ page.url }}">{{ page.title }}</a>
              {% if page.blurb %}<p>{{ page.blurb }}</p>{% endif %}
          </div>
      </div>
    {% endif %}
  {% endfor %}
</div>


**[Future Projects](/projects/future/)** 
<div class="row" markdown="0">
  {% assign sorted_pages = site.pages | sort: "date" | reverse %}
  {% for page in sorted_pages %}
    {% if page.path contains "projects/future/" and page.path != "projects/future/index.md" %}
      <div class="card">
          <div class="card-body">
              <a href="{{ page.url }}">{{ page.title }}</a>
              {% if page.blurb %}<p>{{ page.blurb }}</p>{% endif %}
          </div>
      </div>
    {% endif %}
  {% endfor %}
</div>
