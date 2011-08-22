# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Visitor import AbstractVisitor

from mako.template import Template
from cherrypy import expose

class User(AbstractVisitor):
    """
    Enables the Visitor to Login,
    show the User specific Controlpanel,
    writes the Auth-Cookies.
    """

    def __init__(self):
        # Do inheritance Stuff:
        AbstractVisitor.__init__(self)
        # Own Stuff:
        import random
        self.r = unicode(random.random())

    def login(self):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="login.mako"/>
               <%include file="content_foot.mako/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Login",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

    def controlpanel(self):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="controlpanel.mako"/>
               <%include file="content_foot.mako/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Login",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output


    @expose()
    def test(self):
        self.__init__()
        return self.r

    def doLogin(self):
        return 0

    def doLogout(self):
        return 0

    def writeCookie(self):
        return 0

    def controlpanel(self):
        return 0
