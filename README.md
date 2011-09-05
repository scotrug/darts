# DARTS (Dynamic Analysys from Ruby Tests)

When you use refactoring tools in curly-bracketed languages, the tools use *static analysis* to answer questions like:

> Who calls this method? Is it even used anymore?

This particular bit of information makes confidently removing dead code a breeze, but there's a lot more you can learn 
from static analysis too.

In Ruby, this is not so easy, because the only way to really know how a Ruby program works is to watch it run.

DARTS watches (using code coverage tools) as you run your test suite, doing *dynamic analysis* to build a model of how your 
code fits together. With this information, we can also answer questions like:
  
> If I change this code, which tests do I need to run?

When you practice test-driven-development, you konw that every line of code you write has at least one test that 
covers it, but which one? DARTS can tell you the answer.

## Status

DARTS is no more than an idea at the moment. Would you like to help make it real?