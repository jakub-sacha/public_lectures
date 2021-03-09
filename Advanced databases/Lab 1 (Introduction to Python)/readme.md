
# <center>laboratory 1<br>Computing methods</center>

<a id='zad1'></a>
***Exercies 1.***   
Calculate:
  
$k = 1240\cdot\sqrt{7}$  
$m = 4467$  
$l = 2j$  
$d = k+m$  
$c = d+l$  
  
After calculation chec data type created variabels in the *Variable explorer*. 
  
***Hint:*** To use the mathematical function in Python the best practice is the use of the standard libraries/packages. For the example to calculate sqrt we can use *[math](https://docs.python.org/3/library/math.html)* or *[numpy](http://www.numpy.org/)*:


```python
import math
math.sqrt(10)
```




    3.1622776601683795



or import the only function:


```python
from math import sqrt 
sqrt(10)
```




    3.1622776601683795



***Exercise 2.***  
Using the *[print](https://docs.python.org/3/tutorial/inputoutput.html)* statement,display the result of the variable $d$ from [ex 1](#zad1) to the default accuracy, to three decimal places and to twenty decimal places.

***Exercise 3.***  
Using Python to calculate field $S$ of roller with base radius $r = 17$ and height $h = 33$.

***Exercise 4.***  
To make your script more clearly to you and another user add to him comments:


```python
"""
Multiline comments
"""
```




    '\nMultiline comments\n'



line comments:


```python
# line comments
```

***Exercise 5.***  
For any variables $x_{1},t,r$ calculate:
  
$B = \cfrac{x_{1}+r}{r\cdot\sin(2\cdot x_{1})+3.3456}\cdot x_{1}^{t\cdot r}$,  
  
display result using *print*. 

***Exercise 6.***  
Create matrix:  
  
$\mathbf{M} =\left[ \begin{matrix}
a & 1 & -a\\
0 & 1 & 1\\
-a & a & 1
\end{matrix}\right]
$    
  
where $a = \sqrt{2}$.  
   
For the matrix $\mathbf{M}$ calcualte invers matrix  $\mathbf{Minv}$, transpose matrix $\mathbf{Mt}$, calculate determinant of the matrix $\mathbf{Mdet}$ and dispalay all results. 
  
***Hint:*** To crate matrix in Python we use class *[array](https://docs.scipy.org/doc/numpy-1.15.1/reference/generated/numpy.array.html)* from *[numpy](http://www.numpy.org/)*, exampel of use:


```python
import numpy as np # keyword "as" created the alias of the package  
a = np.array([1, 2, 3])
b = np.array([[1], [2], [3]])
A = np.array([[1,2],[3,4]])
print("horizontal vector:\n {0}".format(a))
print("Vertical vector:\n {0}".format(b))
print("Matrix:\n {0}".format(A))
```

    horizontal vector:
     [1 2 3]
    Vertical vector:
     [[1]
     [2]
     [3]]
    Matrix:
     [[1 2]
     [3 4]]


To invert matrix use *[inv](https://docs.scipy.org/doc/numpy/reference/generated/numpy.linalg.inv.html)*, to calculate determinant of the matrix we can use *[det](https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.linalg.det.html)*  from library *[linalg](https://docs.scipy.org/doc/numpy/reference/routines.linalg.html)*. Transposition of the matrix we can make at use function *[transpose](https://docs.scipy.org/doc/numpy-1.14.0/reference/generated/numpy.transpose.html)* form *numpy* or simply $M.T$. 

***Exercise 6.***  
Use function *print* to display elemts of $\mathbf{M}$: $\mathbf{M}_{1,1},\mathbf{M}_{3,3},\mathbf{M}_{3,2}$. Create vector $\mathbf{w1}$ as threest columns of $\mathbf{M}$ and  vector $\mathbf{w2}$ as second row of  $\mathbf{M}$. Example: 



```python
# crate random matrix 4x4 
P = np.array([np.random.randint(0,10,4),np.random.randint(0,10,4),np.random.randint(0,10,4),np.random.randint(0,10,4)])
print("Random matrix 4x4:\n {0}".format(P))
print("Element 3x2: {0}".format(P[2,1]))
```

    Random matrix 4x4:
     [[6 4 2 3]
     [8 8 4 0]
     [3 4 6 3]
     [8 0 5 6]]
    Element 3x2: 4


To manipulate data in matrix we can use operator ':', for more deatails see [NumPy for Matlab users](https://docs.scipy.org/doc/numpy/user/numpy-for-matlab-users.html#numpy-for-matlab-users).


```python
# get first column
vector1 = P[:,0]
# get firs row 
vector2 = P[0,:]
print("Vector 1:\n {0}".format(vector1))
print("Vector 2:\n {0}".format(vector2))
```

    Vector 1:
     [6 8 3 8]
    Vector 2:
     [6 4 2 3]


***Exercise 7.***  
Calculate numerical roots of the polynomial $W(x) = x^{5} − 7⋅x^{4} + 3⋅x^{3} + 43⋅x^{2} − 28⋅x − 60$, you can use function *[roots](https://docs.scipy.org/doc/numpy/reference/generated/numpy.roots.html)* from *numpy*. Check the correctness of the results.

***Exercise 8.***  
Generate arithmetic strings with a step diffrent from 1 and not being an integer. Use function *[arange](https://docs.scipy.org/doc/numpy/reference/generated/numpy.arange.html)* and *[linspace](https://docs.scipy.org/doc/numpy-1.10.0/reference/generated/numpy.linspace.html)*. Describe differences.

***Exercise 9.***  
Define the function $f(x)= x^{3} - 3x$ and draw her chart for the range:  
1. $x\in<-1,1>$  
2. $x\in<-5,5>$
3. $x\in<0,5>$
  
***Hint:***
Definition of [function](https://www.w3schools.com/python/python_functions.asp) in Python:


```python
def fun1(x):
    return x**2-3*x-2 + 1
```

In Python, code blocks (including functions) are highlighted with indentation. To visualize the results in Python, the package [Matplotlib](https://matplotlib.org/) is used. Basic chart example:


```python
import matplotlib.pyplot as plt

x = np.linspace(-10,10)
y = fun1(x)   
plt.plot(x, y)
plt.title('Example chart')
plt.xlabel('x')
plt.ylabel('y')
plt.legend('Chart 1')
plt.show()
```


    <Figure size 640x480 with 1 Axes>


While supporting the documentation [Matplotlib](https://matplotlib.org/) add: the axis labels, chart titles and legends to the chart.

***Exercise 10.***  
Calculate the amount of heat that will be released during braking if a dependency describes it:  
  
$Q = \cfrac{mv^2}{2}$  
  
where $m = 2500g$, $v = 60km/h$, write the result and give in kilocalories and joules. Plot the graphs that show the change in the amount of heat in the process of chamfering a body with a weight of $3000g$ and the speed $v\in <200,0>km/h$, showing the heat of chamfering on the first in the linear scale on the second logarithmic scale. 

***Tip:*** To create graphs with a logarithmic axis use the function: [semilog](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.semilogy.html), [xlim](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.xlim.html?highlight=xlim#matplotlib.pyplot.xlim) i [figure](https://matplotlib.org/api/_as_gen/matplotlib.pyplot.figure.html?highlight=figure#matplotlib.pyplot.figure) from *Matplotlib*. 

## Classes in Python

Python is an object-oriented programming language. Unlike procedure-oriented programming, where the main emphasis is on functions, object-oriented programming stress on objects.  

The object is simply a collection of data (variables) and methods (functions) that act on those data. And, a class is a blueprint for the object.  

We can think of a class as a sketch (prototype). It contains all the details about elements needed to construct the object.  

We can create many objects from a class. An object is also called an instance of a class and the process of creating this object is called instantiation. 

## Python Objects (Instances)
While the class is the blueprint, an instance is a copy of the class with actual values, literally an object belonging to a specific class. It’s not an idea anymore; it’s an actual animal, like a dog named Roger who’s eight years old.

Put another way, a class is like a form or questionnaire. It defines the needed information. After you fill out the form, your specific copy is an instance of the class; it contains actual information relevant to you.

You can fill out multiple copies to create many different instances, but without the form as a guide, you would be lost, not knowing what information is required. Thus, before you can create individual instances of an object, we must first specify what is needed by defining a class.  

To define a class in Python we use construction:


```python
class Animal:
    def __init__(self, kind, place):
        self.kind = kind
        self.place = place
        
animal1 = Animal('Dog',' whole world')
print('The {0} is living in {1}'.format(animal1.kind, animal1.place))

animal2 = Animal('Dog', ['Africa', 'Asia', 'Europ', 'America', 'Australia'])
print('The {0} is living in {1}'.format(animal2.kind, animal2.place)) 
```

    The Dog is living in  whole world
    The Dog is living in ['Africa', 'Asia', 'Europ', 'America', 'Australia']


All classes create objects, and all objects contain characteristics called attributes (referred to as properties in the opening paragraph). Use the __init__() method to initialize (e.g., specify) an object’s initial attributes by giving them their default value (or state). This method must have at least one argument as well as the self variable, which refers to the object itself. In class Animal we have two variable kind and place.

## Instance Methods
Instance methods are defined inside a class and are used to get the contents of an instance. They can also be used to perform operations with the attributes of our objects. Like the init method, the first argument is always self:


```python
class Animal:
    
    def __init__(self, kind, place):
        self.kind = kind
        self.place = place
        
    def general_info(self):
        print('The {0} is living in {1}'.format(self.kind, self.place))

        
animal1 = Animal('Dog',' whole world')
animal2 =  Animal('Dog', ['Africa', 'Asia', 'Europ', 'America', 'Australia'])
animal1.general_info()
animal2.general_info()

```

    The Dog is living in  whole world
    The Dog is living in ['Africa', 'Asia', 'Europ', 'America', 'Australia']


## Python Object Inheritance
Inheritance is the process by which one class takes on the attributes and methods of another. Newly formed classes are called child classes, and the classes that child classes are derived from are called parent classes.

It’s important to note that child classes override or extend the functionality (e.g., attributes and behaviors) of parent classes. In other words, child classes inherit all of the parent’s attributes and behaviors but can also specify different behavior to follow. The most basic type of class is an object, which generally all other classes inherit as their parent.

When you define a new class, Python 3 it implicitly uses object as the parent class. So the following two definitions are equivalent:


```python
from numpy import random 

class Animal:
    
    def __init__(self, kind, place):
        self.kind = kind
        self.place = place
        
    @classmethod    
    def general_info(self):
        print('The {0} is living in {1}'.format(self.kind, self.place))

class Dog(Animal):
    
    def __init__(self, name, species, place):
        self.name = name
        self.species = species;
        Animal.__init__(self, 'Dog', place)
        
    def general_info(self):
        print('{0} is the {1} species {2} is living in {3}'.format(self.name, self.kind, self.species, self.place))
        
    @staticmethod
    def make_sound():
        print()
        for i in range(1,random.randint(2,10,size = 1)[0]):
            print('Hau')
        
dog = Dog('Alex', 'Terrier', 'Boston')
dog.general_info()
dog.make_sound()
```

## Python Operator Overloading

You have already seen you can use +  operator for adding numbers and at the same time to concatenate strings. It is possible because +  operator is overloaded by both int  class and str  class. The operators are actually methods defined in respective classes. Defining methods for operators is known as operator overloading. For e.g. To use +  operator with custom objects  you need to define a method called __add__  .  

Let’s take an example to understand better:



```python
import math
 
class Circle:
 
    def __init__(self, radius):
        self.__radius = radius
 
    def setRadius(self, radius):
        self.__radius = radius
 
    def getRadius(self):
        return self.__radius
 
    def area(self):
        return math.pi * self.__radius ** 2
    
    def __str__(self):
        return 'Circle radius is: {0}\nArea is {1}'.format(self.__radius, self.area())
        
    def __add__(self, another_circle):
        return Circle( self.__radius + another_circle.__radius )
 

c1 = Circle(4)
print('C1')
print(c1) # This became possible because we have overloaded str operator by adding a    method named __str__
 
c2 = Circle(5)
print('C2')
print(c2)
 
c3 = c1 + c2 # This became possible because we have overloaded + operator by adding a    method named __add__
print('C3')
print(c3)
```

    C1
    Circle radius is: 4
    Area is 50.26548245743669
    C2
    Circle radius is: 5
    Area is 78.53981633974483
    C3
    Circle radius is: 9
    Area is 254.46900494077323


***Exercise 11.***  
Construct the class to describe [quaternion](https://en.wikipedia.org/wiki/Quaternion). In this class define methods to:
- [Quaternion Arithmetic](http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/arithmetic/index.htm)
    * Quaternion Addition
    * Quaternion Subtraction
    * Quaternion Multiplication
    * Quaternion Division
- [Quaternion Functions](http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/functions/index.htm)
    - Conjugate
    - Normalise
    
Use overloading of operators where is this possible.


Supplementary materials:
- [Introduction to Python from DataCamp](https://www.datacamp.com/courses/intro-to-python-for-data-science)
- [Scipy Lecture Notes](http://www.scipy-lectures.org/index.html)
- [NumPy for Matlab users](https://docs.scipy.org/doc/numpy/user/numpy-for-matlab-users.html#numpy-for-matlab-users)
- [Python Tutorial - W3Schools](https://www.w3schools.com/python/default.asp)
- [NumPy](https://www.numpy.org)
- [Matplotlib](https://matplotlib.org/)
- [Anaconda](https://www.anaconda.com/)
- [Learn Python for Data Science](https://www.datacamp.com/learn-python-with-anaconda?utm_source=Anaconda_download&utm_campaign=datacamp_training&utm_medium=banner)
- [Learn Python](https://www.learnpython.org/)
- [Uncle  Google](https://google.pl) i [auntie Wikipedia](https://pl.wikipedia.org/wiki/Wikipedia:Strona_g%C5%82%C3%B3wna)


```python

```
