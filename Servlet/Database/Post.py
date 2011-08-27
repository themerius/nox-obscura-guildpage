# -*- coding: utf-8 -*-

# Nox Obscura Guildpage
# ---------------------

from Servlet.Database import AbstractData

class DataPost(AbstractData):
    """
    Creates, maintaines and retrives the Post-specific Datastructures.
    """
    def __init__(self):
        # Inheritance Stuff
        AbstractData.__init__(self)
        # Set the Default DB for this Class
        self.myDefaultDb = self.posts

    def createNewPost(self, _id, title, content, username,
        dateAndTime, category):
        data = {'title': title,
                'content': content,
                'username': username,
                'dateAndTime': dateAndTime,
                'category': category}
        entry = self.createNewEntry(data, _id)
        if entry:
            return True
        else:
            return False

    def createNewComment(self, username, dateAndTime, postId, content):
        data = {'username': username,
                'dateAndTime': dateAndTime,
                'postId': postId,
                'category': "comment",
                'content': content}
        entry = self.createNewEntry(data) # Generates autom. an Id!
        if entry:
            return True
        else:
            return False

    def getPostList(self, category):
        import time
        t = time.localtime()
        nextYear = t.tm_year + 1 # to guarantee to get all data between this dates
        posts = self.readView('posts-1', startkey=[category, [nextYear,0,0,0,0]],
            endkey=[category, [0,0,0,0,0]], descending=True)
        """
        descending=true quite literally means "traverse the btree
        backwards" and that is all. The side effect this has that catches a
        lot of people is that "traverse the btree backwards" means you have
        to swap your start and end keys because going backwards the logic
        is swapped. Or in other words, "start" means "encountered first,
        given the current traversal direction".
        """
        if posts:
            return posts
        else:
            return {}

    def getCommentCount(self, postId):
        import time
        t = time.localtime()
        nextYear = t.tm_year + 1 # to guarantee to get all data between this dates

        comments = self.readView('posts-2', startkey=[postId, [0,0,0,0,0]],
            endkey=[postId, [nextYear,0,0,0,0]])
        if comments:
            return comments.__len__()
        else:
            return 0

    def getCommentsForPost(self, postId):
        import time
        t = time.localtime()
        nextYear = t.tm_year + 1 # to guarantee to get all data between this dates
        comments = self.readView('posts-2', startkey=[postId, [0,0,0,0,0]],
            endkey=[postId, [nextYear,0,0,0,0]])
        if comments:
            return comments
        else:
            return {}

    def getPost(self, _id):
        post = self.readEntry(_id)
        if post:
            return post
        else:
            return {}

    def getLatestPost(self, category):
        post = self.getPostList(category)
        if post:
            return post[0]
        else:
            return {}
