# Join table and relation in SQLAlchemy

The purpose of these laboratory classes is to familiarize participants with group by and function in SQLAlchemy.

The scope of this classes:
 - using group_by()
 - using func()

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

All the examples for this laboratory part will be for the actor, film_actor, and film tables that are mapped on the classes:

```python
class Actor(Base):
    __tablename__ = 'actor'
    actor_id = Column(Integer, primary_key=True)
    first_name = Column(String(45))
    last_name = Column(String(45))
    last_update  = Column(Date) 

class Film_actor(Base):
    __tablename__ = 'film_actor'
    actor_id = Column(Integer,  ForeignKey('actor.actor_id'))
    film_id = Column(Integer,  ForeignKey('film.film_id'))
    PrimaryKeyConstraint(actor_id,film_id)
    last_update  = Column(Date) 

class Film(Base):
    __tablename__ = 'film'
    film_id = Column(Integer, primary_key=True)
    title = Column(String(255))
    description  = Column(String(255))
    release_year  = Column(Date)
    language_id = Column(SmallInteger, ForeignKey('language.language_id'))
    rental_duration = Column(Integer)
    rental_rate = Column(Float)
    length  = Column(Integer)
    replacement_cost = Column(Float)
    special_features  = Column(String(255))
    fulltext  = Column(String(255))
    last_update  = Column(Date) 
```

## Group by

The GROUP BY clause divides the rows returned from the SELECT statement into groups. For each group, you can apply an aggregate function e.g.,  SUM() to calculate the sum of items or COUNT() to get the number of items in the groups. Using SQLAlchemy we can make this in script by:
 
```python
from sqlalchemy import select

# select * from category

mapper_stmt = select([dic_table['actor'].c.first_name]).group_by(dic_table['actor'].c.first_name)

print('Mapper group: ')
print(mapper_stmt)

session_stmt = session.query(Actor.first_name, Actor.last_name).group_by(Actor.first_name)
print('Session group by: ')
print(session_stmt)
```

After execute mapper_stmt ans session_stmt query, we get a list of tuples representing the values. Examples:

```python
#select query:
[('Adam', 2), ('Al', 1), ('Alan', 1), ('Albert', 2), ('Alec', 1), ...]
```


If we want to create a query with group elements for anather  table we use the following pattern:

```python
mapper_stmt = select([dic_table['actor'].c.first_name, dic_table['actor'].c.last_name]).group_by(dic_table['actor'].c.first_name, dic_table['actor'].c.last_name)

session_stmt = session.query(Actor.first_name, Actor.last_name).group_by(Actor.first_name,Actor.last_name)

```


## Using  function
SQLAlchemy's [func](https://docs.sqlalchemy.org/en/14/core/functions.html) module provides access to built-in SQL functions that can make operations like counting and summing faster and more efficient.

According to SQL, we can use functions in many contexts, for example:
-  Operations on results
```python
mapper_stmt = select([func.upper(dic_table['actor'].c.first_name), func.lower(dic_table['actor'].c.last_name)])

session_stmt = session.query(func.upper(Actor.first_name), func.lower(Actor.last_name))
```
- in the section where:
```
mapper_stmt = select([dic_table['actor'].c.first_name, dic_table['actor'].c.last_name]).where(func.length(dic_table['actor'].c.first_name) < 3)

session_stmt = session.query(Actor.first_name, Actor.last_name).filter(func.length(dic_table['actor'].c.first_name) < 3)
```
- as aggregate functions:
```python
mapper_stmt =  select([dic_table['actor'].c.first_name, func.count(dic_table['actor'].c.last_name)]).group_by(dic_table['actor'].c.first_name)

session_stmt = session.query(Actor.first_name, func.count(Actor.last_name)).group_by(Actor.first_name)
```

## Exercise 

Use all of these methods to create queries for the test database. Check their execution time using the [profiling and timing code methods](https://jakevdp.github.io/PythonDataScienceHandbook/01.07-timing-and-profiling.html).

For queries:
1. Calculate the average cost of renting out all your movies.
2. Calculate and display the number of videos in all categories.
3. View the count of all customers grouped by country.
4. Display information about a store that has more than 100 customers and less than 300 customers.
5. Select all customers who watched movies for more than 200 hours.
6. Calculate the average value of a movie rented.
7. Calculate the average value of the video length in all categories.
8. Find longest movie titles in all categories.
9. Find longest movie in all categories. Compare the result with point 10.



