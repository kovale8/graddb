from datetime import datetime
from sqlalchemy import Column, Integer, Numeric, String, Text,
    PrimaryKeyConstraint, ForeignKey, ForeignKeyConstraint
from sqlalechemy.dialects.mysql import SMALLINT, TIMESTAMP
from orm.base import BASE

'''
1:M relationship

A customer may have many billing/shipping addresses.
Each address belongs to one customer.
'''
class Address(BASE):
    __tablename__ = 'address'

    address_id = Column(SMALLINT(unsigned=True), nullable=False,
        primary_key=True)
    customer_id = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('customer.customer_id'))
    street = Column(String(50), nullable=False)
    city = Column(String(50), nullable=False)
    state = Column(String(2), nullable=False)
    # ISO Alpha-2
    country = Column(String(2), nullbale=False)
    zip_code = Column(String(5), nullable=False)
    is_billing = Column(Boolean)
    is_shipping = Column(Boolean)
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('address_id', name='PRIMARY'),
        ForeignKeyConstraint(['customer_id', ['customer.customer_id'])
    )

    def __init__(self, customer, street, city, state, country, zip_code,
            is_billing, is_shipping):
        self.customer = customer
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zip_code = zip_code
        self.is_billing = is_billing
        self.is_shipping = is_shipping
        self.created_at = datetime.today()
        self.updated_at = datetime.today()


class Customer(BASE):
    __tablename__ = 'customer'

    customer_id = Column(SMALLINT(unsigned=True), nullable=False,
        primary_key=True)
    first_name = Column(String(50))
    last_name = Column(String(50))
    email = Column(String(50), nullable=False)
    phone = Column(String(10))
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('customer_id', name='PRIMARY')
    )

    def __init__(self, first_name=None, last_name=None, email, phone=None):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.created_at = datetime.today()
        self.updated_at = datetime.today()


class Order(BASE):
    __tablename__ = 'order'

    order_id = Column(SMALLINT(unsigned=True), nullable=False,
        primary_key=True)
    customer_id = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('customer.customer_id'))
    billing_address = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('address.address_id'))
    shipping_address = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('address.address_id'))
    delivery_date = Column(TIMESTAMP)
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('order_id', name='PRIMARY'),
        ForeignKeyConstraint(['customer_id'], ['customer.customer_id']),
        ForeignKeyConstraint(['billing_address', 'shipping_address'],
            ['address.address_id'])
    )

    def __init__(self, customer, billing_address, shipping_address):
        self.customer = customer
        self.billing_address = billing_address
        self.shipping_address = shipping_address
        self.created_at = datetime.today()
        self.updated_at = datetime.today()

    def addProduct(product):
        self.product_order.append(Product_Order(product=product, order=self))

    def addProducts(products):
        for product in products:
            self.addProduct(product)


class Product(BASE):
    __tablename__ = 'product'

    product_id = Column(SMALLINT(unsigned=True), nullable=False,
        primary_key=True)
    name = Column(String(255), nullable=False)
    description = Column(Text())
    list_price = Column(Numeric(4, 2), nullable=False)
    quantity = Column(Integer(), nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

    __table_args__ = (
        PrimaryKeyConstraint('product_id', name='PRIMARY')
    )

    def __init__(self, name, description, list_price, quantity):
        self.name = name
        self.description = description
        self.list_price = list_price
        self.quantity = quantity
        self.created_at = datetime.today()
        self.updated_at = datetime.today()


'''
M:M relationship

Products can appear in many orders and an order can contain multiple products.
'''
class Product_Order(BASE):
    __tablename__ = 'product_order'

    product_id = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('product.product_id'))
    order_id = Column(SMALLINT(unsigned=True), nullable=False,
        ForeignKey('order.order_id'))
    created_at = Column(TIMESTAMP, nullable=False)
    updated_at = Column(TIMESTAMP, nullable=False)

    __table_args__ = (
       PrimaryKeyConstraint('product_id', 'order_id', name='PRIMARY'),
       ForeignKeyConstraint(['product_id'], ['product.product_id']),
       ForeignKeyConstraint(['order_id'], ['order.order_id'])
    )

    def __init__(self, product=None, order=None):
        self.product = product
        self.order = order
        self.created_at = datetime.today()
        self.updated_at = datetime.today()
