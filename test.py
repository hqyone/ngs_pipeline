__author__ = 'quanyuanhe'
a="xxx"

b="xxxx"

x="xxxxxxxxhhhh"

xas="xxx"

print (a+b+x+xas)

print ("hqyone")

print ("xxxx")
print (hex(34))

myParams = {"server": 3}
print ";".join(["%s=%s" % (k,v) for k,v in myParams.items()])

def info(object, spacing=10, collapse=1):
    methodList = [method for method in dir(object) if callable(getattr(object, method))]
    procesFunc = collapse and (lambda s: " ".join(s.split())) or (lambda s:s)
    print "\n".join(["%s %s" % (method.ljust(spacing), procesFunc(str(getattr(object, method).__doc__))) for method in methodList])

if __name__ =="__main__":
    print info.__doc__