---
layout: page
title: Blog
permalink: /blog/
---

<h1>Blog</h1>

<ul>
{% for post in site.posts %}
  <li>
    <h2>
      <a href="{{ post.url }}">{{ post.title }}</a>
      {% if post.tags %}
        <small>
          Tags:
          {% for tag in post.tags %}
            <a href="{{ '/tag/' | append: tag | append: '/' }}" class="tag">{{ tag }}</a>
          {% endfor %}
        </small>
      {% endif %}
    </h2>
    {{ post.excerpt }}
  </li>
{% endfor %}
</ul>
