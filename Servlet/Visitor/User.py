# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Visitor import AbstractVisitor
from Servlet.Database.User import DataUser
from Servlet.Database.Raid import DataRaid

from mako.template import Template
import cherrypy
from cherrypy import expose

class User(AbstractVisitor):
    """
    Enables the Visitor to Login,
    show the User specific Controlpanel,
    writes the Auth-Cookies.
    @expose()-Functions must (!) recall the Constructor,
    to fetch the Visitors-State (Visitor Name etc.)
    """
    # If someone wants to Register:
    secretTextAnswerd = False

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
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Login",
            cfg_staticPath=self.cfg.cfg_staticPath,
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous)
        return output

    @expose()
    def doLogin(self, username="", password=""):
        if (username == "") or (password == ""):
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=1", 303)
        data = DataUser()
        pwdFromDb = data.retriveUsersPassword(username)
        import hashlib
        password = hashlib.md5(password).hexdigest()
        if password == pwdFromDb:
            from uuid import uuid4
            session = uuid4().hex
            if data.setSessionOfUser(username, session):
                self.writeCookie(username, session)
                raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/controlpanel", 303)
            else:
                raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=2", 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=1", 303)


    def controlpanel(self):
        if self.anonymous:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=4", 303)
        data = DataUser()
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="controlpanel.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Kontrollzentrum",
            cfg_staticPath=self.cfg.cfg_staticPath,
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            userInfo=data.retriveUserInfo(self.username),
            admin=self.privileged)
        return output

    @expose()
    def addCharacter(self, charname, class_, race, role):
        self.__init__()
        if self.anonymous:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=4", 303)
        charInfo = {'name': charname, 'class': class_,
                    'race': race, 'role': role}
        data = DataUser()
        if data.addCharToUser(self.username, charInfo):
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/controlpanel", 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=3", 303)

    @expose()
    def createRaid(self, raidName, date):
        self.__init__()
        if not self.privileged:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=5", 303)
        time = date[0]+':'+date[1]
        date = [ int(date[4]), int(date[3]), int(date[2]) ] # cast to List.
        data = DataRaid()
        data.newRaidEvent(raidName, date, time)
        raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/raidplaner", 303)

    def register(self, secret):
        data = DataUser()
        if secret:
            myTmpl = Template(
                """<%include file="header.mako"/>
                   <%include file="menu.mako"/>
                   <%include file="content_head.mako"/>
                   <%include file="register.mako"/>
                   <%include file="content_foot.mako"/>
                   <%include file="footer.mako"/>""",
                lookup=self.templateLookup)
            output = myTmpl.render_unicode(
                title="Nox Obscura: registrieren",
                cfg_staticPath=self.cfg.cfg_staticPath,
                cfg_siteUrl=self.cfg.cfg_siteUrl,
                anonymous=self.anonymous,
                userInfo=data.retriveUserInfo(self.username),
                admin=self.privileged)
            return output
        else:
            myTmpl = Template(
                """<%include file="header.mako"/>
                   <%include file="menu.mako"/>
                   <%include file="content_head.mako"/>
                   <%include file="access_key.mako"/>
                   <%include file="content_foot.mako"/>
                   <%include file="footer.mako"/>""",
                lookup=self.templateLookup)
            output = myTmpl.render_unicode(
                title="Nox Obscura: registrieren",
                cfg_staticPath=self.cfg.cfg_staticPath,
                cfg_siteUrl=self.cfg.cfg_siteUrl,
                anonymous=self.anonymous,
                userInfo=data.retriveUserInfo(self.username),
                admin=self.privileged)
            return output

    def translateCharList(self, username, usersCharacter):
        cl = DataUser()
        cl = cl.getUsersCharacterList(username, usersCharacter)
        l = [ cl['role'], cl['class'] ]
        return map(self.toCssAttr, l)

    @expose()
    def newOrChangeRaidLogon(self, usersCharacter, logon, comment, raidId):
        self.__init__()
        if self.anonymous:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=4", 303)
        roleAndClass = self.translateCharList(self.username,
            usersCharacter)
        data = DataRaid()
        data = data.newOrChangeRaidLogon(raidId, self.username,
            usersCharacter, logon, comment, roleAndClass[0],
            roleAndClass[1])
        if data:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/raidplaner", 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=9", 303)

    @expose()
    def setLogon(self, raidId, username, logonState):
        self.__init__()
        if not self.privileged:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=5", 303)
        data = DataRaid()
        data = data.changeLogon(raidId, username, logonState)
        if data:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/raidplaner", 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=9", 303)

    @expose()
    def manipulatePoints(self, username, points):
        self.__init__()
        if not self.privileged:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=5", 303)
        data = DataUser()
        if ( type(username) and type(points) ) is list:
            for i in range( username.__len__() ):
                data.manipulatePoints( username[i], int(points[i]) )
        else:
            data.manipulatePoints( username, int(points) )
        raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/raidplaner", 303)

    @expose()
    def regUser(self, username, realname, email, password,
                charname, class_, race, role):
        from Servlet.Visitor.User import User
        if User.secretTextAnswerd:
            User.secretTextAnswerd = False # make global var invalid for next visitor. TODO: not suitable for concurrent regUser! -> over cookie?
            if password[0] == password[1]:
                import hashlib
                hashedPwd = hashlib.md5(password[0]).hexdigest()
            else:
                raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=7", 303)
            import time
            t = time.localtime() # time-struct.
            today = []
            today.append(t.tm_year)
            today.append(t.tm_mon)
            today.append(t.tm_mday)
            today.append(t.tm_hour)
            today.append(t.tm_min)
            today.append(t.tm_sec)
            user = {'email': email, 'password': hashedPwd,
                    'realname': realname, 'session': "",
                    'admin': False, 'dkp': 0,
                    'registerDate': today,
                    'characterList': [ {'race': race, 'role': role,
                        'name': charname, 'class': class_} ]
                   }
            data = DataUser()
            if data.addNewUser(username, user):
                raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/login", 303)
            else:
                raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=8", 303)
        else:
            raise cherrypy.HTTPRedirect(self.cfg.cfg_siteUrl+
                "/fehler?err=6", 303)

    @expose()
    def test(self):
        self.__init__()
        return self.r

    def doLogout(self):
        return 0

    def writeCookie(self, username, session):
        cookie = cherrypy.response.cookie # Generate a Session Cookie.
        cookie['NoxSession'] = session
        cookie['NoxSession']['path'] = '/'
        cookie['NoxSession']['max-age'] = 3600 # = 60 minutes
        cookie['NoxSession']['version'] = 1
        cookie = cherrypy.response.cookie # Generate a UserId Cookie.
        cookie['NoxUser'] = username
        cookie['NoxUser']['path'] = '/'
        cookie['NoxUser']['max-age'] = 3600
        cookie['NoxUser']['version'] = 1
