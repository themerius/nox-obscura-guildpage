<%doc>
   required:
     varName: varType
</%doc>
<!-- -->       <section id="raidplanerSection"> <!-- RAIDPLANER -->
               <div class="row">
                  <h2>Raidplaner</h2>
               </div>

               <div class="row">
                   <div class="col2">2.8.2011</div>
                   <div class="col2">3.8.2001</div>
                   <div class="col2">4.8.2001</div>
                   <div class="col2">5.8.2001</div>
                   <div class="col2">5.8.2001</div>
                   <div class="col2">5.8.2001</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col2 confirmed">
                       <p class="priest">
                           <span class="roleHeal"></span>
                           Thyphôn
                           <span class="comment"></span>
                       </p>
                       <p class="mage">
                           <span class="roleDps"></span>
                           Nisaqui
                           <span class="comment"></span>
                       </p>
                       <p class="warlock">
                           <span class="roleDps"></span>
                           Blutgier<span class="comment"></span>
                       </p>
                       <p class="paladin">
                           <span class="roleHeal"></span>
                           Lêóníx
                           <span class="comment"></span>
                       </p>
                       <p class="deathknight">
                           <span class="roleDps"></span>
                           Arben
                           <span class="comment"></span>
                       </p>
                       <p class="paladin">
                           <span class="roleTank"></span>
                           Dhraha
                           <span class="comment"></span>
                       </p>
                       <p class="shaman">
                           <span class="roleHeal"></span>
                           Lightbeard<span class="comment"></span>
                       </p>
                       <p class="warrior">
                           <span class="roleDps"></span>
                           Nimmrod
                           <span class="comment"></span>
                       </p>
                       <p class="hunter">
                           <span class="roleDps"></span>
                           Thorin
                           <span class="comment">aber evtl Ping zu hoch (nicht daheim)</span>
                       </p>
                   </div>
                   <div class="col2">x</div>
                   <div class="col2">y</div>
                   <div class="col2">z</div>
                   <div class="col2 confirmed"><p class="priest"><span class="roleHeal"></span>Thyphôn<span class="comment">Mein Kommentar kann so lang sein!</span></p></div>
                   <div class="col2">b</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col2 signed">
                       <p class="priest">
                           <span class="roleHeal"></span>
                           Thyphôn
                           <span class="comment"></span>
                       </p>
                       <p class="mage">
                           <span class="roleDps"></span>
                           Nisaqui
                           <span class="comment"></span>
                       </p>
                       <p class="warlock">
                           <span class="roleDps"></span>
                           Blutgier<span class="comment"></span>
                       </p>
                       <p class="paladin">
                           <span class="roleHeal"></span>
                           Lêóníx
                           <span class="comment"></span>
                       </p>
                       <p class="deathknight">
                           <span class="roleDps"></span>
                           Arben
                           <span class="comment"></span>
                       </p>
                       <p class="paladin">
                           <span class="roleTank"></span>
                           Dhraha
                           <span class="comment"></span>
                       </p>
                       <p class="shaman">
                           <span class="roleHeal"></span>
                           Lightbeard<span class="comment"></span>
                       </p>
                       <p class="warrior">
                           <span class="roleDps"></span>
                           Nimmrod
                           <span class="comment"></span>
                       </p>
                       <p class="hunter">
                           <span class="roleDps"></span>
                           Thorin
                           <span class="comment">aber evtl Ping zu hoch (nicht daheim)</span>
                       </p>
                   </div>
                   <div class="col2">x</div>
                   <div class="col2">y</div>
                   <div class="col2">z</div>
                   <div class="col2 signed">
                       <p class="priest">
                           <span class="roleHeal"></span>
                           Thyphôn
                           <span class="comment"></span>
                       </p>
                   </div>
                   <div class="col2">b</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col2">c</div>
                   <div class="col2">x</div>
                   <div class="col2">y</div>
                   <div class="col2">z</div>
                   <div class="col2 substitude">
                       <p class="priest">
                           <span class="roleHeal"></span>
                           Spriest <br />
                           <a class="adminConfirmed" href="#">⚑ </a>
                           <a class="adminSigned" href="#">⚑ </a>
                           <a class="adminSubstitude" href="#">⚑ </a>
                           <a class="adminOptout" href="#">⚑ </a>
                           <span class="comment">Und mein mehrzeiliger Kommentar.</span>
                       </p>
                   </div>
                   <div class="col2">b</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col2">c</div>
                   <div class="col2">x</div>
                   <div class="col2">y</div>
                   <div class="col2">z</div>
                   <div class="col2 optout">
                       <p class="priest">
                           <span class="roleHeal"></span>
                           Test
                           <span class="comment"></span>
                       </p>
                   </div>
                   <div class="col2">b</div>
                   <div class="row-end">&nbsp;</div>
               </div>
<!--/-->       </section> <!-- / RAIDPLANER -->


<!-- -->       <section id="formularSection"> <!-- FORMULARS -->
               <div class="row">
                  <h2>Raidplaner</h2>
               </div>

               <div class="row">
                   <div class="col2">
                       <form action="user/manipulateUserCharacterOnRaid" method="post"> 
                       <p>
                       <select name="usersCharacter2" size="1">
                           <option>Dhraha</option>
                           <option>Themerius</option>
                           <option>Quis</option>
                       </select>
                       </p>
                       <p> 
                       <input type="radio" name="logon2" value="signed" checked="checked" /> Anmelden<br/> 
                       <input type="radio" name="logon2" value="substitude" /> Ersatzbank<br/> 
                       <input type="radio" name="logon2" value="optout" /> Abmelden<br/> 
                       <input type="hidden" name="id_2" value="48"/>
                       </p>
                       <p>Kommentar<br/>
                       <input class="text" type="text" name="comment2" value="" maxlength="40"/> 
                       </p>
                       <p><input class="button" type="submit" value="Bestätigen"/></p>
                       </form>
                   </div>
                   <div class="col10"></div>
                   <div class="row-end">&nbsp;</div>
               </div>
<!--/-->       </section> <!-- / FORMULARS -->

