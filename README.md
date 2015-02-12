# Python Dependencies

    pip install CouchDB==1.0
    pip install CherryPy==3.6.0
    pip install Mako==1.0.0


# Start as Background Process

    python Main.py &> nox.log &


# Apache Reverse Proxy

    a2enmod proxy_http
    a2ensite nox-obscura
    service apache2 restart


# CouchDB Config

    /etc/couchdb/local.ini

There it is possible to make the database public or private.
But don’t forget to:

    service couchdb restart


# CouchDB Design Documents

Create Database „nox_posts“:

    {
       "_id": "_design/dev",
       "language": "javascript",
       "views": {
           "getPosts": {
               "map": "function(doc) {\n  emit([doc.category, doc.dateAndTime], doc);\n}"
           },
           "getComments": {
               "map": "function(doc) {\n  if ( doc.category == \"comment\" )\n    emit([doc.postId, doc.dateAndTime], doc);\n}"
           }
       }
    }

Create Database „nox_raids“:

    {
       "_id": "_design/dev",
       "language": "javascript",
       "views": {
           "raidEvent": {
               "map": "function(doc) {\n  if(doc.type == \"raidEvent\") {\n    emit([doc.date[0], doc.date[1], doc.date[2]], doc._id); }\n}"
           },
           "logon": {
               "map": "function(doc) {\n  if(doc.type == \"raidLogon\") {\n    emit(doc.raidId, [doc.usersCharacter, doc.state, doc.comment]); }\n}"
           },
           "logonRaidIdUsername": {
               "map": "function(doc) {\n  if ( doc.type == \"raidLogon\" )\n    emit([doc.raidId, doc.username], doc);\n}"
           },
           "getLogonsForRaidId": {
               "map": "function(doc) {\n  if ( doc.type == \"raidLogon\" ) {\n    emit(doc.raidId,\n         [doc.username, doc.usersCharacter, doc.state]); }\n}"
           },
           "getDateAndRaidId": {
               "map": "function(doc) {\n  if(doc.type == \"raidEvent\")\n    emit(doc.date, doc._id);\n}"
           },
           "getRaidIdAndUserstate": {
               "map": "function(doc) {\n  if(doc.type == \"raidLogon\")\n    emit([doc.raidId, doc.state], \n         {'class':doc.class, 'role': doc.role,\n          'charName': doc.charName, 'comment': doc.comment,\n          'raidId': doc.raidId, 'username': doc.username});\n}"
           }
       }
    }

And within Raids this normal Document:

    {
       "_id": "counter",
       "eventCounter": 0,
       "logonCounter": 0
    }

Create Database „nox_users“:

    {
       "_id": "_design/dev",
       "language": "javascript",
       "views": {
           "getCharList": {
               "map": "function(doc) {\n  emit(doc._id, doc.characterList);\n}"
           },
           "points": {
               "map": "function(doc) {\n  emit(doc.dkp,\n       {'username': doc._id, 'charList': doc.characterList});\n}"
           },
           "email": {
               "map": "function(doc) {\n  emit(doc.email, doc.emailFlags);\n}"
           }
       }
    }
