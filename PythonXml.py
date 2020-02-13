import lxml.etree as et
import timeit

nativoParisina = 'xml/parisina-nativo.xml'
nativoNormal = 'xml/nativo-sin-nada.xml'
trans = 'xslt/fx-cfdv33.xslt'
cfdiMalo = 'xml/Comprobante3.3-malo-esquema.xml'


def fn1(src, tran):
    dom = et.parse(src)
    xslt = et.parse(tran)
    tran = et.XSLT(xslt)
    newdom = tran(dom)
    nr = newdom.getroot()
    xml_str = et.tostring(nr, encoding='utf-8')
    print(xml_str)  # side effect to make sure there is no laziness here
    return nr
    # return xml_str


def fn2(src):
    dom = et.parse(src)
    xml_str = et.tostring(dom, encoding='utf-8')
    print(xml_str)  # side effect to make sure there is no laziness here
    return dom
    # return xml_str




sn = fn1(nativoNormal, trans)
sp = fn1(nativoParisina, trans)
si = fn2(cfdiMalo)

len(sn)

len(sp)

len(sp) / 1024 / 1024
