import sys
sys.path.insert(0, './antlr4-runtime')

from antlr4 import *
from CAALexer import CAALexer
from CAAParser import CAAParser
from CAAListener import CAAListener

class TestAACListener(CAAListener):
    def enterAction(self, ctx):
        print("Entered rule: {}".format(ctx.LABEL().getText()))
    
    def enterConjunction(self, ctx):
        print("Parent: {}".format(isinstance(ctx.parentCtx, CAAParser.MessagebodyContext)))
        print("Entered conjuction: {}".format([l.getText() for l in ctx.logic()]))

    def enterMessage(self, ctx):
        print("From: {}".format(ctx.messageto().getText()))

if __name__ == '__main__':
    instream = InputStream(
        """(
                (rule1
                (
                    logic(?x ?y ?z)
                    logic(?s ?f ?h)
                )
                (
                    ~(logic(A B C) logic(A B C))
                    message(
                        (from reactive)
                        (to instinctive)
                        (body (logic(A B C)
                               logic(S F E)))
                    )
                )
                )

                (rule2
                (
                    logic(?x ?y ?z)
                    logic(?s ?f ?h)
                )
                (
                    ~(logic(A B C) logic(A B C))
                    message(
                        (from reactive)
                        (to instinctive)
                        (body (logic(A B C)
                               logic(S F E)))
                    )
                )
                )
            )"""
    )
    lexer = CAALexer(instream)
    stream = CommonTokenStream(lexer)
    parser = CAAParser(stream)
    tree = parser.actions()

    aaclistener = TestAACListener()
    walker = ParseTreeWalker()
    walker.walk(aaclistener, tree)