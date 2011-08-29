<%doc>
   required:
     postLatest: {'title':, 'content':, 'username':, 
                  'dateAndTime': [2011, 8, 27, 18,32], 'category':}
     prettyPrintDate(x)
     prettyPrintTime(x)
     cfg_siteUrl: string
</%doc>
<!-- -->       <section id="beitragSection"> <!-- BEITRAG -->
                <div class="row">
                   <h2>${postLatest.value['title']}</h2>
                </div>

                <div class="row">
                   <div class="col1"><img class="avatar" src="img/avatar.png" /></div>
                   <div class="col3 postInfoName">${postLatest.value['username']}</div>
                   <div class="col4">&nbsp;</div>
                   <%
                      date = prettyPrintDate(postLatest.value['dateAndTime'][0:3])
                      time = prettyPrintTime(postLatest.value['dateAndTime'][3:5])
                   %>
                   <div class="col4 postInfoDate"><em>verfasst am ${date} um ${time} Uhr</em></div>
                   <div class="row-end">&nbsp;</div>
                </div>

                <div class="row">
                   <p>
                   ${postLatest.value['content']}
                   </p>
                </div>
                <p>
                  Zu den <a href="${cfg_siteUrl}/post/view/${postLatest.value['_id']}">Kommentaren</a>.
                </p>
                <hr />
<!--/-->       </section> <!-- / BEITRAG -->
