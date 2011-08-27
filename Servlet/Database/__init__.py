# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

import couchdb # minimal Version 0.8.
from Servlet import site_cfg as cfg

viewDict = {
# User Views:
 'users-1': 'dev/getCharList', # username, charList
 'users-2': 'dev/points', # points, {'username':, 'charList':}
# Raids Views:
 'raids-1': 'dev/raidEvent', # [2011,8,24]
 'raids-2': 'dev/getDateAndRaidId', # [date], raidId
 'raids-3': 'dev/logonRaidIdUsername', # [raidId, username], doc
 'raids-4': 'dev/getRaidIdAndUserstate', # [raidId,logonState], {'class':,'role':,'charName':, 'comment':, 'raidId':, 'username':}
# Post Views:
 'posts-1': 'dev/getPosts', # [category, dateAndTime], doc
 'posts-2': 'dev/getComments' # [postId, dateAndTime], doc
}

class AbstractData(object):
    """
    Connects with the CouchDB-Server. Holds shared Functions
    for DB-Communication.
    Uses excessively the pre defined CouchDB-Views, for fast DB-Access.
    """

    # Static Members (shared by all Classinstances)
    couch = couchdb.Server(cfg.cfg_dbUrl)
    couch.resource.credentials = (cfg.cfg_dbUser, cfg.cfg_dbPassword)#Login

    # Exception Classes
    class NoSuchView(Exception): pass
    class NoSuchDB(Exception): pass
    class NoDbSet(Exception): pass


    def __init__(self):
        # Connect to a DB
        self.users = AbstractData.couch[cfg.cfg_dbStorageLocation_Users]
        self.raids = AbstractData.couch[cfg.cfg_dbStorageLocation_Raids]
        self.posts = AbstractData.couch[cfg.cfg_dbStorageLocation_Posts]
        # The Subclasses can set this
        self.myDefaultDb = None

    def readView(self, viewKey, **args):
        """Holds a List of Views,
        you can access all Views from this Function.

        returns:
            all rows of the selected view.

        parameters:
            view: the view name from viewList.
            args: for the view"""
        return self.readViewWithOtherDb(viewKey, self.myDefaultDb, **args)

    def readViewWithOtherDb(self, viewKey, myDb, **args):
        """Holds a List of Views,
        you can access all Views from this Function.

        returns:
            all rows of the selected view.

        parameters:
            view: the view name from viewList.
            args: for the view"""
        view = viewDict[viewKey]
        if view:
            db = myDb
            result = db.view(view, **args)
        else:
            raise Data.NoSuchView()
        try:
            if result.rows.__len__() > 0:
                return result.rows
            else:
                return False # 0 Entries matching
        except:
            return False

    def dbExistsForView(self, viewKey):
        """Helper for readView"""
        if viewKey.find('users') != -1:
            return self.users
        elif viewKey.find('raids') != -1:
            return self.raids
        elif viewKey.finds('posts') != -1:
            return self.posts
        else:
            raise Data.NoSuchDB()

    def createNewEntry(self, data, _id = None):
        if _id is None:
            from uuid import uuid4
            _id = uuid4().hex
        if not self.myDefaultDb:
            raise Data.NoDbSet()
        try:
            if self.myDefaultDb[_id].id:
                return False # The ID already exists!
        except:
            pass # expected behavior.
        try:
            self.myDefaultDb[_id] = data
            return True
        except:
            return False

    def readEntry(self, _id):
        try:
            data = self.myDefaultDb[_id]
            return data
        except:
            return False

    def changeOneEntry(self, _id, entity, newData):
        try:
            doc = self.myDefaultDb[_id]
            doc[entity] = newData # New Value for entity
            self.myDefaultDb[_id] = doc # Safe into Db
            return True
        except:
            return False

    def changeEntireEntry(self, _id, newData):
        """_id = string, newData = {}
        changes the data or inserts new data"""
        try:
            doc = self.myDefaultDb[_id]
            for data in newData:
                doc[data] = newData[data]
            self.myDefaultDb[_id] = doc
            return True
        except:
            return False
