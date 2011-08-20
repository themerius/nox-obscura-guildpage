<%doc>
   required:
     varName: varType
</%doc>
<%include file="content_head.mako"/>
<!-- -->       <section id="keySection"> <!-- KEY -->
               <div class="row">
                  <h2>Zugangsschlüssel</h2>
               </div>

               <div class="row">
                   <p>Um dich registrieren zu können musst du ersteinmal diesen Zugangsschlüssel wissen, diesen erfährst du entweder durch einen Offizier oder entnimmst ihn einfach der Gildeninformation im Spiel!</p>
               </div>
               <div class="row">
                   <div class="col2">&nbsp;</div>
                   <div class="col8">
                       <form action="register" method="post"> 
                           <input class="secretText" type="text" name="secret" value="" maxlength="40"/>        <p><input class="secretButton" type="submit" value="Lass mich rein"/></p> 
                       </form>
                   </div>
                   <div class="col2">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
<!--/-->       </section> <!-- / KEY -->
<%include file="content_foot.mako"/>

