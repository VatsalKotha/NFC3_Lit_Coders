import certifi
from pymongo import MongoClient
from settings.config import Config

client = MongoClient(Config.MONGODB_URI,tlsCAFile=certifi.where())
db = client.get_database('lit-coders')
