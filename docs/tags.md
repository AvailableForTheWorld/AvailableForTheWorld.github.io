---
layout: page
title: Tags
permalink: /tags/
---

{% for tag in site.tags %}

  <h3 id="{{ tag[0] }}">{{ tag[0] }}</h3>
  <ul>
    {% for post in tag[1] %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <small>{{ post.date | date_to_string }}</small>
      </li>
    {% endfor %}
  </ul>
{% endfor %}
