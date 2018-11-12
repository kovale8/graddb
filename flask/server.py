from flask import Flask, jsonify

app = Flask(__name__)

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from orm import BASE, Customer

connection = create_engine(
    'mysql+pymysql://root:KcPEQtKRPkp7ZxDCTY3NO6cVh@localhost/amazon'
)
BASE.metadata.create_all(connection)
session = sessionmaker(bind=connection)()

@app.route('/')
def index():
    return "<h1>Amazon</h1><h2>Only the best products live here</h2>"

@app.route('/customers')
def getCustomers():
    customers = session.query(Customer).all()
    output = "<h1>Customers</h1>\n<ul>\n"
    for customer in customers:
        output += "<li>" + customer.first_name + " " + customer.last_name + "</li>\n"
    output += "</ul"
    return output

if __name__ == '__main__':
    app.debug = True
    app.run()
