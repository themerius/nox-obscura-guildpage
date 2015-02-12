<%doc>
   required:
     userInfo: {'_id': '', 'admin': False, 'characterList': [], 
                'dkp': 0, 'email': '', 'realname': '', 'session': ''}
     admin: bool
</%doc>
<!-- -->       <section id="controlpanelSection"> <!-- CONTROLPANEL -->
               <div class="row">
                  <h2>Verwaltung</h2>
               </div>
               
               <div class="row">
                  <h3>Willkommen Noxianer!</h3>
                     <p>Du bist momentan mit der Session ${userInfo['session']} angemeldet. Die Session ist ab dem Zeitpunkt des Logins 60 Minuten gültig. Änderungen dieses Intervalls bzw. eine manuelle Logout-Funktion werden noch realisiert.</p>
                  <h3>Deine Daten</h3>
                     <p>Solltest du den Wunsch haben, deine Daten zu ändern, wende dich an eine Person im Impressum. Passwortänderungen sind über diesen Weg auch möglich, noch ist keine Passwort-Änderungsfunktion bzw. Passwort-Wiederherstellungsfunktion realisiert.</p>
               </div>

               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Nutzername</div>
                   <div class="col3"><strong>${userInfo['_id']}</strong></div>
                   <div class="col5">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">E-Mail-Adresse</div>
                   <div class="col3"><strong>${userInfo['email']}</strong></div>
                   <div class="col5">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Punktestand</div>
                   <div class="col3"><strong>${userInfo['dkp']}</strong></div>
                   <div class="col5">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               
               <h3>Deine Charaktere</h3>
               <% count = 0 %>
               % for char in userInfo['characterList']:
               <% count += 1 %>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col1">${count}</div>
                   <div class="col2"><strong>${char['name']}</strong></div>
                   <div class="col3">ein ${char['race']} <em>${char['class']}</em></div>
                   <div class="col3">mit der Primärrolle als <em>${char['role']}</em></div>
                   <div class="col2">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor
               <br />
               <form action="user/addCharacter" method="post">
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col2">Name: <input class="text" type="text" name="charname" value="" maxlength="12"/></div>
                   <div class="col2">Klasse: 
                       <select name="class_" size="1"> 
                           <option>Paladin</option> 
                           <option>Magier</option> 
                           <option>Druide</option> 
                           <option>Priester</option> 
                           <option>Krieger</option> 
                           <option>Schamane</option> 
                           <option>Schurke</option> 
                           <option>Todesritter</option> 
                           <option>Hexenmeister</option> 
                           <option>Jäger</option> 
                       </select>
                   </div>
                   <div class="col2">
                       Rasse: 
                       <select name="race" size="1"> 
                           <option>Draenei</option> 
                           <option>Mensch</option> 
                           <option>Nachtelf</option> 
                           <option>Zwerg</option> 
                           <option>Gnom</option> 
                           <option>Worg</option> 
                       </select>
                   </div>
                   <div class="col2">
                       Primärrolle: 
                       <select name="role" size="1"> 
                           <option>Tank</option> 
                           <option>Heiler</option> 
                           <option>DPS</option> 
                       </select>
                   </div>
                   <div class="col3"></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col8"><input  class="button" type="submit" value="Hinzufügen"/></div>
                   <div class="col3">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               </form>
               % if admin:
               <div class="row">
                  <h3>Adminrechte</h3>
                  <h4>Neue Raidtermine anlegen</h4>
               </div>
               
               <form action="user/createRaid" method="post">
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col2"><strong>Name</strong></div>
                   <div class="col3">
                       <input type="text" name="raidName" value="" size="25" maxlength="40"/>
                   </div>
                   <div class="col6">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col2"><strong>Zeitpunkt</strong></div>
                   <div class="col3">
                       <input type="text" name="date" value="19" size="2" maxlength="2"/> : <input type="text" name="date" value="15" size="2" maxlength="2"/> Uhr
                   </div>
                   <div class="col6">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col2"><strong>am</strong></div>
                   <div class="col5">
                       <%
                           import time
                           t = time.localtime()
                       %>
                       <input type="text" name="date" value="" size="2" maxlength="2"/> (Tag) <input type="text" name="date" value="${t.tm_mon}" size="2" maxlength="2"/> (Monat) <input type="text" name="date" value="${t.tm_year}" size="4" maxlength="4"/> (Jahr)
                   </div>
                   <div class="col4">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col2">&nbsp;</div>
                   <div class="col3"><input class="button" type="submit" value="Hinzufügen"/></div>
                   <div class="col6">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               </form>
               % endif
<!--/-->       </section> <!-- / CONTROLPANEL -->

