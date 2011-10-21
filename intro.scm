
In this lesson: Chapter 1 The Elements of Programming

* http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1.1
* Harrold Abelman and Gerald Sussman. Used at MIT for a long time, but replaced by Python this year.
* http://www.codequarterly.com/2011/hal-abelson/
* expressions
* combinations
* prefix notation
* procedures, and operands denoting procedures
* arguments, and operands that denote arguments
* "pretty-printing", or readable code
* the "read-eval-print loop" (REPL)
* in lisp, every expression has a Value
* IDE: automatic indentation, and matching parenthesis highlighting.
* a variable: a name, and a value.
* in scheme, we define variables with `define`
* the 'environment', or symbol table
* "recursive" procedures






456

(* 25 4 7)


In scheme, you have an interpretter. You give the interpretter expressions, and it evaluates the expression.

345


(* 25 4 8)
(+ 2.7 10)


operator: *
operands: 25, 4, 8
procedure: multiplication
arguments: each of the operands





Prefix vs Infix Notation

(+ 2 8 10)

vs 

((2 + 8) + 10)
(2 + 8 + 10)






Combinations inside of combinations

(+ (+ 2 8 10) (- 8 3))






Arbitrarily deep nesting, and Pretty printing, or readable code

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

vs
 
(+ (* 3 
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))




Defining variables.

(define size 10)
(* 2 size)



(define pi 3.14159)
(define radius 10)
(* pi (* radius radius))
(define circumference (* 2 pi radius))
circumference
(* 2 3.14159 10)


If we stop and think, we can see that through whatever means, the computer is remember what 'pi', 'radius', and 'circumference' mean. SICP calls this an "environment", in this case specifically the "global environment". I often refer to this as the "symbol table". At least in lisp, as the computer moves through my code, I think of it adding and updating values for different names in my symbol table. For the sake of staying true to this book, I'll call it an environment. Being aware of the environment, or symbol table, is something you should always be aware of in any environment. A programmer I knew in my younger days sort of pointed this out to me, and I've remembered it ever since. In seemingly complex languagess like Ruby or Perl, remembering the symbol table helps.

A couple observations are drawn. One is that we are using a simple procedure for figuring out what these expressions mean:

 1. Evaluation all subexpessions of this expression

 2. Apply the procedure that is the value of leftmode subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

As an exercise, lets run through the above procedure with the following, seemingly complex expression:

  (* (+ 2 (* 4 6))
     (+ 3 5 7))


Here's a picture. Pretend the values in the middle aren't there yet, only the "leafs" of the tree.

![Tree of Seemingly Complex Expressions](section1.1.3.png)

Since the procedure is calling itself, we say that it is "recursive". Also note that it doesn't recurse forever;
eventually it hits expressions that are primitive expressions, like numbers, built-in operators, or other names. When we get to these cases, we don't reapply the evaluation procedure. We say that the these primitives are:

 1) if numeral characters, they refer to the numberic values that they name
 2) if built-in operators, they refer to the machine instructions that lisp depends on to carry out the corresponding operation. ("*" refers to the machine instructions that know how to do multiplication).
 3) if values of other names, they refer to something that must be available in the *environment* for looking up.

Rule 2 is sort of a special case of rule 3, where the value of the name is the collection of machine instructions needed to carry out that operation. But again, for evaluating expressions like

  (* pi (* radius radius))

You need an environment. Without an environment, you can't use rules 2 and 3.

There are exceptions to this evaluation procedure.

(define x 3)

Is not a normal expression. You don't apply an operation called "define" to the symbol 'x' and the number 3. It will associated the value 3 with the symbol x, and insert that association into the environment. Since it doesn't use the general evaluation rule, we call it a "special form".

The general rule for evaluating expressions, combined with special forms, make up the "syntax" of the programming language. [This was kind of a surprise to me. not the way I would think of the word syntax]. The syntax of lisp is pretty simple compared to other programming languages. Just as a general comment, since I started programming in lisp, it has made me write more compressed code. It also is nice because you get immediate feedback at the interpretter.



















