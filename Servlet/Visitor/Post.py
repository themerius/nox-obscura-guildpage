# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Visitor import AbstractVisitor

from mako.template import Template
from cherrypy import expose

class Post(AbstractVisitor):
    """
    Enables the logged-in Visitor:
        1. to write new Posts,
        2. comment on Posts,
        3. view non-public Posts (only known Visitor),
        4. view public Posts.
    Also sends an E-Mail to all Guild-Members, when a new Post arrives. If
    he/she writes a Comment on a Post, he/she get's every time an Infomail
    when other write following Comments on this Post.
    """

    def __init__(self):
        # Do inheritance Stuff:
        AbstractVisitor.__init__(self)
        # Own Stuff:

    def view(self):
        return 0

    def new(self):
        return 0

    def newCommentOnPost(self):
        return 0

    def sendMail(self):
        return 0

    def startPage(self):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="post_overview.mako"/>
               <%include file="post_new.mako"/>
               <%include file="static_page_guildinfo.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

    def raid(self):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="post_overview.mako"/>
               <%include file="post_new.mako"/>
               <%include file="static_page_raidrules.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

    def forum(self):
        myTmpl = Template(
            u"""<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <h2>Anmerkung</h2>
               <p>Das Forum ist <em>nicht</em> öffentlich zugänglich.</p>
               <%include file="post_overview.mako"/>
               <%include file="post_new.mako"/>
                <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

    def archiv(self):
        myTmpl = Template(
            u"""<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <h2>Anmerkung</h2>
               <p>Hier werden alle Themen archiviert, die nicht mehr
               zeitgemäß sind. Das Archiv ist <em>nicht</em> öffentlich
               zugänglich.</p>
               <%include file="post_overview.mako"/>
               <%include file="post_new.mako"/>
                <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

    def bewerbung(self):
        myTmpl = Template(
            u"""<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="static_page_bewerbung.mako"/>
                <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output





#Noch genauer überlegen, welche Funktionen hier her müssen und welche wie dargestellt werden sollen nach außen... post/get, formulare, anzeige, postübersicht für jede kategorie etc.
