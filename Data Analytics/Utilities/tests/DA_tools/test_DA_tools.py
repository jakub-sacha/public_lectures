import pytest
import numpy as np

import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../../src')))

print(os.path.abspath(os.path.join(os.path.dirname(__file__), '../../src')))

from DA_tools.DA_tools import is_sorted
from DA_tools.DA_tools import sort_1d_array_and_2d_array_by_1d_array
from DA_tools.DA_tools import get_quantiles

class TestIsSorted(object):
    def test_on_sorted_array(self):
        sorted_array = np.array([1.,2.,3.])
        assert is_sorted(sorted_array)==True
    def test_on_unsorted_array(self):
        unsorted_array = np.array([2.,1.,3.])
        assert is_sorted(unsorted_array)==False
    def test_on_2d_array(self):
        array_2d = np.array([[2.,1.,3.],[1,2,3]])
        with pytest.raises(ValueError):
            is_sorted(array_2d)
    def test_on_list(self):
        list_for_test = [1,2,3]
        with pytest.raises(TypeError):
            is_sorted(list_for_test)

class TestSort1dArrayand2dArrayBy1dArray(object):
    def test_on_dimension_mismatch(self):
        a = np.array([1,2])
        b = np.array([[1,2,3],[1,2,3]])
        with pytest.raises(ValueError):
            sort_1d_array_and_2d_array_by_1d_array(a,b)
    def test_on_wrong_type_1st_arg(self):
        a =[1,2]
        b = np.array([[1,2],[1,2]])
        with pytest.raises(TypeError):
            sort_1d_array_and_2d_array_by_1d_array(a,b)
    def test_on_wrong_type_2nd_arg(self):
        a = np.array([1,2])
        b = [[1,2],[1,2]]
        with pytest.raises(TypeError):
            sort_1d_array_and_2d_array_by_1d_array(a,b)
    def test_on_wrong_type_both_arg(self):
        a = [1,2]
        b = [[1,2],[1,2]]
        with pytest.raises(TypeError):
            sort_1d_array_and_2d_array_by_1d_array(a,b)
    def test_on_sorted_1d_array(self):
        a = np.array([1,2])
        b = np.array([[1,2],[1,2]])
        a_e,b_e = sort_1d_array_and_2d_array_by_1d_array(a,b)
        assert np.allclose(a,a_e)&np.allclose(b,b_e)
    def test_on_unsorted_1d_array(self):
        a = np.array([2,1])
        b = np.array([[1,2],[1,2]])
        a_c = np.array([1,2])
        b_c = np.array([[2,1],[2,1]])
        a_e,b_e = sort_1d_array_and_2d_array_by_1d_array(a,b)
        message='Function for a={} and b={} returned {} and {} instead of {} and {}'.format(a,b,a_e,b_e,a_c,b_c)
        assert np.allclose(a_c,a_e)&np.allclose(b_c,b_e), message
