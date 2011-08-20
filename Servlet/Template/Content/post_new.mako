<%doc>
   required:
     varName: varType
</%doc>
<%include file="content_head.mako"/>
<!-- -->       <section id="newPostSection"> <!-- NEW POST -->
               <div class="row">
                  <h2>Neuen Beitrag erstellen</h2>
               </div>
               
               <form action="user/post?type=initial" method="post" onsubmit="myEditor.post()"> 
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col5">
                       <strong>Thema</strong>
                       <input type="hidden" name="category" value="start"/> 
                       <input class="text" type="text" name="topic" value="" maxlength="40"/>
                   </div>
                   <div class="col6 postNewPostAdjust"><em>Pflichtfeld</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <br />
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col5">
                       <strong>Kurzbeschreibung</strong>
                       <input class="text" type="text" name="uuid" value="4ef97" size="25" maxlength="40"/> 
                   </div>
                   <div class="col6 postNewPostAdjust"><em>Bitte keine Leer- oder Sonderzeichen. Dient auch als URI! Falls dir nicht einfällt, lass das Feld wie es ist.</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <br />
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col7">
                       <strong>Inhalt</strong>
                       <textarea name="content" id="input"><div>Dein Text!</div></textarea> 
                              <script type="text/javascript"> 
                              new TINY.editor.edit('myEditor',{
                                 id:'input',
                                 width:556,
                                 height:275,
                                 cssclass:'te',
                                 controlclass:'tecontrol',
                                 rowclass:'teheader',
                                 dividerclass:'tedivider',
                                 controls:['bold','italic','underline','strikethrough','|','subscript','superscript','|',
                                         'orderedlist','unorderedlist','|','outdent','indent','|','leftalign',
                                         'centeralign','rightalign','blockjustify','|','unformat','|','undo','redo','n',
                                         'size','style','|','image','hr','link','unlink','|','cut','copy','paste','print'],
                                 footer:true,
                                 fonts:['Verdana','Arial','Georgia','Trebuchet MS'],
                                 xhtml:true,
                                 cssfile:'static/tinyeditor/style.css',
                                 bodyid:'editor',
                                 footerclass:'tefooter',
                                 toggle:{text:'source',activetext:'wysiwyg',cssclass:'toggle'},
                                 resize:{cssclass:'resize'}
                              });
                              </script> 
                   </div>
                   <div class="col4 postNewPostAdjust"><em>Bitte formatiere deinen Text, das ist wichtig für die Lesbarkeit und die Übersichtlichkeit. Mache von den Überschriften, Hervorhebungen und Listen gebrauch — zumindest bei längeren Texten!</em></div>
                   <div class="row-end">&nbsp;</div>
               </div>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col7">
                       <br />
                       <input type="submit" value="Veröffentlichen"/>
                       <input type="reset" value="Verwerfen"/>
                   </div>
                   <div class="col4">&nbsp;</div>
                   <div class="row-end">&nbsp;</div>
               </div>
               </form>
<!--/-->       </section> <!-- / NEW POST -->
<%include file="content_foot.mako"/>

