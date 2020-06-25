from mod_python import apache

def handler(req):
  req.content_type = "text/plain"
  req.write("OK\n")
  return apache.OK

