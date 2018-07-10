# -*- coding: utf-8 -*-
"""
Created on Tue Jul 10 10:19:24 2018

@author: Admin
"""

import bs4 as bs
import urllib.request

source=urllib.request.urlopen('https://en.wikipedia.org/wiki/Global_warming')

soup=bs.BeautifulSoup(source,'lxml')

text

