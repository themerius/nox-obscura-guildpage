<%doc>
   required:
      cfg_siteUrl: unicode
      anonymous: bool
</%doc>
   <div id="wrapper">
      <nav>
         <a href="${cfg_siteUrl}" 
            class="big primary capitals negative button">
            <span class="home icon"></span>Start</a>
         <a href="${cfg_siteUrl}/raid"
            class="big primary capitals negative button">
            <span class="check icon"></span>Raid</a>
         <a href="${cfg_siteUrl}/raidplaner"
            class="big primary capitals negative button">
            <span class="calendar icon"></span>Planer</a>
         % if anonymous:
         <a href="${cfg_siteUrl}/login"
            class="big primary capitals negative button">
            <span class="user icon"></span>Anmeldung</a>
         % else:
         <a href="${cfg_siteUrl}/controlpanel"
            class="big primary capitals negative button">
            <span class="user icon"></span>Kontrollzentrum</a>
         % endif
         <a href="${cfg_siteUrl}/bewerbung"
            class="big primary capitals negative button">
            <span class="pen icon"></span>Bewerbung</a>
         <a href="${cfg_siteUrl}/forum"
            class="big primary capitals negative button">
            <span class="lock icon"></span>Forum</a>
         <a href="${cfg_siteUrl}/archiv"
            class="big primary capitals negative button">
            <span class="book icon"></span>Archiv</a>
      </nav>
      
      <div id="pushDown"></div>

