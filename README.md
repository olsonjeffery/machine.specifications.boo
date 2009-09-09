## Machine.Specifications.Boo (Msb) -- a Boo DSL for composing MSpec tests

Machine.Specifications.Boo is a [Boo](http://boo.codehaus.org)-based DSL for [Machine.Specifications](http://github.com/machine/machine.specifications/tree/master) (aka MSpec). It is released under the terms of the [MIT License](http://www.opensource.org/licenses/mit-license.php). It is kept under source control at <http://github.com/olsonjeffery/machine.specifications.boo>. 

Many thanks to Aaron Jensen, the creator of MSpec. Also, a debt of gratitude is owed to Andrew Davey and Cedric Vivier, the driving forces behind [Specter](http://specter.sourceforge.net), a suspiciously similar looking Boo DSL, also for composing *context/spec* style tests (I also stole and modified the string -> safe identifier code from there :).

### A brief introduction

As a software developer, I (Jeff Olson), enjoy a great many technologies and patterns that not only make my day-to-day experience as a programmer easier, but more pleasant. Lately, two of those things have been at odds with each other: The desire to use [Machine.Specifications](http://github.com/machine/machine.specifications/tree/master) to write my unit tests in a more *context/spec* style and to use the [Boo](http://boo.codehaus.org) programming language whenever possible.

### The case for Msb

To demonstrate why something like a DSL to wrap Machine.Specifications is useful, let's show some code.

First, an MSpec context in that ol' .NET workhorse, C#:

    using Machine.Specifications;
    using Namespace.Under.Test

    public class when_doing_something_or_other {
    
      Establish context = () =>
      {
        someStuff.ContextSetup.Goes("here");
      };
      
      Because of = () =>
        result = someStuff.Happening();
      
      It should_be_able_to_verify_some_expectation = () =>
        result.ShouldEqual(expected);
      
      static Foo result;
      static Foo expected;
      static ISomeService someStuff;
    }

Hey, hey! That's pretty awesome, in my opinion, when stacked up against other .NET test frameworks. But still: too chatty. And what if we're working outside of Visual Studio, where the tooling support that makes C# more appealing just isn't there? Boo touts as one of its benefits a general sense of *wrist friendliness*, so it *obviously* must be better, right? *Right?*

To the code cave!

    import Machine.Specifications
    import Machine.Specifications.NUnitShouldExtensionMethods from Machine.Specifications.NUnit
    import Namespace.Under.Test
    
    public class when_doing_something_or_other:
      context as Establish = def():
        someStuff.ContextSetup.Goes('here')
      
      of_ as Because = def():
        result = someStuff.Happening()
      
      should_be_able_to_verify_some_expectation as It = def():
        result.ShouldEqual(expected)
      
      result as Foo
      expected as Foo
      someStuff as ISomeService

Well. That's really not that much better, is it? In fact, it's worse in some ways. Look at how the `Establish`, `Because` and `It` has to come *after* the name of the field, in line with Boo's typing convention. It obstructs the "natural english" flow that is intrinsic to MSpec's appeal. On a side note, `of` is a reserved keyword in Boo (for generics, if you must know), so it's not available to be used as an identifier for a class field, hence the `of_` for the `Because` block.

To Boo's credit, it has a pretty smart compiler. It's able to infer that the fields in this class are always going to be used in a static context, so it will take care of that for us at compile time.

That being said... it's not that great. 

And then, out of nowhere...

Behold! Machine.Specifications.Boo!

    import Msb
    import Namespace.Under.Test

    when "doing something or other":
      context:
        someStuff.ContextSetup.Goes('here')

      because:
        result = someStuff.Happening()

      it "should_be_able_to_verify_some_expectation":
        result.ShouldEqual(expected)

      result as Foo
      expected as Foo
      someStuff as ISomeService

There. Much more readable. Also note that the bit where we import `Machine.Specifications.NUnitExtensionMethods` is gone, as well. MSpec.Boo takes care of this for us. All that is required is to import `Msb` to get access to the DSL and MSpec's functionality. 

Of course, since it lacks the whiz-bang features that you can get with C# + Visual Studio + ReSharper + TD.Net, etc, MSpec.Boo might not be the most appropriate choice if you work primarily with these tools. But if you're more interested in composing less-noisy specs than tooling support and/or doing all of your work in Boo, why not at least write your tests in a manner that is a bit easier on the eyes?

### Inheritance in Msb

Msb supports basic, single-concrete-class inheritance for specs (if your context class needs to implement multiple interfaces or other edge cases, I'd be curious to know why).

    when "doing something that needs db access", DbAccessSpec:
      it "should be connecting to the db just fine":
        connection.IsGood.ShouldBeTrue()
    
    public class DbAccessSpec:
      protected static connection = SomeConnectionImpl()

You get the idea. Also note if you want to do base `establish` sections to initialize stuff before your actual specs, you'll need to `import Machine.Specifications` and use it in the style of the "uglier" boo example shown above. That being said, if that initialization provides context to your specifications, you might want to consider not pushing it into a base class for the sake of DRY (which, as a rule, kind of breaks down when it comes to composing meaningful specs).

### But I want helper methods in my contexts! The context classes in MSpec.Boo don't seem to support this!

Put them in a base context class defined using the normal Boo syntax and use inheritance as outlined above or make them "free-standing" functions in the same file as the one where you want to use them. As long as they come *after* all of the contexts in a file, you'll be good:

    when "whatever":
      because:
        result = Foo()
      
      it "should not be so sick of writing example specs":
        result.ShouldBeTrue()
      
      result as bool
    
    public def Foo():
      return true

It'd be trivial to add defining methods in contexts to Msb, but they just get in the way of your context's sole purpose of revealing intention. So I'm doing you a favor, trust me.

Also, as a quick bit of advice: if you find yourself having a ton of helper methods to make your `establish` blocks less cluttered and more intention-revealing, this is a code smell that you should consider refactoring these helper methods in line with the [Object Mother](http://martinfowler.com/bliki/ObjectMother.html) pattern.

### Running your specs

The assemblies generated w/ Msb produce plain ol' MSpec tests. There is a copy of the Machine.Specifications.ConsoleRunner.exe in the Libraries\mspec directory of the source repo. MSpec also has a TeamCity plugin, if that's your cup of tea.

### A quick diversion concerning the use of C# 3.0 extension methods in Boo and MSpec.Boo

One of the benefits of using MSpec as a backing framework is that it comes with a nice, well-fleshed out set of extension methods for test assertions, which it in turn derives from NUnit. These are C# 3.0 extension methods, which have been supported in Boo since [0.9.0](http://jira.codehaus.org/browse/BOO-937). They are pretty simple to use, with one caveat: Boo currently has an.. "interesting" syntax for importing C# 3.0 extension methods:

    import Machine.Specifications.NUnitShouldExtensionMethods form Machine.Specifications.NUnit

In this case, we are importing the specific class (`NUnitShouldExtensionMethods`) from an *assembly* (the part that comes after `from`). With this in mind, much like when doing MSpec in C#, be sure to have your project reference Machine.Specifications.NUnit.dll, although when you import it in your code, you can drop the `.dll` part. 

Thankfully, when working in Msb, you only need to import `Msb` and have at least one Msb-based `when` context in the file. This is because the extension method import is added as a result of the code transformation that happens on a dsl-based context at compile time. If you aren't using Msb + `when`, you still have to do the special extension method import syntax as noted above to get access to MSpec's extension methods.
