# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Visitor import AbstractVisitor

class Raidplaner(AbstractVisitor):
    """
    Provides the Raidplaner. The Visitor is able to logon on Raid-Events,
    with the options:
        1. signed
        2. substitude
        3. optout
        4. confimed (by admin user)
    Admin User is able to:
        1. create new raids
        2. confirm Visitors
        3. put Visitor in every other logon-state.
    The System automatically sends Mails to alle registred Visitors,
    if new Raids where created. If a Visitor is confirmed, the System sends
    him/her a nofification Mail. (Maybe notify all registred Visitors,
    which haven't yet changed her/his logon-State, eg. 2 Days before
    the event starts.
    """

    def __init__(self):
        # Do inheritance Stuff:
        AbstractVisitor.__init__(self)
        # Own Stuff:

    def raidplaner(self):
        myTmpl = Template(
            """<%include file="header.mako"/>
               <%include file="menu.mako"/>
               <%include file="content_head.mako"/>
               <%include file="raidplaner.mako"/>
               <%include file="points.mako"/>
               <%include file="content_foot.mako"/>
               <%include file="footer.mako"/>""",
            lookup=self.templateLookup)
        output = myTmpl.render_unicode(
            title="Nox Obscura: Die Gilde",
            cfg_staticPath=self.cfg.cfg_staticPath)
        return output

