# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Database.User import DataUser

from mako.lookup import TemplateLookup
from mako.template import Template

import cherrypy

import smtplib
from email.mime.text import MIMEText

import Servlet.site_cfg

# E-Mail sende Funktion wird vererbt?? Oder in eine extra Klasse hier?

class AbstractVisitor(object):
    """
    It checks every Visitor via Cookie if he/she is:
        1. a anonymous Visitor
        2. a known Visitor (logged in)
            a. normal User
            b. privileged User
    And stores this Stateinfo for the Subclasses.
    """

    def __init__(self):
        # Template stuff (assumes that path from __main__):
        self.templateLookup = TemplateLookup(
            directories=['Servlet/Template', 'Servlet/Template/Content',
                    'Servlet/Template/E-Mail'],
                input_encoding='utf-8')
        # Make the Site Config available to all subclasses:
        self.cfg = Servlet.site_cfg
        # Lookup User and Session:
        self.username = "Anonymous"
        self.session = ""
        self.readCookie()
        # Check's if user is known and privileged:
        self.anonymous = self.checkAnonymity()
        self.privileged = self.checkPrivileges()

    def readCookie(self):
        cookie = cherrypy.request.cookie # Read Visitor's cookie.
        try:
            self.session = cookie['NoxSession'].value
            self.username = cookie['NoxUser'].value
        except: # Visitor has no cookie.
            pass

    def checkAnonymity(self):
        "False = known, True = unknown"
        data = DataUser()
        sessionInDb = data.retriveUsersSession(self.username)
        if self.session == sessionInDb:
            return False
        else:
            return True

    def checkPrivileges(self):
        "False = no admin, True = admin"
        data = DataUser()
        prv = data.retriveUsersPrivileges(self.username)
        if prv:
            return True
        else:
            return False

    def calculateToday(self):
        import time
        t = time.localtime() # time-struct.
        today = []
        today.append(t.tm_year)
        today.append(t.tm_mon)
        today.append(t.tm_mday)
        today.append(t.tm_hour)
        today.append(t.tm_min)
        today.append(t.tm_sec) # Save Dates in right order.
        return today

    def toCssAttr(self, x):
        if x == "Tank":
            return "roleTank"
        elif x == "Heiler":
            return "roleHeal"
        elif x == "DPS":
            return "roleDps"
        elif x == "Paladin":
            return "paladin"
        elif x == "Druide":
            return "druid"
        elif x == "Magier":
            return "mage"
        elif x == u"Jäger":
            return "hunter"
        elif x == "Schurke":
            return "rogue"
        elif x == "Hexenmeister":
            return "warlock"
        elif x == "Priester":
            return "priest"
        elif x == "Schamane":
            return "shaman"
        elif x == "Todesritter":
           return "deathknight"
        elif x == "Krieger":
           return "warrior"
        else:
           return "?"

    def errorPage(self, err):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="error_page.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Login",
            cfg_staticPath=self.cfg.cfg_staticPath,
            cfg_siteUrl=self.cfg.cfg_siteUrl,
            anonymous=self.anonymous,
            errMsg=err)
        return output

    def sendMailToAllSubscribers(self, purpose, message, subject):
        """Sends mail to all the Subcribers of the given purpose.
        The purposes are:
            1. "raid"
            2. "post"
            3. "comment" (on a post)
        purposeFlags is a list of bools: [raid, post, comment] per user.
        """
        print "sendMail Report ("+purpose+") BEGIN:"
        import thread
        if purpose == "raid":
            index = 0
        elif purpose == "post":
            index = 1
        elif purpose == "comment":
            index = 2
        else:
            return False
        data = DataUser()
        users = data.retriveEmailAddresses()
        for user in users:
            userPurposeFlags = user.value
            userEmailAddress = user.key
            if userPurposeFlags[index]:
                thread.start_new_thread(self.sendMail, (message, userEmailAddress, subject) )
        print "sendMail Report ("+purpose+") END."
        return True

    def sendMail(self, message, toAddress, subject):
        """There are three Mail-Adresses, for the various purposes."""
        try:
            msg = MIMEText(message.encode('utf-8'), 'plain', 'utf-8') # throws exception if using unicode
            #msg.set_charset('utf-8') # switch string to unicode
            sender = self.cfg.cfg_mailAddress
            msg['From'] = "Nox Obscura informiert"+sender
            msg['To'] = toAddress
            msg['Subject'] = subject
            mailServer = smtplib.SMTP_SSL(self.cfg.cfg_mailSmtp, self.cfg.cfg_mailSmtpPort)
            mailServer.ehlo()
            mailServer.starttls()
            mailServer.ehlo()
            mailServer.login(sender, self.cfg.cfg_mailLoginPassword)
            mailServer.sendmail( sender, toAddress, msg.as_string() )
            mailServer.close()
            print toAddress, True
            return True
        except:
            print toAddress, False
            return False
