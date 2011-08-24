<%doc>
   required:
     theFirstSixDays: [ [2011,8,23], ...]
     theFirstSixDaysPrettyPrinted: [ "23.8.2011", ...]
     theSecondSixDays: ..
     theSecondSixDaysPrettyPrinted: ...
     getNameAndTimeForRaid(day): [ "MyName", "19:15" ]
     admin: bool
     membersForDay(day):
         [<Row ... value={'class':"priest", 'role':"roleHeal", 
            'charName':"Thyphon", 'comment':"Comment"}>, <Row ...>]
</%doc>
<!-- -->       <section id="raidplanerSection"> <!-- RAIDPLANER -->
               <div class="row">
                  <h2>Raidplaner</h2>
               </div>
<!-- Date, FirstSixDays -->
               <div class="row">
                   % for day in theFirstSixDaysPrettyPrinted:
                   <div class="col2">${day}</div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
   <!-- Name and Date -->
               <div class="row">
                   % for day in theFirstSixDays:
                   <% nameAndDate = getNameAndTimeForRaid(day) %>
                   <div class="col2">
                     <strong>${nameAndDate[0]}</strong><br/>
                     <em>${nameAndDate[1]} 
                     % if nameAndDate[1] is not "":
                        Uhr
                     % endif
                     </em>
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
   <!-- Logons -->
               <%
                  logons = ["confirmed", "signed", "substitude", "optout"]
               %>
               % for logon in logons:
               <div class="row">
                   % for day in theFirstSixDays:
                   <div class="col2 ${logon}">
                       % for member in membersForDay(logon, day):
                       <p class="${member.value['class']}">
                           <span class="${member.value['role']}"></span>
                           ${member.value['charName']}
                           % if admin:
                           <a class="adminConfirmed" href="#">⚑ </a>
                           <a class="adminSigned" href="#">⚑ </a>
                           <a class="adminSubstitude" href="#">⚑ </a>
                           <a class="adminOptout" href="#">⚑ </a>
                           % endif
                           <span class="comment">${member.value['comment']}</span>
                       </p>
                      % endfor
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor
<!-- Date, SecondSixDays -->
               <div class="row">
                   % for day in theSecondSixDaysPrettyPrinted:
                   <div class="col2">${day}</div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
   <!-- Name and Date -->
               <div class="row">
                   % for day in theSecondSixDays:
                   <% nameAndDate = getNameAndTimeForRaid(day) %>
                   <div class="col2">
                     <strong>${nameAndDate[0]}</strong><br/>
                     <em>${nameAndDate[1]} 
                     % if nameAndDate[1] is not "":
                        Uhr
                     % endif
                     </em>
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>

   <!-- Logons -->
               <%
                  logons = ["confirmed", "signed", "substitude", "optout"]
               %>
               % for logon in logons:
               <div class="row">
                   % for day in theSecondSixDays:
                   <div class="col2 ${logon}">
                       % for member in membersForDay(logon, day):
                       <p class="${member.value['class']}">
                           <span class="${member.value['role']}"></span>
                           ${member.value['charName']}
                           % if admin:
                           <a class="adminConfirmed" href="#">⚑ </a>
                           <a class="adminSigned" href="#">⚑ </a>
                           <a class="adminSubstitude" href="#">⚑ </a>
                           <a class="adminOptout" href="#">⚑ </a>
                           % endif
                           <span class="comment">${member.value['comment']}</span>
                       </p>
                      % endfor
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor

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

