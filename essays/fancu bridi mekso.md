The Sad State of Mex
====

Introduction
---

The mathematics subgrammar in lojban, known as mex in English and mekso in lojban, is a total mess. As far as I know, anything before the basic level has never been used for anything except demonstrating its use. The purpose of this essay is to first survey the existing state of mekso and proposals for reform, provide a critique of the design goals and implementation strategies, and finally to put forward yet another proposal for reform.

Notation
---
Several languages will be used in the examples throughout. They will be colour coded. Light yellow for standard lojban, grey for English, white for mathematics and red for "pseudo-lojban". My variation of bridi math will be in pale green. Definitions will be highlighted with light blue. Inline lojban will be enclosed in braces: \{ mupli \}.

When refering to PEG grammar, the selma'o name is shorthand for the name of the rule that correctly handles si-sa-su stuff and # stands for "free*" (it's very common).

References
---

The primary source of information about mex is ofcourse chapter 18 of the [Complete Logical Language](http://dag.github.com/cll/18/1/), aka the CLL, and the entire CLL more generally. Lojban has a formal grammar, so exact the specification of syntax of mex is available. I'll refer to the [PEG version of the grammar](http://subvert-the-dominant-paradigm.net/~jbominji/code/lojban_grammar.peg). Together these constitute standard lojban.

The first reform preposal I am aware of is by [Xorxes](http://www.lojban.org/tiki/xorxes). It was created on the tiki at the end of 2007 and is found [here](http://www.lojban.org/tiki/MEX+grammar+proposal). It is a relatively modest proposal and suggests that mex operators should be combined with logical conjuctions in mex, as both are effectively binary operators. This allows 4 levels of operand grammar and 3 levels of operator to be collapsed to one level each. The downside is that you can no longer say something like
<loj>
... re su'i ja vu'u pa ...
</loj>

<eng>
... two plus or minus one ...
</eng>

I suspect that it ties in with [this](https://groups.google.com/forum/?fromgroups=#!topic/lojban/ExtEumbYoQg) awesome proposal about logical conjunctions, as the connector of operands is joik-jek, not joik-ek. Also, the way RPN works has been changed, with each left branch of an RPN need to start with a \{fu'a\}. Perhaps this was included to cope with the difficulties of left branching. Both may be an oversight though. Regardless, the PEG is clean and elegant, and therefore provides a good base to build on.

Another type of proposal that I believe has occurred numerous times regards the internal grammar of numbers. In standard lojban, numbers are simply a string of PA and the meaning of such a string is left for the listener, subject to a few guidelines. This means that it is possible to say 'nonsense numbers'. Proposals of this form aim to add another layer of structure to weed out some of this nonsense. [This page](http://www.lojban.org/tiki/tiki-index.php?page=Number+subgrammar) contains two such proposals, perhaps dating from 2004. It arose on the [mailing list](https://groups.google.com/forum/?fromgroups=#!search/mekso$20grammar$20proposal/lojban/PcYroaqeg38/clvXZP8Sn-0J) in 2011 also, with much discussion. Clearly it in a topic many people are interested in, but not I especially. Consequently, I won't discuss it much/ at all.

Saving the best till last, we have [Robin](http://www.lojban.org/tiki/Robin+Lee+Powell)'s [essay](http://teddyb.org/robin/tiki-index.php?page=Lojban%2C+Math%2C+mekso%2C+and+bridi+cmaci), aka bridi cmaci. It's pretty amazing. Not perfect by any means, but full of great points and insights. It is the direct inspiration for this essay and if you haven't read and digested it, please do that first (though you can ignore the two RPN sections). The central point of this, I feel, is that the mex subgrammar is ridiculous, and the natural structures of lojban are already suitably adapted to expressing mathematics. I have strong sympathy for this position, but find the implementation lacking.

**********

Critique
---
I will follow Robin's pattern of analysing the stated goals of mex. They can be found in CLL &sect;18.1.

### Goal 3
Well duh, it's lojban. But like the rest of the language, we only have syntactic unambiguity and the structure should _permit_ an easy reduction in semantic vagueness. This is buttering you up for a controvesial choice later on.

### Goal 4
I don't really know what "quantified expression in natural language" means, but I wouldn't describe maths-talk as a part of natural language so I don't see really what it has to do with mex. Quantified expression are really semantic issue in the main part of the language, so I'll take this to mean that mex should be able to integrate with this other system.

### Goal 2
My goodness does mex fail at this. There's no word for $cos$! Maths vocab is scattered accross the language. Intersection, union, cartesian product and cons are JOI. There are special selma'o for creating vectors and functions. Creating new operators requires using tanru, which then has a two sylable overhead to use in mex. There are alot of VUhU but no real guiding principles; it looks like the list was chosen by an engineer. There is an operator for "Sigma summation", but no equivelents for products, unions, cartesian , products, interesctions, etc. There is (as I mentioned) a way to make matrices, but not higher tensors. There is definite but not indefinite integration.

The number of mathematical operations is [vast](http://web.ift.uib.no/Teori/KURS/WRK/TeX/symALL.html). A lojban system could not, and therefore should not, try to include them all. The only path available then it to provide the structural features neccessary to import them easily and consistently.

### Goal 1
This is _the_ goal. All the other goals are just considerations compared to this. Both the CLL and Robin read this goal to mean that mex should support infix, polish and reverse polish notations. More on RPN later. I would place more emphasis on the usability requirement. In partiular, the requirement that one should be able to read off a mathematical text means that any system we have should be regular in a simple way and free of suprises. Standard lojban has numerous suprises and I find the nesting that bridi cmaci forces anything but simple to keep track of, especially in cases of what should be simple algebraic expressions.

### What is \{lo ve fancu\}?
No seriously, what do you put in there? If you're just meant to put a formula, then how do you know what the variables are?
<loj>
fy fancu fo li xy te'a ny
</loj>

Is this an expotential, some power of $x$, or a function of two variables (in which order?)? How are you susposed to specify?  Before we get too worked up, let's look to mathematics for some guidence. These three would be respectively written
$$
f(n) = x^n,\, f(n) = x^n,\, f(x,n) = x^n
$$
Even in regular mathematics you run into problems like $f(x) = 0$. Is this a constant function, or is this a condition about $x$ ie that $x$ is a root of the function $f$? Some authors use the symbol $:=$ when giving a definition. Alright so that settles it then, just write it like maths does:
<loj>
li ma'o fy boi xy ny du li xy te'a ny <br/>
ija <br/>
li ma'o fy boi xy ny fancu fo li xy te'a ny
</loj>

Well not so fast. In everyday lojban this is probably good enough. It is similar to what most people are taught in schools and it avoids the crippling flaw above. To my mind though, it is still confused. When I see \{ li ma'o fy boi xy ny \} I interpret this as the evaluation of the function $f$ applied to $x$ and $n$, and that is not a function: it is an element of the codomain of $f$ (\{lo cmima be lo te fancu\}). Perhaps it would be an appropriate use of \{ me'o \}, though that seems to be more to do with the symbol/value distinction than evaluted/unevaluated.

Computer scientists and logicians were also bugged by this when they started studying computation. They developed the $\lambda$-calculus and in particular $\lambda$-abstractions. It is more commonly found in mathematics as the "maps to" ($\mapsto$) notation. The three examples from above would be
$$
\lambda x. x^n,\, \lambda n. x^n,\, \lambda x.\lambda n. x^n
$$
$$
x \mapsto x^n,\, n \mapsto x^n,\, (x,n) \mapsto x^n
$$
In computer programming these are called anonymous functions, because they don't require a name to be given. In my opinion, this is the most apropriate thing to fill the 4th slot of \{fancu\}.
<psuedo>
fy fancu fo li $x \mapsto x^n$
</psuedo>

Anonymous functions are most common in functional programming languages, where typically functions are treated no differently to values. In particular, function can be passed as parameters to other functions. I intend to include lambda abstractions and some other bits and pieces.

### Bridi Cmaci
The brillant idea of bridi math is to leverage the existing place structure of lojban to match maths. That is, operators become selbri and operands become sumti and a mex expression is just a bridi. Robin has detected that nesting operations with \{be..bei..be'o\} is a pain and confusing. He coins \{ni'ai\} in NU to mean "x1 is the numerical result of calculation bridi under system / interpretation x2". The name obviously draws from \{ni\} in that extracts a numeric value. This is a genuine problem and I think his solution is on the right track, but I'll take a slightly different approach.

In the next paragraph, he goes on "I've also been using ce'u as the marker for which place to extract a value from, but I'm pretty sure this is wrong". It is. \{ce'u\}, as far as I can tell, should mark the argument place.

********

My proposal: fancu bridi mekso
----------------------------

### Return Value: ce'au

Before we can use bridi to represent calculations, we need a way to extract a value. I am coining the word \{ce'au\} in KOhA8 to mean the value returned. In bridi cmaci, this was implict in the first place. And indeed, most of the time you will want it in the first place.
<define>
ce'au (KOhA8): Marks the place of a function's return value.
</define>

### Lambda Abstraction: zo'ai

We also need a "maps to" thingy. At this point I'd like to point to the previously coined \{[ce'ai](http://vlasisku.lojban.org/vlasisku/ce%27ai)\}. I think it's basically what I want, however I'm not sure. Therefore I define \{zo'ai\} in ZOhU to mark the end of lambda variables in the mathematical sense.
<define>
zo'ai (ZOhU): end prenex of lambda bound variables
</define>

Therefore, I would write
<ross>
xy zo'ai ce'au sumji xy li pa
</ross>

for the anonymous function $x\mapsto x+1$. And $x \mapsto x-1$ would be
<ross>
xy zo'ai xy sumji ce'au li pa
</ross>

### li

Semantically \{li\} means "the evaluated mathematical expression". This is a good meaning for it. Syntactically, the grammar says
<eng>
li-clause &lt;- LI# mex LOhO-clause?#
</eng>

In bridi cmaci, \{ni'ai\} evaluated an expression. We also need something to wrap our bridi in and I would like to use \{li\} for this. It makes more sense that the result of an evaluation is a sumti than a selbri. But to allow a bridi, we would have to ammend the grammar to be something like
<eng>
li-clause &lt;- LI# (mex | subsentence) LOhO-clause?#
</eng>

I haven't tested this grammatical change at all. Off the top of my head, stuff like
<loj>
li pa namcu
</loj>

is in danger of being broken, but as PEG has _ordered_ choice, I think we might be saved. Another possibility would be to follow Robin in wanting something like \{vei\} for this job. But let's suppose that \{li\} works in the spirit I intend. Then our favourite example would be
<ross>
fy fancu fo li xy zo'ai ce'au tenfa xy boi ny
</ross>
$$
f := x \mapsto x^n
$$

Up until now, I have been focussing on $\lambda$-calculus and functions. But this applies to normal maths expressions as well. A calculation is just a function which takes no arguments. Here is a regular example, not about functions
<ross>
li ce'au sumji li pa li pa du li re
</ross>
$$
1 + 1 = 2
$$

This example shows how to extract a value from a normal mathematical bridi. I mentioned earlier that most of the time you will want to put the \{ce'au\} in the first slot, because most the the maths gismu are set up "x1 is the result of applying blah to x2, x3, etc". In light of this, I would suggest that we should implicitly fill the first unfilled spot of a bridi inside \{li\} with \{ce'au\} if there is not already one in the bridi. That would give
<ross>
li sumji li pa li pa du li re
</ross>

<eng>
The value of (the sum of one and one) is two
</eng>

This last form is very intuitive to me.

### RPN

I hate RPN. It's left branching and therefore pretty hard to deal with in most parsers. I know that lojban's formal grammar is meant to be parser neutral, but it is a real practical issue. Unlike, might I say, including it, as no one ever uses it. Except my dad, who has been using the same [financial calculator](http://en.wikipedia.org/wiki/HP-12C) at work for over 30 years.

Anyway, the above examples show the natural preference for forethought notation, which is the standard way functions are written. If you want to use a bridi in reverse polish style, you'll need to either explicitly mark the return value
<ross>
li ce'au li pa li pa sumji cu du li re
</ross>

or else skip the first place
<ross>
li fe li pa li pa sumji cu du li re
</ross>

### Cleaning Up Mex

Let's look at a more complicated expression, but not one unreasonably so.
$$
\frac{4n^2}{4n^2 -1}
$$

With my bridi math this would be
<ross>
li se pilji li pilji li vo li ny li ny vau li se sumji li pilji li vo li ny li ny vau li pa
</ross>

This is pretty bad, in my opinion. And in general bridi mekso are bad on simple algebraic expressions, because more-or-less you have to turn familiar infix stuff into forethought form. Compared to standard lojban
<loj>
li fe'i vei vo pi'i ny pi'i ny vei vo pi'i ny pi'i ny vu'u pa
</loj>

Which is pretty good, about as short as is possible, especially if you consider the "$4n^2$" terms. So, as the little girl in the taco ad says "Why not both?"
<ross>
li selpi'i li vo pi'i ny pi'i ny li vo pi'i ny pi'i ny vu'u pa
</ross>

I really like this. \{li\} is kinda serving as brackets, like \{vei\} in the standard lojban example, demarcating the terms and expresions. Moreover, we can now use \{lo'o\} as a close bracket if we wanted to, as in the earlier examples it would have simply closed off one of the numbers. In fact, the sort of thing that mex really does well is strings of infix expresions, so it makes sense to use it for that. The rest of mex though, is bad and leads to mistakes, so that should go. To recap, I'm proposing that we junk all but the most basic gammar and operators of mex. Everything more difficult than a polynomial should use bridi cmaci.

There is another thing. This may be unpopular, as the CLL doesn't touch it and Robin says "I agree with the CLL that fixing that is the wrong solution", but I think we should have default precedence for infix operators. There are a couple of reason I say this. Unlike those other sources, the number of operators I'm dealing with now are far fewer. I agree it would have been a bad idea to implement precedence levels for 20 operators.

Secondly, I see it as a partly semantic issue. Syntactically you just get a string of "number operator number operator number ..." and it's up to the listener on how to interpret that string. The CLL kind of backs me up here, as it had a mechanism for specifying precedence. A grammar parser doesn't know how to do maths, and nor should a grammarian attempt to teach it. No special mechanism is necessary to change the precendence order, just say to the other person \{ zo pi'i ce'o zo su'i vajni porsi \}

### The Simplified Mex

Allow me to give the grammar of this simplified mex. It is a reduced version of Xorxes' mex grammar
<eng>
li-clause &lt;- LI# ( mex | subsentence ) LOhO?# <br>

tanru-unit-2 &lt;- ... | ME# sumti MEhU#? MOI#? | mex MOI# | ... <br>

interval-property &lt;- mex ROI# NAI#? | ... <br>

free &lt;- ... | mex-operand MAI# | XI# mex-operand <br>

quantifier &lt;- !selpi !sumti-6 mex
</eng>

The only changes here are to allow LI to wrap bridi, junking NUhA and some renaming

<eng>
mex <- mex-1 (mex-operator mex-1)* <br>

mex-1 &lt;- mex-operand (mex-operator BO# mex-1)? <br>

mex-operand &lt;- number BOI#? | lerfu-string BOI#? | VEI# ( mex | subsentence ) VEhO#? <br>

mex-operator &lt;- SE# operator | VUhU# 
</eng>

Here I have dramatically cut what can be a mex-operand and mex-operator. I kept SE converstion of operators because it may be handy, eg
<psuedo>
ny sevu'u my = $-n + m$
</psuedo>

VEI can also wrap a subsentence. I may change my mind back on about this later, if I decide it's better to have something that converts a sumti to a quantifier.

The selma'o VUhU should be reduced to \{ te'a, fe'i, pi'i, vu'u, su'i \}, with that order of precedence. That's 17 members freed. It could be useful to move \{ gei \} to PA, but I haven't thought that through. The selma'o BIhE, FUhA, JOhI, KUhE, MAhO, MOhE, PEhO and TEhU can all be deleted and their sole members freed (another 8) You may also delete NIhE, NAhU and NUhA, but I plan to reuse \{ni'e\}, and you may want to use \{nu'a\} and \{na'u\}. \{ti'o\} may be freed from SEI. \{tu'o\} is not needed in PA. That brings the total to 11 selma'o axed and 27 cmavo reclaimed.

With precedence now defined, we may say something like
<ross>
li re pi'i xyte'avo vu'u so pi'i xyte'aci su'i repa pi'i xyte'are vu'u rexa pi'i xy su'i pare
</ross>

$$
2x^4 - 9x^3 + 21x^2 -26x + 12
$$

The canonical example, the quadratic formula is
$$
ax^2 + bx + c = 0 \Leftrightarrow x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

<loj>
go li .abu bi'epi'i vei xy. te'a re ve'o su'i by. bi'epi'i xy. su'i cy.  du li no <br>
gi li xy. du li vei va'a by. ku'e su'i ja vu'u <br>
fe'a vei by. bi'ete'a re vu'u vo bi'epi'i .abu bi'epi'i cy. ve'o ku'e ve'o <br>
fe'i re bi'epi'i .abu
</loj>

<ross>
go li abu pi'i xyte'are su'i by pi'i xy su'i cy du li no <br>
gi xy du li selpi'i li sumji ja selsumji li novu'u by li tenfa li byte'are vu'u vo pi'i abu pi'i cy li pimu vauvau<br>
li re pi'i abu
</ross>


### How radical is this?

Kinda. A good chunk of the functionality can be incorporated without major syntactic changes. We need \{ce'au\} but that easily fits into KOhA8 with its brother \{ce'u\}. \{zo'ai\} can be expanded out into something involving \{ce'u\} and \{zo'u\}, see the jbovlaste definition of \{ce'ai\}, but no one really understands and/or agrees what this means. I guess you could use \{ni\}, \{du'u\} or \{su'u\} to then wrap your fancu bridi. Practically, that would mean substituting \{ loni ... ce'au ... \} for some of my \{li\}.

With regards to the junking of a lot of mex, you could always keep it around for backwards compatibility and discourage people from using it (ie depreciate it). I think I'm keeping the only part of mex people use anyway.

The operator precedence stuff is semi-legit already.

*************

Full Functionality
----------------

Do you like the pun? I think a good way to go about achieving full expressive power is to copy some people who have tried and succeeded. Functional programming is pretty much writing mathematics as computer code, with some extra stuff for data manipulation. It borders on logic programming, which _is_ writing mathematics as computer code. To this end, I want to incorporate some mainstays of functional programming into lojban.

Some of these features are pure functional things: passing functions as arguments, currying, composition and partial application. Some include tropes, in particular operations on lists, such as cons, cat, map and fold.

### Passing Functions as Arguments: ni'e

As an aside, is there concise term for this?

In standard lojban, I'm not sure there is really a way to do this, but I would say that \{ni'e\} comes close. The CLL gives \{ni'enu'a\}, which first changes an operator into a selbri and then into an operand.  However, operators are no longer really important and selbri have taken over as maths functions. Therefore the type of thing we are looking for is something that turns selbri into sumti. The obvious selma'o is LE. But
<loj>
lo tanjo cu fancu
</loj>

is a false statement. Unfilled places are implicitly filled, so this translates to
<eng>
The tan of some angle is a function.
</eng>

For a simliar reason, trying to directly use \{li\} fails. In our expanded use of \{li\}, it takes a bridi, a bridi whose ellided spots are implicitly filled. So it has the same problem. What would be correct would be
<ross>
li xy zo'ai ce'au tanjo xy cu fancu
</ross>

This is alright for single variable functions, but increasingly annoying for multivariable functions. Take integration
<ross>
li fyboi xyboi abu zo'ai ce'au ra'irsumji fyboi xyboi abu cu fancu
</ross>

This has 16 sylables of kruft. What is needed is something that takes a selbri (ruling out LI) and that won't implicity fill the empty spots with \{zo'e\} (which rules out all existent members of LE). The obvious solution is to move \{ni'e\} to LE and define it to mean "the function given by" where the first place is filled with \{ce'au\} and other unfilled places are understood to be lambda abstracted.
<define>
ni'e (LE): the function given by ....
</define>

Thus the previous example of integration is simply
<ross>
ni'e ra'irsumji cu fancu
</ross>

It is the counterpart to \{me\}.
<ross>
go fy fancu gi ni'e me fy fancu
</ross>


### Partial Application: be'ei

I mentioned earlier that nesting is a problem when using standard lojban to do bridi math. Robin invented the word \{ni'ai\} to cope with it. I dealt by allowing LI to take whole bridi. Keep Robin's solution in mind when we try to pass a partially applied function as an argument.

Suppose for some reason that I was discussing the "squaring function" alot. By this function I mean $s(x) = x^2$. There was actually a week this year (2012) where the squaring function was a major example I was trying to understand. One way to define it would be
<ross>
sy fancu fo li xy zo'ai tenfa xy li re
</ross>

What we can see though, is that the squaring function is basically the function \{tenfa\} with 2 substituted in. This is exactly "partial application". You apply some values to some of the variables of the function to make a new function from the remaining variables. Here is another way to give the definition
<ross>
sy fancu fo ni'e tenfa befi li re
</ross>

Hopefully now you can see where I'm going. To write things in this functional programming style means using \{ni'e\}, which means that you're going to run into the be..bei..be'o nesting problem. To combat this, I adapt the Robin's idea without attaching the idea of numerical evaluation
<define>
be'ei (NU): \{be'ai bridi kei\} is the selbri arising from the unfilled places of the bridi
</define>

Symbolically
<psuedo>
x1 be'ei broda y1 fo y2 kei x2 x3 = x1 broda y1 x2 y2 x3 
</psuedo>

To demonstrate, the earlier example becomes with this feature
<ross>
fy fancu fo ni'e be'ei tenfa fi li re
</ross>

This coinage should actually be generally useful outside the context of maths, and I wouldn't be suprised if someone had already thought of it. For a regular example of it in action, take the ungodly example 7.3 in the CLL
<loj>
ti cmalu (be le ka canlu bei lo'e ckule be'o) nixli (be li mu bei lo merko be'o) bo ckule la bryklyn. loi pemci le mela nu,IORK. prenu le jecta
</loj>

I have added the brackets for my own sanity. Could be written as
<loj>
ti (be'ei cmalu le ka canlu lo'e ckule kei) (be'ei nixli li mu lo merko kei) bo ckule la bryklyn. loi pemci le mela nu,IORK. prenu le jecta
</loj>

Alright, I guess neither is that nice. 

### Function Composition: fancyjo'e

The composition of functions is when you take two functions and do them one after each other. There are several ways you may want to go about this. Most clearly, you could construct a function that takes the two functions as arguments. Something like
<define>
fancyjo'e: x1 is the composition of x2 (function) and x3 (function) ....
</define>

<ross>
li xyboi zy zo'ai pilji li xy te'a re li zy te'a re du ni'e be'ei fancyjo'e ni'e tenfa befi li re ni'e pilji
</ross>

$$
(x,z) \mapsto x^2 z^2 = (t \mapsto t^2) \circ ( x,z \mapsto xz)
$$

Considering the syntactic types involved, two selbri combining into a selbri, naturally leads one to consider using tanru to represent composition. One then faces the dilemma what to do about using tanru to create or describe new functions, which is very important. If you want to use tanru as composition, then I see three solutions.

On one hand, you may use \{bo\} and/or \{ke\} to construct new functions and ordinary tanru grouping to denote composition. Function composition is associative, so we will never need to use these grouping tools for it. Alternatively, you can require each function to be a lujvo, which is easy enough with \{zei\} and four letter rafsi.

The right hand side of the above example is the same in these two schemes, and may be written as
<ross>
ni'e tenfa befi li re pilji
</ross>

Finally, you could not be so lazy, and form a tanru with the word for compose in it. It would look like
<ross>
ni'e tenfa befi li re fancyjo'e pilji
</ross>

<eng>
The function squaring compose multiplication
</eng>

### Curry and Uncurry: na'u and nu'a

For most people, including myself, I can't see this coming up. Like ever. So I won't spend a lot of time explaining it. Currying takes a function and returns a related function, which means for us it takes a selbri and returns a selbri. Into SE it goes.
<define>
na'u (SE): take a curried function and uncurry it.
</define>

<define>
nu'a (SE): take an uncurried function and curry it.
</define>

For an example, if $p = (1,2)$ is a tuple, you may say
<ross>
li na'u sumji py du li ci
</ross>

There is an issue about which, and how many, places of the selbri are curried. I would say that all but the first are curried, and context determines how many.

You could also just coin some brivla for this, form a tanru to curry functions and save yourself a couple of cmavo.

**************

List Operations
--------------

The proximate trigger for me writing this essay was a question on the mriste "What is the Lojban word for product of a series, symbolized by a capital pi?". Can we answer this question now? Well, not quite. We're adapted some of the principal operations from functional programming languages, but we haven't yet assumed any of their data structures.

In particular, lists are a powerful data structure because they are so general. Anything can be arranged in a list. Some programming languages have separate data types for lists and tuples, where the first can be any length of a single type and the latter is a fixed length of any types. But lojban is obviously not strongly typed, and so we need not have this distinction.

To get lists off the ground you need three operations: list construction, maps and folds.

### List Constructors

I'll describe the (:) operator in Haskell. It takes an element and a list, then appends the element to the front of the list. There is already a cmavo for this, in the appropriate selma'o, namely \{ce'o\} in JOI. To make better use of this, we would like to assume that this operator is right associative and that if the rightmost operand is not a list, we should consider it as a singleton list.

This makes sense of expressions such as
<ross>
by ce'o cy ce'o dy
</ross>
<eng>
= b:c:[d] = [b,c,d]
</eng>

But this is boring. If I wanted to consider the sequence of integers from 1 to 10, it'd take me half a minute. Instead, use the interval notation found in BIhI.
<ross>
by bi'o dy
</ross>

How can you differentiate between an integer sequence and an interval in another set? I think you can do with with a combination of \{cuxna\}, \{cmima\} and the BAI tag \{ja'i\}
<ross>
li zilcuxna li pa bi'o li pano ja'i ni'e cmima be lo'i mulna'u <br />
</ross>
<eng>
The selection from the interval from 1 to 10 choosen by membership in the integers.
</eng>

This is unweidly though. Let's coin a lujvo
<define>
cmizilcuxna: cx2 is the selection from cx3 by membership of cm2
</define>

Another route would be to use intersection
<ross>
li pa bi'o li pano ku'a lo'i mulna'u
</ross>

Typically this idiom would be called filtering a list. Finally, similar to list construction is concatenation. Whereas list construction adjoins an element to a list, concatenation takes two lists. \{jonpoi\} would work as a function and I guess you may try to use \{jo'e\}.

Finally to wrap up lose ends, I would advise using \{kutypoi\} for the empty sequence.

### Map

Okay, you can create basic lists. But with these as a base you can quickly build up things of arbitrary complexity. Map takes a function and a list and applies the function to each argument of the list.
<define>
porkanji: p1=k2 is the list from applying k4 to list k3
</define>

With this in hand, we can basically say anything. For example, if we want to talk about the square numbers
<ross>
li porkanji ni'e tenfa befi li re li pa bi'o li ci'i
</ross>

<eng>
The list from applying the squaring function to the list [1, 2, ...]
</eng>

As you can see, this is the appropriate way to describe a sequence of numbers, not by giving a formula for the terms, but rather by applying the formula to the indices of the sequence.

### Fold

With these tools to build lists of things, we could now describe a useful list that we may want to take the product of. But allow me to introduce the more general notion of a fold. The idea is to take a list, and combine all the elements together, to reduce it down to a single number. Typically folds are called left or right depending whether they group the list elements left or right associatively. For example

$$
left\\_fold \\quad addition\\quad [1,2,3,4] \\\
= left\\_fold \\quad addition\\quad [1+2,3,4] \\\
= left\\_fold \\quad addition\\quad [(1+2)+3,4] \\\
= ((1+2)+3)+4
$$

Two distinct ways to express this occur to me, so allow me to describe the one that we can do already. I mentioned at the start of this section that there was no reason for us to distinguish between tuples and lists. Uncurrying changes a function that takes many arguments into one that only takes a single tuple. To act a function on a list, we may uncurry it.
<ross> 
la'e zoi gy factorial gy fancu fo li ny zo'ai na'u pilji li pa bi'o ny
</ross>
<eng>
The factorial is the function given by ($n \mapsto $ the product of the terms of $[1, \ldots, n]$)
</eng>

Strictly speaking, this is not folding a list, as we are really just applying a function once instead of repeatedly applying it. But it has the same effect when we are using multi-ary functions (functions which can take a variable number of arguments).

The other thing we may do is make a function that takes another function and acts on a list, possibly with a seed/initial value.
<define>
porjmina: j4 is the result of applying j1 (function) to j3=p1 (list) with seed j2
</define>
<ross> 
la'e zoi gy factorial gy fancu fo li ny zo'ai poryjmina ni'e pilji li pa bi'o ny
</ross>

An advantage of this second form is that you could easily define tanru/lujvo for common folds and that you don't have to worry about whether the function you are folding with has an multi-arity definition.
<ross>
li tenfa pritu porjmina li re ce'o li re ce'o li re
</ross>
<eng>
The right fold of [2,2,2] with exponentiation. ie 2^(2^2)
</eng>

To recap some useful terminology \{sumji projmina\}, \{pilji porjmina\} and \{tenfa pritu porjmina\} and respectively Sigma notation, Pi notation and a power tower. Clearly the second is the answer to the mailing list question.
