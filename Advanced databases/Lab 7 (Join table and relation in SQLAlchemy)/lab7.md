# Join table and relation in SQLAlchemy

The purpose of these laboratory classes is to familiarize participants with join table in SQLAlchemy.

The scope of this classes:
 - using join()
 - using outerjoin()
 - 

## Introduction 
From the previous classes we know how create query to database in SQLAlchemy based on function [select](https://docs.sqlalchemy.org/en/13/core/metadata.html?highlight=select#sqlalchemy.schema.Table.select) or [query](https://docs.sqlalchemy.org/en/14/orm/query.html)

To work properly in class, we will need the following configuration:
```python
from sqlalchemy import create_engine, select, Column, Integer, String, Date, ForeignKey, PrimaryKeyConstraint
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine, MetaData, Table

engine = create_engine(db_string)

metadata = MetaData()

dic_table = {}
for table_name in engine.table_names():
    dic_table[table_name] = Table(table_name, metadata , autoload=True, autoload_with=engine)

session = (sessionmaker(bind=engine))()

Base = declarative_base()
```

The first part of the laboratory will concern the case of working with a database whose structure is don't well known.

All the examples for this laboratory part will be for the country, city, and address tables that are mapped on the classes:

```python
class Country(Base):
    __tablename__ = 'country'
    country_id  = Column(Integer, primary_key=True)
    country = Column(String(50))
    last_update  = Column(Date)
    def __str__(self):
        return 'Country id:{0}\n Country name: {1}\n Country last_update: {2}'.format(self.country_id,self.country,self.last_update)


class City(Base):
    __tablename__ = 'city'
    city_id  = Column(Integer, primary_key=True)
    city = Column(String(50))
    country_id =  Column(Integer, ForeignKey('country.country_id'))
    last_update  = Column(Date) 

class Address(Base):
    __tablename__ = 'address'
    address_id = Column(Integer, primary_key=True)
    address = Column(String(50))
    address2 = Column(String(50))
    district = Column(String(50))
    city_id  = Column(Integer,  ForeignKey('city.city_id'))
    postal_code = Column(String(10))
    phone = Column(String(50))
    last_update  = Column(Date) 
```

## Basic join

To make join we can use script:

```python
from sqlalchemy import select

# select * from category

mapper_stmt = select([dic_table['city']]).select_from(dic_table['city'].join(dic_table['country'], dic_table['city'].c.country_id == dic_table['country'].c.country_id ))
print('Mapper join: ')
print(mapper_stmt)

session_stmt = session.query(Country).join(City)
print('\nSession join: ')
print(session_stmt)
```

```sql
Mapper join:
SELECT city.city_id, city.city, city.country_id, city.last_update 
FROM city JOIN country ON city.country_id = country.country_id

Session join:
SELECT country.country_id AS country_country_id, country.country AS country_country, country.last_update AS country_last_update 
FROM country JOIN city ON country.country_id = city.country_id
```
As you can see, the join function creates queries that connect tables in a natural way (PK - FK relationship). But the query results will only appear for the columns contained in the table specified in the select or query functions.

To download records for selected tables, modify the code as follows:
```python
mapper_stmt = select([dic_table['city'],dic_table['country']]).select_from(dic_table['city'].join(dic_table['country'], dic_table['city'].c.country_id == dic_table['country'].c.country_id ))
print('Mapper join: ')
print(mapper_stmt)

session_stmt = q =session.query(Country,City)
print('\nSession join: ')
print(session_stmt)
```
After execute mapper_stmt query, we get a list of tuples representing the values of joined table rows. Examples:

```python
#select query:
[(1, 'A Corua (La Corua)', 87, datetime.datetime(2006, 2, 15, 9, 45, 25), 87, 'Spain', datetime.datetime(2006, 2, 15, 9, 44)), 
(2, 'Abha', 82, datetime.datetime(2006, 2, 15, 9, 45, 25), 82, 'Saudi Arabia', datetime.datetime(2006, 2, 15, 9, 44)), 
(3, 'Abu Dhabi', 101, datetime.datetime(2006, 2, 15, 9, 45, 25), 101, 'United Arab Emirates', datetime.datetime(2006, 2, 15, 9, 44)), 
(4, 'Acua', 60, datetime.datetime(2006, 2, 15, 9, 45, 25), 60, 'Mexico', datetime.datetime(2006, 2, 15, 9, 44)), 
(5, 'Adana', 97, datetime.datetime(2006, 2, 15, 9, 45, 25), 97, 'Turkey', datetime.datetime(2006, 2, 15, 9, 44)), 
(6, 'Addis Abeba', 31, datetime.datetime(2006, 2, 15, 9, 45, 25), 31, 'Ethiopia', datetime.datetime(2006, 2, 15, 9, 44)), 
...]
```

When session_stmt is used, the results are a list of tuples which consist of classes representing the relevant objects

```python
#session query:
[(<__main__.Country object at 0x000001CE78E50E88>, <__main__.City object at 0x000001CE78E50FC8>), 
(<__main__.Country object at 0x000001CE7A09C148>, <__main__.City object at 0x000001CE78E50FC8>), 
(<__main__.Country object at 0x000001CE7A09C208>, <__main__.City object at 0x000001CE78E50FC8>), 
(<__main__.Country object at 0x000001CE7A09C288>, <__main__.City object at 0x000001CE78E50FC8>), 
(<__main__.Country object at 0x000001CE7A09C308>, <__main__.City object at 0x000001CE78E50FC8>)]
```

If we want to create a query for joined anather table we use the following pattern:

```python
mapper_stmt = select([dic_table['city']]).\
select_from(\
dic_table['city'].join(\
dic_table['country'], dic_table['city'].c.country_id == dic_table['country'].c.country_id\
).join(\
dic_table['address'], dic_table['city'].c.city_id == dic_table['address'].c.city_id)\
)

session_stmt = session.query(Country,City,Address).\
join(City, Country.country_id == City.country_id).\
join(Address, Address.city_id == City.city_id)
```
Replacing with the join() function, the outerjoin() function can be used.


## Join with conditions

To start filtering according to a given criterion:
- mapper option:
```python
mapper_stmt = select([dic_table['category'].columns.category_id,dic_table['category'].columns.name]).where(dic_table['category'].columns.name == 'Games')

```
- session option:
```python
session_stmt = session.query(Country).outerjoin(City).filter(Country.country_id > 10)

```

We can use ouer conditions, such as::
- or_
- and_
- in_
- order_by
- limit
- etc.

## Join a database with relationships

This section presents issues related to the use of relationships described in table mapping classes. For a better understanding of the topic, a simple database will be created containing two tables of users and their posts.

We can create this database by code:

```python 
from sqlalchemy import create_engine, ForeignKey, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

engine = create_engine(database_url`)
Base = declarative_base()
Session = sessionmaker(bind = engine)
session = Session()

class User(Base):
   __tablename__ = 'users'

   id = Column(Integer, primary_key = True)
   name = Column(String)
   address = Column(String)
   email = Column(String)
   def __str__(self):
       return 'User id {}\n name: {}\n address: {}\n email: {}\n'.format(self.id,self.name,self.address,self.email)
```

Class User is the simple class that described the data of the user in the system. Class Post represents posts written by a user in the system:

```python
class Post(Base):
   __tablename__ = 'posts'
   
   id = Column(Integer, primary_key = True)
   user_id = Column(Integer, ForeignKey('users.id'))
   post_text = Column(String)
   users = relationship("User", back_populates = "posts")
   def __str__(self):
       return 'Post id {}\n user_id: {}\n Post: {}\n'.format(self.id,self.user_id,self.post_text)
``` 
This class also creates a relationship between the users and posts tables.

The last step is to define the relation between posts and user and create the database structure:
```python
User.posts = relationship("Post", order_by = Post.id, back_populates = "users")
Base.metadata.create_all(engine)
```

```python
data_set = [
    User(
        name = "Anna Mała", 
        address = "Small Place", 
        email = "am@gmail.com",
        posts = [Post(post_text= 'Omnia vincit Amor'), Post(post_text = 'Cogito ergo sum')]
        ),
   User(
      name = "Marta Kwas", 
      address = "Acid avenue", 
      email = "acidM@gmail.com", 
      posts = [Post(post_text= 'You see, in this world there\'s two kinds of people, my friend: Those with loaded guns and those who dig. You dig.'), Post(post_text= 'I\'m gonna make him an offer he can\'t refuse.')]
      ),
   User(
      name = "Zofia Pompa", 
      address = "Water street", 
      email = "zpws@gmail.com",
      posts = [Post(post_text= 'Not all those who wander are lost.'), Post(post_text= 'The Answer to the ultimate question of Life, The Universe and Everything is…42!')]
      )
]

session.add_all(data_set)
session.commit()
```
After executing the query:
```python
result = session.query(User).join(Post).all()
print(result)
```
We get a list of users:
```
[<__main__.User at 0x1b965cce048>,
 <__main__.User at 0x1b96541fcc8>,
 <__main__.User at 0x1b96540c148>]
```
But in this case, by corresponding relationship mapping, each user has a posts field with a list of his posts. We can print all retrieved data with the following code:

```python
for user in result:
    print(user)
    for post in user.posts:
        print(post)
```
Expected result:
```
User id 1
 name: Anna Mała
 address: Small Place
 email: am@gmail.com

Post id 1
 user_id: 1
 Post: Omnia vincit Amor

Post id 2
 user_id: 1
 Post: Cogito ergo sum

User id 2
 name: Marta Kwas
 address: Acid avenue
 email: acidM@gmail.com

Post id 3
 user_id: 2
 Post: You see, in this world there's two kinds of people, my friend: Those with loaded guns and those who dig. You dig.

Post id 4
 user_id: 2
 Post: I'm gonna make him an offer he can't refuse.

User id 3
 name: Zofia Pompa
 address: Water street
 email: zpws@gmail.com

Post id 5
 user_id: 3
 Post: Not all those who wander are lost.

Post id 6
 user_id: 3
 Post: The Answer to the ultimate question of Life, The Universe and Everything is…42!
```

## Exercise 

Use all of these methods to create queries for the test database. Check their execution time using the [profiling and timing code methods](https://jakevdp.github.io/PythonDataScienceHandbook/01.07-timing-and-profiling.html).

For queries:
1. View a list of the names and surnames of managers living in the same country and working in the same store.
2. Find a list of all movies of the same length.
3. Find all clients living in the same city.



