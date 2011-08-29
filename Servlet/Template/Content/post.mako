<%doc>
   required:
     post: {'title':, 'content':, 'username':, 
            'dateAndTime': [2011, 8, 27, 18,32], 'category':}
     comments: [ <Row _id=, key=[postId, dateAndTime], value={'username':, 
                      'dateAndTime':, 'postId':, 'category': 'comment',
                      'content':}>, 
                 <Row ...>, ... ]
     prettyPrintDate(x)
     prettyPrintTime(x)
     cfg_siteUrl: string
</%doc>
<!-- -->       <section id="beitragSection"> <!-- BEITRAG -->
                <div class="row">
                   <h2>${post['title']}</h2>
                </div>

                <div class="row">
                   <div class="col1"><img class="avatar" src="${cfg_siteUrl}/avatar/${post['username']}" /></div>
                   <div class="col3 postInfoName">${post['username']}</div>
                   <div class="col4">&nbsp;</div>
                   <%
                      date = prettyPrintDate(post['dateAndTime'][0:3])
                      time = prettyPrintTime(post['dateAndTime'][3:5])
                   %>
                   <div class="col4 postInfoDate"><em>verfasst am ${date} um ${time} Uhr</em></div>
                   <div class="row-end">&nbsp;</div>
                </div>

                <div class="row">
                   <p>
                   ${post['content']}
                   </p>
                </div>

                <hr />

                % for comment in comments:
                <div class="row">
                 <div class="col1"><img class="avatar" src="${cfg_siteUrl}/avatar/${comment.value['username']}" /></div>
                 <div class="col3 postInfoName">${comment.value['username']}</div>
                 <div class="col4">&nbsp;</div>
                 <%
                      date = prettyPrintDate(comment.value['dateAndTime'][0:3])
                      time = prettyPrintTime(comment.value['dateAndTime'][3:5])
                 %>
                 <div class="col4 postInfoDate"><em>verfasst am ${date} um ${time} Uhr</em></div>
                 <div class="row-end">&nbsp;</div>
                </div>

                <div class="row">
                 <p>
                 ${comment.value['content']}
                 </p>
                </div>

                <hr />
                % endfor
<!--/-->       </section> <!-- / BEITRAG -->
