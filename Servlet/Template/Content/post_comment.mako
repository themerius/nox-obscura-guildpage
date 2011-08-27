<%doc>
   required:
     postId: string (id)
     anonymous: bool
</%doc>
% if not anonymous:
<!-- -->       <section id="newReplySection"> <!-- NEW REPLY COMMENT -->
               <div class="row">
                  <h2>Kommentar abgeben</h2>
               </div>
               
               <form action="../../post/newComment" method="post" onsubmit="myEditor.post()"> 
               <input type="hidden" name="postId" value="${postId}"/>
               <div class="row">
                   <div class="col1">&nbsp;</div>
                   <div class="col7">
                       <textarea name="content" id="input">Dein Text!</textarea> 
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
                   <div class="col4"><em>Bitte formatiere deinen Text, das ist wichtig für die Lesbarkeit und die Übersichtlichkeit. Mache von den Überschriften, Hervorhebungen und Listen gebrauch — zumindest bei längeren Texten!</em></div>
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
<!--/-->       </section> <!-- / NEW REPLY COMMENT -->
% endif
