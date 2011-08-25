<%doc>
   required:
     varName: varType
</%doc>
<!-- -->       <section id="registerSection"> <!-- REGISTER -->
               <div class="row">
                  <h2>Registrierung</h2>
               </div>

               <div class="row">
                   <p>Der Zugansschlüssel ist richtig. Nun darfst du dir einen Benutzer anlegen und deinen zugehörigen Hauptcharakter. Weitere Charaktere kannst du dir später in der Verwaltung anlegen.</p>
                   <p>Wir legen übrigens Wert auf korrekte Angaben. Wir sind eine seriöse Gilde und wollen dementsprechend auch seriöse Mitglieder. Bitte keine Falschangaben über Namen, E-Mail-Adressen, und so weiter!</p>
                   <p>Falls du irgendwann mit World of Warcraft aufhören willst, oder aus einem anderen Grund aus der Gilde scheidest und du somit keine Gilden-betreffenden Informationen mehr erhalten willst bzw. einfach den Benutzer hier löschen möchtest, wende dich an eine im Impressum genannte Person.</p>
               </div>
               <form action="user/regUser" method="post"> 
               <div class="row">
                   <div class="col3"><h3>Benutzer anlegen</h3></div>
                   <div class="col9">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Nutzername</div>
                   <div class="col3"><input class="text" type="text" name="username" value="" size="25" maxlength="40"/></div>
                   <div class="col5"><em>Dies ist unter anderem Dein Login-Name.</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Dein echter Name</div>
                   <div class="col3"><input class="text" type="text" name="realname" value="" size="25" maxlength="40"/></div>
                   <div class="col5"><em>Bitte trage den Vor- und Zunamen ein.</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">E-Mail-Adresse</div>
                   <div class="col3"><input class="text" type="text" name="email" value="" size="25" maxlength="40"/></div>
                   <div class="col5"><em>Am besten die, die du auch bei Battle.net hast.</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Passwort</div>
                   <div class="col3"><input class="text" type="password" name="password" value="" size="25" maxlength="40"/></div>
                   <div class="col5"><em>Wähle ein möglichst sicheres Passwort!</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col3">Passwort wiederholen</div>
                   <div class="col3"><input class="text" type="password" name="password" value="" size="25" maxlength="40"/></div>
                   <div class="col5">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               
               <div class="row">
                   <div class="col3"><h3>Charakter anlegen</h3></div>
                   <div class="col9">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
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
               <br />
               <br />
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col8"><input  class="button" type="submit" value="Erstellen"/></div>
                   <div class="col3">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               </form>
<!--/-->       </section> <!-- / REGISTER -->

