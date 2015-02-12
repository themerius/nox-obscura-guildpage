# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Visitor import AbstractVisitor
from Servlet.Database.Post import DataPost

from mako.template import Template
from cherrypy import expose
import cherrypy

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

    def prettyPrintDate(self, x):
        return unicode(x[2]) + "." + unicode(x[1]) + "." + unicode(x[0])

    def prettyPrintTime(self, x):
        if x[0] in range(0, 9):
            hour = "0" + unicode(x[0])
        else:
            hour = unicode(x[0])
        if x[1] in range(0, 9):
            minute = "0" + unicode(x[1])
        else:
            minute = unicode(x[1])
        return hour + ":" + minute

    @expose()
    def view(self, _id):
        self.__init__()
        data = DataPost()
        post_ = data.getPost(_id)
        if post_:
            myTmpl = Template(
                    """<%include file="header.mako"/>
                       <%include file="menu.mako"/>
                       <%include file="content_head.mako"/>
                       <%include file="post.mako"/>
                       <%include file="post_comment.mako"/>
                       <%include file="content_foot.mako"/>
                       <%include file="footer.mako"/>""",
                    lookup=self.templateLookup)
            output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath,
            post=post_,
            comments=data.getCommentsForPost(_id),
            prettyPrintDate=self.prettyPrintDate,
            prettyPrintTime=self.prettyPrintTime,
            postId=_id)
            if post_['category'] == 'forum' or post_['category'] == 'archiv':
                if self.anonymous:
                    raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                        "/fehler?err=4", 303)
                else:
                    return output
            else:
                return output
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                        "/fehler?err=11", 303)
        return output

    @expose()
    def new(self, category, title, postId, content):
        self.__init__()
        if self.anonymous:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=4", 303)
        data = DataPost()
        newOk = data.createNewPost(postId, title, content, self.username, self.calculateToday(), category)
        if newOk:
            # send E-Mail
            message = Template("<%include file='email_new_post.mako'/>",
                lookup=self.templateLookup)
            message = message.render(
                cfg_siteUrl=self.cfg.cfg_siteUrl,
                title_=title,
                postId_=postId)
            subject = "Neue Nachricht: "+title
            self.sendMailToAllSubscribers("post", message, subject)
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/post/view/"+postId, 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=10", 303)

    @expose()
    def newComment(self, postId, content):
        self.__init__()
        if self.anonymous:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=4", 303)
        data = DataPost()
        newCom = data.createNewComment(self.username, self.calculateToday(), postId, content)
        if newCom:
            # send E-Mail
            message = Template("<%include file='email_new_comment.mako'/>",
                lookup=self.templateLookup)
            message = message.render(
                cfg_siteUrl=self.cfg.cfg_siteUrl,
                username_=self.username,
                postId_=postId,
                content_=content)
            subject = "Neuer Kommentar von "+self.username
            self.sendMailToAllSubscribers("post", message, subject)
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/post/view/"+postId, 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=10", 303)

    def startPage(self):
        category_ = "start"
        data = DataPost()
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="post_latest.mako"/>
               <%include file="static_page_guildinfo.mako"/>
               <%include file="post_overview.mako"/>
               <%include file="post_new.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath,
            postLatest=data.getLatestPost("start"),
            postList=data.getPostList(category_),
            getCommentCount=data.getCommentCount,
            prettyPrintDate=self.prettyPrintDate,
            prettyPrintTime=self.prettyPrintTime,
            category=category_)
        return output

    def raid(self):
        category_ = "raid"
        data = DataPost()
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
            title="Nox Obscura: Raids",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath,
            postList=data.getPostList(category_),
            getCommentCount=data.getCommentCount,
            prettyPrintDate=self.prettyPrintDate,
            prettyPrintTime=self.prettyPrintTime,
            category=category_)
        return output

    def forum(self):
        category_ = "forum"
        data = DataPost()
        myTmpl = Template(
            u"""<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <h2>Anmerkung</h2>
               <p>Das Forum ist <em>nicht</em> öffentlich zugänglich.</p>
               % if not anonymous:
               <%include file="post_overview.mako"/>
               % endif
               <%include file="post_new.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Forum",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath,
            postList=data.getPostList(category_),
            getCommentCount=data.getCommentCount,
            prettyPrintDate=self.prettyPrintDate,
            prettyPrintTime=self.prettyPrintTime,
            category=category_)
        return output

    def archiv(self):
        category_ = "archiv"
        data = DataPost()
        myTmpl = Template(
            u"""<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <h2>Anmerkung</h2>
               <p>Hier werden alle Themen archiviert, die nicht mehr
               zeitgemäß sind. Das Archiv ist <em>nicht</em> öffentlich
               zugänglich.</p>
               % if not anonymous:
               <%include file="post_overview.mako"/>
               % endif
               <%include file="post_new.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Archiv",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath,
            postList=data.getPostList(category_),
            getCommentCount=data.getCommentCount,
            prettyPrintDate=self.prettyPrintDate,
            prettyPrintTime=self.prettyPrintTime,
            category=category_)
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
            title="Nox Obscura: Bewerbung",
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output





#Noch genauer überlegen, welche Funktionen hier her müssen und welche wie dargestellt werden sollen nach außen... post/get, formulare, anzeige, postübersicht für jede kategorie etc.
