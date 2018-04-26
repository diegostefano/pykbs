import sys
sys.path.insert(0, './antlr4-runtime')

from CAAListener import CAAListener

class ActionProfile:
    def __init__(self, actionname, **kwargs)

class CAAListenerBuilder(CAAListener):
    def enterAction(self, ctx):
        print("Entered rule: {}".format(ctx.LABEL().getText()))
    
    def enterConjunction(self, ctx):
        print("Entered conjuction: {}".format([l.getText() for l in ctx.logic()]))