<%doc>
   required:
     usernamesAndPoints: [<Row0 key=dkpPoints, values={'username':, 'charList': [ {'name':,'class',...}, ...}>, ...]
     toCssAttr(x): def
</%doc>
<!-- -->       <section id="pointsSection"> <!-- POINTS -->
               <div class="row">
                  <h2>Punkte Übersicht</h2>
               </div>

               <form action="user/manipulatePoints" method="post">
               <div class="row">
                   <div class="col3"><h3>Mitglied</h3></div>
                   <div class="col6"><h3>Charaktere</h3></div>
                   <div class="col2 pointsRight"><h3>⇣ Punkte</h3></div>
                   <div class="col1"><h3>Delta</h3></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <hr />
               % for usernameAndPoints in usernamesAndPoints:
               <div class="row pointsStretch">
                   <div class="col2">${usernameAndPoints.value['username']}</div>
                   <div class="col7">
                       % for char in usernameAndPoints.value['charList']:
                       <% css = toCssAttr(char['class']) %>
                       <span class="${css}">${char['name']}</span>
                       % endfor
                   </div>
                   <div class="col2 pointsRight"><strong>${usernameAndPoints.key}</strong></div>
                   % if admin:
                   <div class="col1">
                     <input type="text" name="points" value="0" size="4" maxlength="4"/>
                     <input type="hidden" name="username" value="${usernameAndPoints.value['username']}"/>
                   </div>
                   % endif
                   <div class="row-end">&nbsp;</div>
               </div>
               <hr />
               % endfor
               <p><input type="submit" value="Bestätigen"/></p>
<!--/-->       </section> <!-- / POINTS -->

