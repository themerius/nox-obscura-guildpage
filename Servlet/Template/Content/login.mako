<%doc>
   required:
     cfg_siteUrl: string
</%doc>
<!-- -->       <section id="login"> <!-- LOGIN -->
               <div class="row">
                  <h2>Anmeldung</h2>
               </div>

               <form action="user/doLogin" method="post">
               <div class="row">
                  <div class="col2">&nbsp;</div>
                       <div class="col8">
                           <h3>Benutzername</h3>
                       </div>
                       <div class="col2">&nbsp;</div>
                       <div class="row-end">&nbsp;</div>
               </div>

               <div class="row">
                  <div class="col2">&nbsp;</div>
                       <div class="col8">
                           <input class="loginText" type="text" name="username" value="" maxlength="40"/>
                       </div>
                       <div class="col2">&nbsp;</div>
                       <div class="row-end">&nbsp;</div>
               </div>

               <div class="row">
                  <div class="col2">&nbsp;</div>
                       <div class="col8">
                           <h3>Passwort</h3>
                       </div>
                       <div class="col2">&nbsp;</div>
                       <div class="row-end">&nbsp;</div>
               </div>

               <div class="row">
                  <div class="col2">&nbsp;</div>
                       <div class="col8">
                           <input class="loginText" type="password" name="password" value="" maxlength="40"/>
                        </div>
                       <div class="col2">&nbsp;</div>
                       <div class="row-end">&nbsp;</div>
               </div>
               <br />
               <div class="row">
                  <div class="col2">&nbsp;</div>
                       <div class="col8">
                           <input class="loginButton" type="submit" value="anmelden!"/>
                        </div>
                       <div class="col2">&nbsp;</div>
                       <div class="row-end">&nbsp;</div>
               </div>
               </form>

               <div class="row">
                  <p>Du hast noch keinen Account und willst Mitglied werden und hast bereits mit uns eine Rücksprache gehalten und kennst somit unseren Zugangsschlüssel, dann kannst du dich <a href='${cfg_siteUrl}/register'>registrieren</a>.</p>
               </div>
<!--/-->       </section> <!-- / LOGIN -->

