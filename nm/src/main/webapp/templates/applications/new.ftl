[#ftl]

[#assign main]
<form action="/applications"
      method="post"
      class="submission">
  <h2>${msg['apps.create.title']}</h2>
  [#include "edit-base.p.ftl"/]
  <div class="submits margin-top centered">
    <input type="submit"
           class="btn primary inverse"
           value="${msg['apps.create']}"/>
    <span>${msg['or']}</span>
    <a href="/applications">${msg['cancel']}</a>
  </div>
</form>
[/#assign]

[#include "layout.ftl"/]