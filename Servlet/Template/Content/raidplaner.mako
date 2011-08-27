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
            'charName':"Thyphon", 'comment':"Comment", 
            'raidId': "eventX", 'username': "Logonname"}>, <Row ...>]
     getFormularInfos(day): {'state': 'signed', 'charNames': ['Char1', ..], 'raidId': '..', 'comment': '..'}
     cfg_siteUrl: string
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
                   <% members = membersForDay(logon, day) %>
                   % if members:
                   <div class="col2 ${logon}">
                   % else:
                   <div class="col2">&nbsp;
                   % endif
                       % for member in members:
                       <p class="${member.value['class']}">
                           <span class="${member.value['role']}"></span>
                           ${member.value['charName']}
                           % if admin:
                           <br />
                           <a class="adminConfirmed" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/confirmed">⚑</a>
                           <a class="adminSigned" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/signed">⚑</a>
                           <a class="adminSubstitude" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/substitude">⚑</a>
                           <a class="adminOptout" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/optout">⚑</a>
                           % endif
                           <span class="comment">${member.value['comment']}</span>
                       </p>
                       % endfor
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor

   <!-- -->    <section class="formularSection"> <!-- FORMULARS -->
               <div class="row">
                   % for day in theFirstSixDays:
                   <% formularInfos = getFormularInfos(day) %>
                   % if formularInfos['raidId'] != '':
                   <div class="col2">
                       <form action="user/newOrChangeRaidLogon" method="post"> 
                       <p>
                       <select name="usersCharacter" size="1">
                           % for char in formularInfos['charNames']:
                           <option>${char}</option>
                           % endfor
                       </select>
                       </p>
                       <p> 
                       <input type="radio" name="logon" value="signed"
                        % if formularInfos['state'] == 'signed':
                        checked="checked"
                        % endif
                        /> Anmelden<br/> 
                       <input type="radio" name="logon" value="substitude"
                        % if formularInfos['state'] == 'substitude':
                        checked="checked"
                        % endif
                        /> Ersatzbank<br/> 
                       <input type="radio" name="logon" value="optout"
                        % if formularInfos['state'] == 'optout':
                        checked="checked"
                        % endif
                        /> Abmelden<br/> 
                       <input type="hidden" name="raidId" value="${formularInfos['raidId']}"/>
                       </p>
                       <p>Kommentar<br/>
                       <input class="text" type="text" name="comment" value="${formularInfos['comment']}" maxlength="140"/> 
                       </p>
                       <p><input class="button" type="submit" value="Bestätigen"/></p>
                       </form>
                  </div>
                  % else:
                  <div class="col2">&nbsp;</div>
                  % endif
                  % endfor
                  <div class="row-end">&nbsp;</div>
               </div>
   <!--/-->    </section> <!-- / FORMULARS -->


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
                   <% members = membersForDay(logon, day) %>
                   % if members:
                   <div class="col2 ${logon}">
                   % else:
                   <div class="col2">&nbsp;
                   % endif
                       % for member in members:
                       <p class="${member.value['class']}">
                           <span class="${member.value['role']}"></span>
                           ${member.value['charName']}
                           % if admin:
                           <br />
                           <a class="adminConfirmed" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/confirmed">⚑</a>
                           <a class="adminSigned" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/signed">⚑</a>
                           <a class="adminSubstitude" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/substitude">⚑</a>
                           <a class="adminOptout" href="${cfg_siteUrl}/user/setLogon/${member.value['raidId']}/${member.value['username']}/optout">⚑</a>
                           % endif
                           <span class="comment">${member.value['comment']}</span>
                       </p>
                       % endfor
                   </div>
                   % endfor
                   <div class="row-end">&nbsp;</div>
               </div>
               % endfor

   <!-- -->    <section class="formularSection"> <!-- FORMULARS -->
               <div class="row">
                   % for day in theSecondSixDays:
                   <% formularInfos = getFormularInfos(day) %>
                   % if formularInfos['raidId'] != '':
                   <div class="col2">
                       <form action="user/newOrChangeRaidLogon" method="post"> 
                       <p>
                       <select name="usersCharacter" size="1">
                           % for char in formularInfos['charNames']:
                           <option>${char}</option>
                           % endfor
                       </select>
                       </p>
                       <p> 
                       <input type="radio" name="logon" value="signed"
                        % if formularInfos['state'] == 'signed':
                        checked="checked"
                        % endif
                        /> Anmelden<br/> 
                       <input type="radio" name="logon" value="substitude"
                        % if formularInfos['state'] == 'substitude':
                        checked="checked"
                        % endif
                        /> Ersatzbank<br/> 
                       <input type="radio" name="logon" value="optout"
                        % if formularInfos['state'] == 'optout':
                        checked="checked"
                        % endif
                        /> Abmelden<br/> 
                       <input type="hidden" name="raidId" value="${formularInfos['raidId']}"/>
                       </p>
                       <p>Kommentar<br/>
                       <input class="text" type="text" name="comment" value="${formularInfos['comment']}" maxlength="140"/> 
                       </p>
                       <p><input class="button" type="submit" value="Bestätigen"/></p>
                       </form>
                  </div>
                  % else:
                  <div class="col2">&nbsp;</div>
                  % endif
                  % endfor
                  <div class="row-end">&nbsp;</div>
               </div>
   <!--/-->    </section> <!-- / FORMULARS -->

