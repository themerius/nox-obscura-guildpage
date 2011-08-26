# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Database import AbstractData

class DataUser(AbstractData):
    """
    Creates, maintaines and retrives the User-specific Datastructures.
    """
    def __init__(self):
        # Inheritance Stuff
        AbstractData.__init__(self)
        # Set the Default DB for this Class
        self.myDefaultDb = self.users

    def retriveUsersPassword(self, username):
        doc = self.readEntry(username)
        if doc:
            return doc['password']
        else:
            return False

    def setSessionOfUser(self, username, session):
        if self.changeOneEntry(username, 'session', session):
            return True
        else:
            return False

    def retriveUsersSession(self, username):
        doc = self.readEntry(username)
        if doc:
            return doc['session']
        else:
            return False

    def retriveUsersPrivileges(self, username):
        doc = self.readEntry(username)
        if doc:
            return doc['admin']
        else:
            return False

    def retriveUserInfo(self, username):
        doc = self.readEntry(username)
        if doc:
            return doc
        else:
            return {'_id': '', 'admin': False, 'characterList': [],
                    'dkp': 0, 'email': '', 'realname': '', 'session': ''}

    def addCharToUser(self, username, charInfo):
        doc = self.readEntry(username)
        if doc:
            newCharInfo = doc['characterList']
            newCharInfo.append(charInfo)
            if self.changeOneEntry(username, 'characterList', newCharInfo):
                return True
            else:
                return False
        else:
            return False

    def addNewUser(self, username, userData):
        success = self.createNewEntry(userData, username) # username is _id
        return success

    def getUsersCharacterList(self, username, charName):
        view = self.readView('users-1', key=username)
        if view:
            charList = view[0].value
            for char in charList:
                if char['name'] == charName:
                    break
                else:
                    char = False
            if not char:
                return {}
            return char # {'name':,'role':,'race':,'class':}

    def getUsernamesAndPoints(self):
        view = self.readView('users-2', descending=True)
        if view:
            return view
        else:
            return {}

    def manipulatePoints(self, username, pointsDelta):
        entry = self.readEntry(username)
        oldPoints = entry['dkp']
        newPoints = oldPoints + pointsDelta
        self.changeOneEntry(username, 'dkp', newPoints)
