A VER Q Onda con ESE PLUGIN
=======


OOO, is there


https://towardsdatascience.com/processing-xml-in-python-elementtree-c8992941efd2

movies.xml


Se traga nativo de parisina en milisegundos.

https://stackoverflow.com/questions/16698935/how-to-transform-an-xml-file-using-xslt-in-python


import xml.etree.ElementTree as ET

tree = ET.parse('xml/parisina-nativo.xml')
root = tree.getroot()

xslt = ET.parse('xslt/fx-cfdv33.xslt')
transform = ET.XSLT(xslt)
newdom = transform(root)


import timeit
def my_function():
    y = 3.1415
    for x in range(100):
        y = y ** 0.7
    return y

print(timeit.timeit(my_function, number=100000))



fn1(nativoNormal, trans)






import lxml.etree as ET
import timeit

nativoParisina = 'xml/parisina-nativo.xml'
nativoNormal = 'xml/nativo-sin-nada.xml'
trans = 'xslt/fx-cfdv33.xslt'


def fn1(src, tran):
    dom = ET.parse(src)
    xslt = ET.parse(tran)
    tran = ET.XSLT(xslt)
    newdom = tran(dom)
    nr = newdom.getroot()
    xml_str = ET.tostring(nr, encoding='utf-8')
    print(xml_str)  # side effect to make sure there is no laziness here
    return nr


def wrapper(func, *args):
    def wrapper1():
        return func(*args)
    return wrapper1


wrapped = wrapper(fn1(nativoNormal, trans))

timeit.timeit(wrapped, number=1)


https://github.com/averagesecurityguy/Python-Examples/blob/master/movies.xml

