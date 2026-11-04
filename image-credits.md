---
layout: default
title: Image credits
permalink: /image-credits/
---

# Image credits

The pictures on this site come from [Wikimedia Commons](https://commons.wikimedia.org/) and are free to use. Some are in the public domain. The rest are shared under Creative Commons licences that let anyone reuse them as long as the photographer is credited. We have not changed them, apart from resizing and cropping. If you reuse one, credit the author named below and link to the licence.

The cartoon illustrations on the front page are original drawings made for this site. Like our text, they are shared under the [Creative Commons Attribution-ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.en) licence, so you are welcome to use them on posters and leaflets.

If you took one of these photos and would like it credited differently, or removed, please [get in touch](/#contact).

<table class="credits-table">
  <thead><tr><th>Picture</th><th>Shows</th><th>Author</th><th>Licence</th></tr></thead>
  <tbody>
  {%- for c in site.data.image_credits %}
    <tr>
      <td><img src="{{ c.image | relative_url }}" alt="" loading="lazy" width="56" height="56"></td>
      <td><a href="{{ c.source }}">{{ c.name }}</a></td>
      <td>{{ c.author }}</td>
      <td>{% if c.licence_url != "" %}<a href="{{ c.licence_url }}">{{ c.licence }}</a>{% else %}{{ c.licence }}{% endif %}</td>
    </tr>
  {%- endfor %}
  </tbody>
</table>
