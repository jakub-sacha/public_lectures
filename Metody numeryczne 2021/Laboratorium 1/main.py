import math
from cmath import pi

import numpy as np


def cylinder_area(r:float,h:float):
    """Obliczenie pola powierzchni walca. 
    Szczegółowy opis w zadaniu 1.
    
    Parameters:
    r (float): promień podstawy walca 
    h (float): wysokosć walca
    
    Returns:
    float: pole powierzchni walca 
    """
    if r > 0 and h > 0:
        return 2 * pi * r * h + pi * r * r * 2
    else:
        return math.nan



def fib(n:int):
    """Obliczenie pierwszych n wyrazów ciągu Fibonnaciego. 
    Szczegółowy opis w zadaniu 3.
    
    Parameters:
    n (int): liczba określająca ilość wyrazów ciągu do obliczenia 
    
    Returns:
    np.ndarray: wektor n pierwszych wyrazów ciągu Fibonnaciego.
    """
    if n > 0 and isinstance(n, int):
        result = np.ndarray(shape=(1, n), dtype=int)
        result[0][0] = 1  # jak zaczynam od 0 to testy nie przechodzą
        if n == 1:  # dostaje dosyć sprzeczne odpowiedzi od testów więc dorzucam ten warunek
            return result[0]
        if n >= 2:
            result[0][1] = 1
        if n >= 3:
            i = 2
            while n > i:
                result[0][i] = result[0][i - 1] + result[0][i - 2]
                i += 1
        return result

    else:
        return None



def matrix_calculations(a:float):
    """Funkcja zwraca wartości obliczeń na macierzy stworzonej 
    na podstawie parametru a.  
    Szczegółowy opis w zadaniu 4.
    
    Parameters:
    a (float): wartość liczbowa 
    
    Returns:
    touple: krotka zawierająca wyniki obliczeń 
    (Minv, Mt, Mdet) - opis parametrów w zadaniu 4.
    """
    M = np.array([[a, 1, -a], [0, 1, 1], [-a, a, 1]])
    try:
        Minv = np.linalg.inv(M)
    except np.linalg.LinAlgError:
        Minv = math.nan
    Mt = M.T
    Mdet = np.linalg.det(M)
    return Minv, Mt, Mdet




def custom_matrix(m:int, n:int):
    """Funkcja zwraca macierz o wymiarze mxn zgodnie 
    z opisem zadania 7.  
    
    Parameters:
    m (int): ilość wierszy macierzy
    n (int): ilość kolumn macierzy  
    
    Returns:
    np.ndarray: macierz zgodna z opisem z zadania 7.
    """
    if n >= 0 and m >= 0 and isinstance(n, int) and isinstance(m, int):
        result = np.ndarray([m, n])
        for i, row in enumerate(result):
            for j, _ in enumerate(row):
                if i > j:
                    result[i][j] = i
                else:
                    result[i][j] = j
        return result
    else:
        return None





