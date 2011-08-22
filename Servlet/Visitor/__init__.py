# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from mako.lookup import TemplateLookup
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
        self.templateLookup = TemplateLookup(
            directories=['Servlet/Template', 'Servlet/Template/Content'],
            input_encoding='utf-8') # Assumes that path from __main__
        self.cfg = Servlet.site_cfg
        self.anonymous = self.checkAnonymity()
        self.privileged = False
        self.username = "Anonymous"
        if (not self.anonymous):
            self.username = self.getUsername()
            self.privileged = self.checkPrivileges()

    def readCookie(self):
        return ["cookiedata"]

    def checkAnonymity(self):
        "False = known, True = unknown"
        return False

    def checkPrivileges(self):
        return False

    def getUsername(self):
        return "YourName"
