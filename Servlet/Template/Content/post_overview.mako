<%doc>
   required:
     postList: [<Row _id=, key=, value={'_id':, 'content':, 'username':,
                  'dateAndTime':, 'category':, 'title':}>,
                <Row ...>, ...]
     getCommentCount(postId): int
     cfg_siteUrl: string
     prettyPrintDate(x): def
     prettyPrintTime(x): def
</%doc>
<!-- -->       <section id="postingSection"> <!-- POSTING -->
               <div class="row">
                  <h2>Beitragsübersicht</h2>
               </div>

               <div class="row">
                   <div class="col5"><h3>Betreff</h3></div>
                   <div class="col2"><h3>Antworten</h3></div>
                   <div class="col3 postOverviewDate"><h3>⇣ Letzte Änderung</h3></div>
                   <div class="col2 postOverviewDate"><h3>Verfasster</h3></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               % for post in postList:
               <div class="row postStretch">
                   <div class="col5"><a href="${cfg_siteUrl}/post/view/${post.value['_id']}">${post.value['title']}</a></div>
                   <div class="col2">${getCommentCount(post.value['_id'])}</div>
                   <%
                     date = prettyPrintDate(post.value['dateAndTime'][0:3])
                     time = prettyPrintTime(post.value['dateAndTime'][3:5])
                   %>
                   <div class="col3 postOverviewDate">${date}, ${time} Uhr</div>
                   <div class="col2 postOverviewDate">${post.value['username']}</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor
<!--/-->       </section> <!-- / POSTING -->

