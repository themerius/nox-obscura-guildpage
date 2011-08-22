# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------#
# Autor:
#   Sven Hodapp
#
# Uses:
#   Python 2.7, CherryPy 3.2, CouchDB 0.11.
#
# Librarys:
#   Mako, ...


# Imports:
import cherrypy
from cherrypy import expose

from Servlet.Visitor.User import User
from Servlet.Visitor.Post import Post
from Servlet.Visitor.Raidplaner import Raidplaner

from mako.template import Template as T
from mako.lookup import TemplateLookup as L

import Servlet.site_cfg as cfg


class Main(object):
    """
    Starts the CherryPy Server with
    $ python Main.py
    """
    def __init__(self):
        # Other Classes to expose.
        self.user = User()

    @expose()
    def index(self):
        myVisitor = Post()
        return myVisitor.startPage()

    @expose()
    def raid(self):
        myVisitor = Post()
        return myVisitor.raid()

    @expose()
    def raidplaner(self):
        myVisitor = Raidplaner()
        return myVisitor.raidplaner()

    @expose()
    def login(self):
        myVisitor = User()
        return myVisitor.login()

    @expose()
    def controlpanel(self):
        myVisitor = User()
        return myVisitor.controlpanel()

    @expose()
    def bewerbung(self):
        myVisitor = Post()
        return myVisitor.bewerbung()

    @expose()
    def forum(self):
        myVisitor = Post()
        return myVisitor.forum()

    @expose()
    def archiv(self):
        myVisitor = Post()
        return myVisitor.archiv()



# Load Config File
import os.path
serverConf = os.path.join( os.path.dirname(__file__),
                           'Servlet/server.conf' )

# Run the CherryPy-Servlet
cherrypy.quickstart( Main(),
                     config=serverConf )
