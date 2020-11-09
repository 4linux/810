#!/usr/bin/env python3

from pymongo import MongoClient
from time import sleep

conn = MongoClient('mongodb://192.168.100.10,192.168.100.11,192.168.100.12',replicaSet='rs00',readPreference='secondary')
sleep(1)
print("Number of nodes connected: {}".format(conn.nodes))

dbCinema = conn.cinema
coll = dbCinema.filmes

for doc in coll.find():
  print(doc['_id'])
  sleep(1)
  print(coll.find_one({'_id':doc['_id']}))


