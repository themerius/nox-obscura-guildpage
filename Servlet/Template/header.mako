<%doc>
   required:
      cfg_staticPath: unicode
      title: unicode
</%doc>
<!DOCTYPE html>
<html lang="de">

<head>
   <meta charset="utf-8" />
   
   <title>${title}</title>
   
   <!-- Meta Information -->
   <meta name="description" content="" />
   <meta name="author" content="Sven Hodapp" />
   <meta name="viewport" content="width=device-width; initial-scale=1.0" />
   
   <!-- Style Sheets -->
   <link rel="stylesheet" href="${cfg_staticPath}/styleMain.css" 
         media="screen" />
   <link rel="stylesheet" 
         href="${cfg_staticPath}/css3buttons/stylesheets/css3buttons.css"
         media="screen" />
   <link rel="stylesheet" href="${cfg_staticPath}/978.css"
         media="screen" />
   
   <!-- Tiny Editor -->
   <script src="${cfg_staticPath}/tinyeditor/tinyeditor.js"></script>
   <link rel="stylesheet"
         href="${cfg_staticPath}/tinyeditor/style.css"
         media="all" />
   
   <!-- Favicon -->
   <link rel="shortcut icon" 
         href="/favicon.ico" />

   <!-- Analytics by Google Analytics -->
   <script type="text/javascript">

     var _gaq = _gaq || [];
     _gaq.push(['_setAccount', 'UA-28739723-1']);
     _gaq.push(['_trackPageview']);

     (function() {
       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
     })();

   </script>
</head>

<body>
   <header>
      <h1>Nox Obscura</h1>
      <p>Eine World of Warcraft Gilde auf Nera'Thor</p>
   </header>

