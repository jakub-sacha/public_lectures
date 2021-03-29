# <center> Analysis of input data and constraints of columns </center>

## Beginning remarks

1. In the folder to this laboratory is located example [data set](./input_data.xlsx) and [jupyter notbook](./lab4_exampel.ipynb) with example solution.
2. Last two cells in the notebook are set on MarkDown style because to correct the work of these cells needs a database connection.
3. If you want check works this section change *db_string* to your database settings.
4. To analysis and clear data input we use [Pandas framework](https://pandas.pydata.org/pandas-docs/stable/index.html).

Pandas is one of the most popular Python libraries to data manipulation. Because pandas allow:
- read and save data file in many extension (csv, xls,xlsx, etc.) and source (url address, database, file, etc. ),
- manage two-dimensional data tables,
- aggregate data,
- selection data,
- indexing data,
- and a lot more.

Because in this course we focus on database, presented methods to analysis and clear input data are very basic.  

## Data set description

The file [input_data.xlsx]((./input_data.xlsx)) contains data about cities such as:
- name (in column city),
- country where this city is, 
- area \[$km^2$\], 
- population,
- president full name (in column president),
- monuments name (in column monument).

Data contains empty cells and duplicate information.

## Read data and basic analysis

In [Pandas framework](https://pandas.pydata.org/pandas-docs/stable/index.html) exist a lot of function to read data from file/database/URL or other, and represented them in [DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html). The DataFrame representation is very to comfortable to use because is some equivalent to the database table structure in Python program. 

To read data from a file we need knowe only type of file and structure of data in this file. For example, if we use CSV file we must know how cells are separated, coding of the file, etc. All functions to read data from a file are part of pandas core module more about this you can read [here](https://pandas.pydata.org/pandas-docs/stable/user_guide/io.html).

On this script we use xlsx type file. To read this file in basic way we need use script:
```python
import pandas as pd

data = pd.read_excel('input_data.xlsx')
print(data)

```
result:

|    	|   city   	|          country         	|   area  	| population 	|            monument           	|     president     	|
|:--:	|:--------:	|:------------------------:	|:-------:	|:----------:	|:-----------------------------:	|:-----------------:	|
|  0 	| New York 	|            US            	| 1213.37 	|  8175133.0 	|     Empire State Building     	|   Bill de Blasio  	|
|  1 	| New York 	|            USA           	|   NaN   	|  8175133.0 	|          Central Park         	|   Bill de Blasio  	|
|  2 	| New York 	| United States of America 	|   NaN   	|     NaN    	|       Statue of Liberty       	|   Bill de Blasio  	|
|  3 	| New York 	|          America         	|   NaN   	|     NaN    	|    St. Patrick's Cathedral    	|   Bill de Blasio  	|
|  4 	| New York 	|            USA           	| 1213.37 	|     NaN    	|          Times Square         	|   Bill de Blasio  	|
|  5 	|  Kraków  	|          Poland          	|   NaN   	|     NaN    	|             Wawel             	|        NaN        	|
|  6 	|  Kraków  	|            PL            	|  326.85 	|  774839.0  	|           Kazimierz           	|        NaN        	|
|  7 	|  Kraków  	|          Polska          	|  326.85 	|     NaN    	|     Church of St. Adalbert    	|        NaN        	|
|  8 	|  Kraków  	|          Poland          	|  326.85 	|     NaN    	|    Juliusz Słowacki Theatre   	|        NaN        	|
|  9 	|  Kraków  	|          Poland          	|  326.85 	|     NaN    	|      Saint Anne's Church      	|        NaN        	|
| 10 	| Warszawa 	|          Poland          	|   NaN   	|  1783321.0 	| Palace of Culture and Science 	| Rafał Trzaskowski 	|
| 11 	| Warszawa 	|          Polska          	|   NaN   	|     NaN    	|              NaN              	| Rafał Trzaskowski 	|
| 12 	| Warszawa 	|          Poland          	|  517.24 	|     NaN    	|       Jabłonowski Palace      	| Rafał Trzaskowski 	|
| 13 	| Warszawa 	|          Poland          	|   NaN   	|     NaN    	|       Holy Cross Church       	| Rafał Trzaskowski 	|
| 14 	| Warszawa 	|          Poland          	|   NaN   	|     NaN    	|      Three Crosses Square     	| Rafał Trzaskowski 	|

As you can see, the table was loaded in full and the Pandas recognized the headers and types of variables in the columns. If the data were missing, Pandas assigned the value NaN.

The table in Pandas is organized similar to a database table. Table in Pandas has type [DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html). Rows are records and columns group cells with this same type of data. Column has type [Series](https://pandas.pydata.org/pandas-docs/stable/reference/series.html) If we want check headers name we can use commend:
```python
print(data.columns)
```
result:
```python
Index(['city', 'country', 'area', 'population', 'monument', 'president'], dtype='object')
```
To show summary information about the column or our DataFrame we use functions describe. Functions describe can be used on [the level DataFrame](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.describe.html?highlight=describe#pandas.DataFrame.describe) or on [the level Series](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.describe.html?highlight=describe#pandas.Series.describe). But working of this functions in this cases is exactly the same, calculation and printing summary information on the data in our DataFrame or single column.

Different we can see only if data in a column has object or numeric (float, integer, etc.) type. If we use describe on a column on object type, on the result we get information about the number of elements different on  NaN (count), the number of unique elements (unique), the most common value (top), frequency of most common value (freq) and summary info about series. On the column on type number this description has form basic statistic. Example of use in two described cases:            
```python
print(data.city.describe())
```
result:
```python
count           15
unique           3
top       New York
freq             5
Name: city, dtype: object
```

```python
print(data.area.describe())
```
result:
```python
count       7.000000
mean      607.340000
std       419.793857
min       326.850000
25%       326.850000
50%       326.850000
75%       865.305000
max      1213.370000
Name: area, dtype: float64
```

Function describe is useful to discover the basic structure of columns. But in creating process of database structure more useful function is [info](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.info.html). This method prints information about a DataFrame including the index data type and column data types, non-null values and memory usage. On this easy way, we see where we need to check data. For example:
```python
print(data.info())
```
result:
```python
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 15 entries, 0 to 14
Data columns (total 6 columns):
city          15 non-null object
country       15 non-null object
area          7 non-null float64
population    4 non-null float64
monument      14 non-null object
president     10 non-null object
dtypes: float64(2), object(4)
memory usage: 848.0+ bytes
```
On this case we see problems:
- city can have error in name,
- contry can have different name or error in name, 
- area and population of the city have NaN value,
- etc.

## Find unique value 

To check values of city and country we can use the function [unique](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.unique.html?highlight=unique). Function unique find in Series unique values and returned this values in the order of appearance. For example:

```python
all_city = data['city'].unique()
print("City array: {0}".format(all_city))

all_country = data['country'].unique()
print("Country array: {0}".format(all_country))
```
result:
```python
City array: ['New York' 'Kraków' 'Warszawa']
Country array: ['US' 'USA' ' United States of America' 'America' 'Poland' 'PL' 'Polska']
```
How we can see city values are correct, but we have problems with the country name. Because values describing this same country have a different form, for example: USA and US. For this case we have two solutions.

First, we can decide that we crate table with a different name of country and table with an official name. In the next step, we connect the table with an official country name with the city. Or the second solution is mapping name of the country to chosen by us. In this script we presented the second solution. 


### Mapping value

For the realisation that solution we use the function [map](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.map.html?highlight=map#pandas.Series.map). This function can be used to map values from two series having one column same, to mapping value from dictionary or from function mapping. This function works only with Series. Passing a data frame would give an Attribute error. Passing series with different length will give the output series of length same as the caller.

To correct use this function, in this case, we must create a dictionary where keys are values from the country and all these keys must be subscribed to the value chosen by us as correct. Example of use:  
```python
dicionary_corect = {'US':'USA', 'USA':'USA', ' United States of America':'USA', 'America':'USA', 'Poland':'POL', 'PL':'POL', 'Polska':'POL' }

mapping_country = data['country'].map(dicionary_corect)

data['country'] = mapping_country
```

Result:

|    	|   city   	| country 	|   area  	| population 	|            monument           	|     president     	|
|:--:	|:--------:	|:-------:	|:-------:	|:----------:	|:-----------------------------:	|:-----------------:	|
|  0 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|     Empire State Building     	|   Bill de Blasio  	|
|  1 	| New York 	|   USA   	|   NaN   	|  8175133.0 	|          Central Park         	|   Bill de Blasio  	|
|  2 	| New York 	|   USA   	|   NaN   	|     NaN    	|       Statue of Liberty       	|   Bill de Blasio  	|
|  3 	| New York 	|   USA   	|   NaN   	|     NaN    	|    St. Patrick's Cathedral    	|   Bill de Blasio  	|
|  4 	| New York 	|   USA   	| 1213.37 	|     NaN    	|          Times Square         	|   Bill de Blasio  	|
|  5 	|  Kraków  	|   POL   	|   NaN   	|     NaN    	|             Wawel             	|        NaN        	|
|  6 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|           Kazimierz           	|        NaN        	|
|  7 	|  Kraków  	|   POL   	|  326.85 	|     NaN    	|     Church of St. Adalbert    	|        NaN        	|
|  8 	|  Kraków  	|   POL   	|  326.85 	|     NaN    	|    Juliusz Słowacki Theatre   	|        NaN        	|
|  9 	|  Kraków  	|   POL   	|  326.85 	|     NaN    	|      Saint Anne's Church      	|        NaN        	|
| 10 	| Warszawa 	|   POL   	|   NaN   	|  1783321.0 	| Palace of Culture and Science 	| Rafał Trzaskowski 	|
| 11 	| Warszawa 	|   POL   	|   NaN   	|     NaN    	|              NaN              	| Rafał Trzaskowski 	|
| 12 	| Warszawa 	|   POL   	|  517.24 	|     NaN    	|       Jabłonowski Palace      	| Rafał Trzaskowski 	|
| 13 	| Warszawa 	|   POL   	|   NaN   	|     NaN    	|       Holy Cross Church       	| Rafał Trzaskowski 	|
| 14 	| Warszawa 	|   POL   	|   NaN   	|     NaN    	|      Three Crosses Square     	| Rafał Trzaskowski 	|


## Supplementing data

On the next step, we need check data correctness. For that we need create validation function based on knowledge about data set and described issue. In the present case we can check correctness of area and population of city.

To do that we can be based on city list *all_city* get the length of the list on unique value from area and population. In the first step, we create a loop by *all_city* and on the beginning, we get all unique value from arena and population where values are different by NaN. In this case, we use [indexing and selecting data](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html) methods from Pandas.

For example, to get all unique values of the area from *New York* we use commend:
 
```python
area = data[(data['city']== 'New York') & (~data['area'].isna())]['area'].unique()
```

This script on the beginning get from *data* all area values where 'city' is equal 'New York' (*data['city']== 'New York'*) and all row where 'area' is different from NaN (*~data['area'].isna()*) - description of function [isna](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.isna.html?highlight=isna#pandas.Series.isna). For the end, we get only unique values from result set.

In the next step, we need to check a number of *area*. To do that we check the length of the list with *area*. If this length is equal 1 we must assign the area value to all records. We can do that using [loc](), Example:

```python
if len(area) == 1:
        data.loc[(data['city'] == city) & (data['area'].isna()), 'area'] = area
    else:
        print('Area data mismatch on the context of {0}'.format(city))
```


Full script example to extract area and population value and check validation: 

```python

for city in all_city:
    area = data[(data['city']==city) & (~data['area'].isna())]['area'].unique()

    population = data[(data['city'] == city) & (~data['population'].isna())]['population'].unique()
	
    if len(area) == 1:
        data.loc[(data['city'] == city) & (data['area'].isna()), 'area'] = area
    else:
        print('Area data mismatch on the context of {0}'.format(city))
        
    if len(population) == 1:
        data.loc[(data['city'] == city) & (data['population'].isna()), 'population'] = population
    else:
        print('Population data mismatch on the context of {0}'.format(city))
```

Result:

|    	|   city   	| country 	|   area  	| population 	|            monument           	|     president     	|
|:--:	|:--------:	|:-------:	|:-------:	|:----------:	|:-----------------------------:	|:-----------------:	|
|  0 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|     Empire State Building     	|   Bill de Blasio  	|
|  1 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|          Central Park         	|   Bill de Blasio  	|
|  2 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|       Statue of Liberty       	|   Bill de Blasio  	|
|  3 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|    St. Patrick's Cathedral    	|   Bill de Blasio  	|
|  4 	| New York 	|   USA   	| 1213.37 	|  8175133.0 	|          Times Square         	|   Bill de Blasio  	|
|  5 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|             Wawel             	|        NaN        	|
|  6 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|           Kazimierz           	|        NaN        	|
|  7 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|     Church of St. Adalbert    	|        NaN        	|
|  8 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|    Juliusz Słowacki Theatre   	|        NaN        	|
|  9 	|  Kraków  	|   POL   	|  326.85 	|  774839.0  	|      Saint Anne's Church      	|        NaN        	|
| 10 	| Warszawa 	|   POL   	|  517.24 	|  1783321.0 	| Palace of Culture and Science 	| Rafał Trzaskowski 	|
| 11 	| Warszawa 	|   POL   	|  517.24 	|  1783321.0 	|              NaN              	| Rafał Trzaskowski 	|
| 12 	| Warszawa 	|   POL   	|  517.24 	|  1783321.0 	|       Jabłonowski Palace      	| Rafał Trzaskowski 	|
| 13 	| Warszawa 	|   POL   	|  517.24 	|  1783321.0 	|       Holy Cross Church       	| Rafał Trzaskowski 	|
| 14 	| Warszawa 	|   POL   	|  517.24 	|  1783321.0 	|      Three Crosses Square     	| Rafał Trzaskowski 	|


## Split data to table
On the next step, we must split a data set to tables represented in the relational database. In this section, we show an example of only two tables *countries* and *cities*. 

To create table *countries* we can use constructor of [DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html). In the constructor function, we give the first argument as unique values from column country in *data* (*data['country'].unique()*) and the second argument as columns name (*columns=['country']*). In the next step using DataFrame object atrybut *index* we change index name to 'id'. Example of use: 
```python
country_list = pd.DataFrame(data['country'].unique(), columns=['country'])

country_list.index.name = 'id'

country_list
```


Result:

| id 	| country 	|
|:--:	|:-------:	|
|  0 	|   USA   	|
|  1 	|   POL   	|


Afterwards, we need to create table *cities*. In this case, we use the function [drop_duplicates](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.drop_duplicates.html) to remove all duplicates from the set of tuple 'city' and 'country'. In the next step, we [reset_index](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.reset_index.html) to set new id value. And of the last, we [drop](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.drop.html) column 'index' created after reset_index operation. To the better presentation of relationships between tables cities and countries, we can change the column name in *city_list* using function [rename](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.rename.html).

```python
city_list = data[['city','country']].drop_duplicates().reset_index().drop(columns = ['index']);
city_list.index.name = 'id'

city_list = city_list.rename(columns = {'country':'country_id'})

city_list
```
Result:

| id 	|   city   	| country_id 	|
|:--:	|:--------:	|:----------:	|
|  0 	| New York 	|     USA    	|
|  1 	|  Kraków  	|     POL    	|
|  2 	| Warszawa 	|     POL    	|

On this phase of data preparation, we need to change the values in 'country_id' to value id from city_list. To do that one more time we use function [map](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.map.html?highlight=map#pandas.Series.map) but with lambda function. Example:
```python
city_list['country_id'] = city_list['country_id'].map(lambda x:  country_list[country_list['country'] == x].index.values.astype(int)[0])

city_list
```
Result:

| id 	|   city   	| country_id 	|
|:--:	|:--------:	|:----------:	|
|  0 	| New York 	|      0     	|
|  1 	|  Kraków  	|      1     	|
|  2 	| Warszawa 	|      1     	|


Full example of creating structure and split of data is available [here](./lab4_exampel.ipynb)
## Database structure 
In this section we show how add constraints to database table and column in table. 

To add constraints to table we need use atrybut *[__table_args__](https://docs.sqlalchemy.org/en/13/orm/extensions/declarative/table_config.html)*. To set of table constraints we need assign tuple with constraints object to this class atrybut. For example we can create constraints:
- [CheckConstraint](https://docs.sqlalchemy.org/en/13/core/constraints.html#sqlalchemy.schema.CheckConstraint)
- [ForeignKey](https://docs.sqlalchemy.org/en/13/core/constraints.html#sqlalchemy.schema.ForeignKeyConstraint)
- [UniqueConstraint](https://docs.sqlalchemy.org/en/13/core/constraints.html#sqlalchemy.schema.UniqueConstraint)
More examples in section [Defining Constraints and Indexes](https://docs.sqlalchemy.org/en/13/core/constraints.html) from SqlAlchemy documentation.  

To creating constraints for column we use constructor of class [Column](https://docs.sqlalchemy.org/en/13/core/metadata.html?highlight=column#sqlalchemy.schema.Column). We can use the following function arguments to set constraints:
- autoincrement,
- default,
- nullable,
- primary_key,
- unique,
- onupdate.

Example of script to database structure with constraints creating:
```python 
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base

db_string = "postgres://postgres:postgres@127.0.0.1:5432/testAGH"

engine = create_engine(db_string)

Base = declarative_base()

# Import column structure and constraints

from sqlalchemy import Column, Integer, String, Float, ForeignKey, Sequence, CheckConstraint, UniqueConstraint

class Country(Base):
    __tablename__ = 'countries'
    __table_args__ = (
        CheckConstraint('len(country) = 3'),
        UniqueConstraint('country'),
    )
    id = Column(Integer, Sequence('seq_country_id'), primary_key = True)
    country = Column(String(50), nullable = False)

class City(Base):
    __tablename__ = 'cities'
    __table_args__ = (
        CheckConstraint('len(city) > 0'),
    )
    id = Column(Integer, Sequence('seq_city_id'), primary_key=True)
    country_id = Column(Integer, ForeignKey('countries.id'))
    city = Column(String, nullable = False)
    
class City_data(Base):
    __tablename__ = 'city_data'
    __table_args__ = (
        CheckConstraint('area > 0'),
        CheckConstraint('population >= 0')
    )
    id = Column(Integer, Sequence('seq_city_data_id'), primary_key=True )
    city_id = Column(Integer, ForeignKey('cities.id'))
    area = Column(Float, nullable = True,  default=0)
    population = Column(Integer, nullable = True,  default=0)
    president = Column(String(60), nullable = True, default='')
    
class Monument(Base):
    __tablename__ = 'monuments'
    __table_args__ = (
        CheckConstraint('len(monument) > 0'),
    )
    id = Column(Integer, Sequence('seq_monument_id'), primary_key=True )
    city_id = Column(Integer, ForeignKey('cities.id'))
    monument = Column(String(100), nullable = True)

Base.metadata.create_all(engine)
```

## Insert data
To insert data into a database on a fast and easy way we can use pandas function [to_sql](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_sql.html).

If we use function [to_sql](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_sql.html) we need set atrybuts:
- namestr - name of SQL table.

- con  - the user is responsible for engine disposal and connection closure for the SQLAlchemy.

- if_exists - definition how to  behave if the table already exists. Possible option:
	- fail: Raise a ValueError. (default option)
	- replace: Drop the table before inserting new values.
	- append: Insert new values to the existing table.


Example of use: 
```python
country_list.to_sql('countries',engine, if_exists='append')
city_list.to_sql('cities',engine, if_exists='append')
city_pop_area.to_sql('city_data',engine, if_exists='append')
city_monuments.to_sql('monuments',engine, if_exists='append')
```


## Exercise

The [data directory](https://github.com/KAIR-ISZ/public_lectures/tree/master/Advanced%20databases/Lab%203%20(Creating%20database%20and%20normalization)/data_set) contains data sets in csv files. Suggest a 3NF database structure and describe it using SQLAlchemy. Create a database schema in  [dbdiagram](https://dbdiagram.io/). To the created database schema add constraints and insert the data.


Your individual data set has the number:
```python
(len(your_name) + len(your_surname))% 6
```


