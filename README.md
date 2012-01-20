# Darts :: Dynamic Analysis from Ruby Tests

When you use refactoring tools in curly-bracketed languages, the tools use *static analysis* to answer questions like:

> Who calls this method? Is it even used anymore?

This particular bit of information makes confidently removing dead code a breeze, but there's a lot more you can learn 
from static analysis too.

In Ruby, this is not so easy, because the only way to really know how a Ruby program works is to watch it run.

DARTS watches (using code coverage tools) as you run your test suite, doing *dynamic analysis* to build a model of how your 
code fits together. With this information, we can also answer questions like:
  
> If I change this code, which tests do I need to run?

When you practice test-driven-development, you know that every line of code you write has at least one test that 
covers it, but which one? Darts can tell you.

## Usage

Query darts from the command line, like this:

    darts into <filename>

That will return a list of examples you need to run. So you can chain this with the `rspec` command, like this:

    rspec `darts into <filename>`

### RSpec

In your spec_helper, do this:

    require 'darts/rspec'

That will install darts' hooks to watch your code as the specs run.

# Big Warning

The state of this code is currently prototype. We think it works, but it's very slow. We'd love contributions from people who'd like to help.