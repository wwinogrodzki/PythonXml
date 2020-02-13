# no uses esto: import xml.etree.ElementTree as et
import lxml.etree as et

tree = et.parse('xml/movies.xml')
root = tree.getroot()

root.tag

root.attrib

for child in root:
    print(child.tag, child.attrib)

[elem.tag for elem in root.iter()]

xml_str = et.tostring(root, encoding='utf-8', method='xml')


for movie in root.iter('movie'):
    print(movie.attrib)

for description in root.iter('description'):
    print(description.text)

for movie in root.findall("./genre/decade/movie/[year='1992']"):  # why slash?
    print(movie.attrib)

for movie in root.findall("./genre/decade/movie[year='1992']"):  # works as well
    print(movie.attrib)

for movie in root.findall("./genre/decade/movie/format/[@multiple='Yes']"):
    print(movie.attrib)

for movie in root.findall("./genre/decade/movie/format/[@multiple='Yes'].."):
    print(movie.attrib)

#  .. or ... for papi
for movie in root.findall("./genre/decade/movie/format[@multiple='Yes'].."):
    print(movie.attrib)

#  .. or ... for papi
for movie in root.findall("./genre/decade/movie/format[@multiple='Yes']../.."):
    print(movie.attrib)










