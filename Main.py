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
from Servlet.Visitor import AbstractVisitor

from mako.template import Template
from mako.lookup import TemplateLookup

import Servlet.site_cfg as cfg


class Main(object):
    """
    Starts the CherryPy Server with
    $ python Main.py
    """
    def __init__(self):
        # Other Classes to expose.
        self.user = User()
        self.post = Post()

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
    def register(self, secret=""):
        myVisitor = User()
        if secret == "noxo2011":
            User.secretTextAnswerd = True
            return myVisitor.register(True)
        else:
            User.secretTextAnswerd = False
            return myVisitor.register(False)

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

    @expose()
    def fehler(self, err):
        errMsg = { '1': "Passwort oder Name fehlen!",
            '2': "Die Session zu ereugen, schlug fehl!",
            '3': "Einen neuen Character zu erstellen schlug fehl!",
            '4': "Du bist nicht eingeloggt.",
            '5': u"Dafür brauchst du Adminrechte!! Verdammt noch eins!",
            '6': u"Du brauchst dafür das Geheimnis!",
            '7': u"Die Passwörter waren leider nicht identisch!",
            '8': u"Der neue Benutzer konnte leider nicht erfolgreich angelegt werden. Frag mal einem Admin, was los ist. :(",
            '9': "Anmeldung zum Raid schlug fehl. :(",
            '10': "Die Nachricht zu schreiben schlug fehl.",
            '11': "Diesen Beitrag gibt es offenbar  nicht!" }
        try:
            errMsg = errMsg[err]
        except:
            errMsg = "Keine solche Error-Nachricht hinterlegt."
        myVisitor = AbstractVisitor()
        return myVisitor.errorPage(errMsg)

    @expose()
    def avatar(self, username):
        """gets the avatar of the user and returns only the picture"""
        if username == "Themerius":
            f = open('avatar.png', 'r')
        else:
            f = open('avatar-default.png', 'r')
        cherrypy.response.headers['Content-Type'] = 'image/png'
        return f.read()


# Load Config File
import os.path
serverConf = os.path.join( os.path.dirname(__file__),
                           'Servlet/server.conf' )

# Run the CherryPy-Servlet
cherrypy.quickstart( Main(),
                     config=serverConf )
