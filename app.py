from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import mysql.connector as db
import json

import os

DATABASE_CREDENTIALS = {
   'host': os.environ['DATABASE_HOST'],
   'user': os.environ['DATABASE_USER'],
   'password': os.environ['DATABASE_PASSWORD'],
   'database': os.environ['DATABASE_NAME']
}

app = Flask(__name__)

os.environ['DATABASE_URL'] = "mysql://%s:%s@%s/%s" % (DATABASE_CREDENTIALS['user'], DATABASE_CREDENTIALS['password'], DATABASE_CREDENTIALS['host'], DATABASE_CREDENTIALS['database'])

app.config['SQLALCHEMY_DATABASE_URI'] = os.environ['DATABASE_URL']
db = SQLAlchemy(app)

class User(db.Model):
   __tablename__ = 'users'
   id = db.Column(db.Integer, primary_key=True)
   username = db.Column(db.String(80), unique=True)
   email = db.Column(db.String(120), unique=True)

   def __init__(self, username, email):
       self.username = username
       self.email = email

   def __repr__(self):
       return '<User %r>' % self.username


@app.route("/users")
def users_index():
   to_json = lambda user: {"id": user.id, "name": user.username, "email": user.email}
   return json.dumps([to_json(user) for user in User.query.all()])

@app.route("/version")
def print_env():
    return "v2"

@app.route("/env")
def print_env():
    return os.environ['HOME']

if __name__ == "__main__":
   app.run(host='0.0.0.0', port=5000, debug=True)
