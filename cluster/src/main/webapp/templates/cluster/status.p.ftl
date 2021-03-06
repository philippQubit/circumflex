[#ftl]

<h1>${cluster.id}</h1>
<p class="remark">${cluster.project.baseDir.getAbsolutePath}</p>

<pre><code>${cluster.project.lastCommitLog}</code></pre>

<table width="100%"
       class="rows">
[#list cluster.servers as server]
  <tr>
    <td colspan="3">
      <div class="relative">
        <h3>
          <a href="javascript:;"
             class="no-underline"
             data-switch="#server-${server.shortUuid}">
            <span>${server.address}</span>
            <span class="caret"></span>
          </a>
        </h3>
        <div id="server-${server.shortUuid}"
             class="dropdown-menu primary">
          <form action="/cluster/${cluster.id}/server/${server.shortUuid}/~build"
                method="post"
                class="submission partial">
            <a href="javascript:;"
               class="submit">
              <img class="glyph"
                   src="http://cdn.savant.pro/img/glyph/32/cogs.png"/>
              <span>${msg['job.build-server']}</span>
            </a>
          </form>
          <form action="/cluster/${cluster.id}/server/${server.shortUuid}/~restart"
                method="post"
                class="submission partial">
            <a href="javascript:;"
               class="submit">
              <img class="glyph"
                   src="http://cdn.savant.pro/img/glyph/32/repeat.png"/>
              <span>${msg['job.restart-server']}</span>
            </a>
          </form>
          [#if server.tasks?size > 0]
            <hr/>
            [#list server.tasks as task]
              <form action="/cluster/${cluster.id}/server/${server.shortUuid}/~execute-${task_index?c}"
                    method="post"
                    class="submission partial">
                <a href="javascript:;"
                   class="submit">
                  <img class="glyph"
                       src="http://cdn.savant.pro/img/glyph/32/play.png"/>
                  <span>${task.title}</span>
                </a>
              </form>
            [/#list]
          [/#if]
        </div>
      </div>
    </td>
  </tr>
  [#list server.nodes as node]
    <tr id="node-${node.shortUuid}"
        data-check-url="/cluster/${cluster.id}/node/${node.shortUuid}/~status">
      [#assign unchecked = "true"/]
    [#include "/node/status.p.ftl"/]
    </tr>
  [/#list]
[/#list]
</table>

<form class="submission partial margin-top"
      action="/cluster/${cluster.id}/~build"
      method="post">
  <a href="javascript:;"
     class="pill primary small submit">
    <img class="glyph"
         src="http://cdn.savant.pro/img/glyph/32/settings.png"/>
    <span>${msg['job.build-cluster']}</span>
  </a>
</form>

<form action="/cluster/${cluster.id}/~restart"
      method="post"
      class="submission partial margin-top">
  <a href="javascript:;"
     class="pill primary small submit">
    <img class="glyph"
         src="http://cdn.savant.pro/img/glyph/32/repeat.png"/>
    <span>${msg['job.restart-cluster']}</span>
  </a>
</form>

[#if cluster.classesTimestamp??]
<p>
  <span>${msg['cluster.built']}</span>
  <em>${cluster.classesTimestamp?datetime}</em>
</p>
[#else]
<p>
  <span>${msg['cluster.notBuilt']}</span>
</p>
[/#if]

<form class="submission partial margin-top"
      action="/cluster/${cluster.id}/~module-mci"
      method="post">
  <a href="javascript:;"
     class="pill primary small submit"
     title="${msg['job.module-mci']}">
    <img class="glyph"
         src="http://cdn.savant.pro/img/glyph/32/check_partial.png"/>
    <code>${cluster.project.baseDir.getAbsolutePath} $ mvn clean install</code>
  </a>
</form>
<form class="submission partial margin-top"
      action="/cluster/${cluster.id}/~project-mci"
      method="post">
  <a href="javascript:;"
     class="pill primary small submit"
     title="${msg['job.project-mci']}">
    <img class="glyph"
         src="http://cdn.savant.pro/img/glyph/32/check.png"/>
    <code>${cluster.project.rootProject.baseDir.getAbsolutePath} $ mvn clean install</code>
  </a>
</form>

<script type="text/javascript">

  (function() {

    var placeholders = {};

    function doCheck() {
      $("[data-check-url]").each(function() {
        var e = $(this);
        var url = e.attr("data-check-url");
        var id = e.attr("id");
        if (!placeholders[id])
          placeholders[id] = e.html();
        var placeholder = placeholders[id];
        $.ajax({
          type: "GET",
          url: url,
          dataType: "html",
          success: function(data) {
            e.empty().append(data);
            eaui.init(e);
          },
          error: function() {
            e.empty().append(placeholder);
            eaui.init(e);
          }
        });
      });
    }

    $(function() {
      doCheck();
      setInterval(doCheck, 10000);
    });

  })();

</script>

