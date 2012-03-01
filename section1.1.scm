
SICP: Chapter 1 The Elements of Programming

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
* evaluating combination
* compound procedures
* the substituion model for procedure application
* applicative order vs normal order evaluation
* conditional expressions and predicates
* procedures as "black box" abstractions
  * local names
  * Internal definitions, Block structure





(define (minutes-of-processing minutes-of-raw)
  (define seconds-of-raw (* 60 minutes-of-raw))
  (define processing-seconds-per-second-raw (/ 200 50.0))

  (/ (* seconds-of-raw processing-seconds-per-second-raw) 60))

(minutes-of-processing 10)








In scheme, you have an interpreter. You give the interpreter expressions, and it evaluates the expression.


345


(+ 2.7 10)


(* 25 4 8)

combination
operator: *
procedure: multiplication
operands: 25, 4, 8
arguments: each of the operands





Prefix vs Infix Notation

(+ 2 8 10)

vs 

((2 + 8) + 10)
(2 + 8 + 10)






Combinations inside of combinations


(+ (+ 2 8 10) (- 8 3))






Arbitrarily deep nesting, and Pretty printing, or readable code

(+ (* 3
      (+ (* 2 4) 
         (+ 3 5)))
   (+ (- 10 7) 
      6))

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



If we stop and think, we can see that through whatever means, the
computer is remembering what 'pi', 'radius', and 'circumference'
mean. SICP calls this an "environment", in this case specifically
the "global environment". I often refer to this as the "symbol
table". At least in lisp, as the computer moves through my code, I
think of it adding and updating values for different names in my
symbol table. For the sake of staying true to this book, I'll call it
an environment. Being aware of the environment, or symbol table, is
something you should always be aware of in any programming situation. A
programmer I knew in my younger days sort of pointed this out to me,
and I've remembered it ever since. In seemingly complex languagess
like Ruby or Perl, remembering the symbol table helps.

A couple observations are drawn. One is that we are using a simple procedure for figuring out what these expressions mean:

 1. Evaluation all subexpessions of this expression

 2. Apply the procedure that is the value of leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

As an exercise, lets run through the above procedure with the following, seemingly complex expression:

(* (+ 2 (* 4 6))
   (+ 3 5 7))



Here's a picture. Pretend the values in the middle aren't there yet, only the "leafs" of the tree.

![Tree of Seemingly Complex Expressions](section1.1.3.png)

Since the procedure is calling itself, we say that it is "recursive". Also note that it doesn't recurse forever;
eventually it hits expressions that are primitive expressions, like numbers, built-in operators, or other names. When we get to these cases, we don't reapply the evaluation procedure. We say that the these primitives are:

 1) if numeral characters, they refer to the numeric values that they name
 2) if built-in operators, they refer to the machine instructions that lisp depends on to carry out the corresponding operation. ("*" refers to the machine instructions that know how to do multiplication).
 3) if values of other names, they refer to something that must be available in the *environment* for looking up.

Rule 2 is sort of a special case of rule 3, where the value of the name is the collection of machine instructions needed to carry out that operation. But again, for evaluating expressions like

  (* pi (* radius radius))

You need an environment. Without an environment, you can't use rules 2 and 3.

There are exceptions to this evaluation procedure.

(define x 3)

Is not a normal expression. You don't apply an operation called "define" to the symbol 'x' and the number 3. It will associated the value 3 with the name x, and insert that association into the environment. Since it doesn't use the general evaluation rule, we call it a "special form".

The general rule for evaluating expressions, combined with special forms, make up the "syntax" of the programming language. [This was kind of a surprise to me. not the way I would think of the word syntax]. The syntax of lisp is pretty simple compared to other programming languages.

 Just as a general comment, since I started programming in lisp, it
 has made me write more compressed code. It also is nice because you
 get immediate feedback at the interpretter. Peter Norvig says when
 you learn to program, you should use a language that gives you fast
 feedback. His analogy is that you wouldn't learn piano by first
 pressing all the keys and then hearing the sound only after you were
 done pressing all the keys in a song. You get immediate feedback.


1.1.4 procedure definitions. compound procedures?

(define (square x) (* x x))
(define (squaretwo x) (* x x))

x is a local name, like a pronoun in natural languages (it, he, she).


(+ 1 (square 7))


(square (square (square 2)))


(square 25)



(square (+ 2 (square 2)))



(define (sum-of-squares x y)
  (+ (square x) 
     (square y)))



(sum-of-squares 2 3)
(sum-of-squares 3 4)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))


(f 5)


(define (sum-of-squares x y)
  (+ (square x) 
     (square y)
     )
  )

(define (square x) 
  (* x x))



(define (<name> <formal parameters>) <body>)



1.1.5 The Substitution Model for Procedure Application

(f 5)

(sum-of-squares (+ 5 1) (* 5 2))

(sum-of-squares 6 10)

(+ (square 6) (square 10))

(+ (* 6 6) (* 10 10))

(+ 36 100)

136

This is just one model to think about how the interpretter works. Real
interpretters don't do a bunch of text substitution, although using
this mentally is pretty reliable.





---------------------------------------------ruby

  [2,3,4,5].select { |el el % 2 == 0 }


  def test_function(i)
    if i % 2 == 0
      true
    else
      false
    end
  end

  class Array
    def select(f)
      return_array = []
      for el in self.elements
        if f(el)
          return_array << el
        end
      end
      return_array
    end
  end

  def test_function(i)
    (i % 2 == 0)
  end



Normal-order evaluation

keep expanding the operators until you are left with only primitive operations

(f 5)

(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) (square (* 5 2)))


(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

Just primitives left. Go ahead and finally evaluate, or reduce, the
expression. but look at how many evaluations we have to do now!

The book comments the normal-order evaluation has its special uses. Usually
the interpretter uses applicative-order evaluation: evaluate the operands,
then apply the function denoted by the operator.

1.1.6. Conditional Expressions and Predicates

- new special forms: cond, if, and, or, not


(absolute -22)
(absolute 0)
(absolute 10)


(define (absolute a)
  (cond ((> a 0) a)
        ((= a 0) 0)
        ((< a 0) (- a))))



(define (absolute a)
  (cond ((< a 0) (- a))
        (else a)))


(define (absolute a)
  (if (< a 0)
      (- a)
    a))


(cond (<p1> <e1>)
      (<p2> <e2>)
      
      (<pn> <en>))


condition: 5 < x < 10

(define (inrange x)
  (and (> x 5) (< x 10)))

(inrange 2)
(inrange 5)
(inrange 6)
(inrange 9)
(inrange 11)




Exercise 1.1


(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(= a b)
(if (and (> b a) (< b (* a b)))
    b
    a)
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

(+ 2 (if (> b a) b a))

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))



Exercise 1.2. 

(5 + 4 + (2 - (3 - (6 + 1/3))))   / (3 * (6 - 2)(2 - 7))

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 3))))) (* 3 (* (- 6 2) (- 2 7))))

Exercise 1.3. 

 Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.


(define (sum-of-squares x y) (+ (* x x) (* y y)))

(define (sum-of-squares-of-larger a b c)
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
        ((and (<= b a) (<= b c)) (sum-of-squares a c))
        ((and (<= c a) (<= c b)) (sum-of-squares a b))
        (else -1)))

(define (sum-of-squares-of-larger a b c)
  (cond ((and (not (> a b)) (not (> a c))) (sum-of-squares b c))
        ((and (not (> b a)) (not (> b c)) (sum-of-squares a c)))
        ((and (not (> c a)) (not (> c b)) (sum-of-squares a b)))))

(sum-of-squares-of-larger 10 1 5)

(sum-of-squares-of-larger 3 2 1)
(sum-of-squares-of-larger 1 2 3)
(sum-of-squares-of-larger 3 1 2)



Exercise 1.4.


(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))



This is interesting. We use a if special form to determine which primtive procedure to use.


Exercise 1.5. 



(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))


Normal order evaluation of the above will not infinitely recurse. Applicable-order evaluation will indeed infinitely recurse.


1.1.7  Example: Square Roots by Newton's Method

guess = 1 / target = 2






(define (sqrt-iter guess target)
  (if (good-enough? guess target)
    guess
    (sqrt-iter (improve guess target) target)))

(define (good-enough? guess target)
  (< (abs (- (square guess) target)) 0.001))

(define (improve guess target)
  (/ (+ (/ target guess) guess) 2))

(define (sqrt x)
  (sqrt-iter 1.0 x))


(sqrt 9)

(square 11.4)

(sqrt 129.96)

(sqrt (+ 100 37))

(square (sqrt 1000))

------ left off here 2-29-12

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter2 guess target)
  (new-if (good-enough? guess target)
     guess
   (sqrt-iter2 (improve guess target) target)))



;; this might help
(define (sqrt-iter2 guess target)
  (new-if (good-enough? guess target) guess (sqrt-iter2 (improve guess target) target)))

;; new-if is a compound procedure definition. to evaluate such a combination, you first evaluate
;; all of the operands. first it evaluates good-enough?, which may return true or false (probably
;; false since this is the first guess). then it evaluates the second operand, which
;; is a call to improve and then another call to sqrt-iter. this evaluation
;; in turn begins a new round of new-if evaluations, which will again evaluate the predicate
;; and immediately call another round of sqrt-iter3.
;;
;; so we are infitely improving our result but never stopping.
;;
;; note that you could use cond directly instead of new-if:

(define (sqrt-iter3 guess target)
  (cond ((good-enough? guess target) guess)
        (else (sqrt-iter3 (improve guess target) target))))

(sqrt-iter2 1.0 9)
(sqrt-iter3 1.0 9)


1.1.8  Procedures as Black-Box Abstractions

good-enough depends on square, but the author of good-enough? need not
worry about how square is implemented when he is writing
good-enough. at the point of time of writing that method, we don't
actually care.



Local names

- parameters names are local to the procedure. users of a procedure
  don't need to know the paramter names.

- the paramter variables are called bound variables. the procedure
  body definition doesn't really depend on what those names are.  we
  say that the definition binds those variables.  the body of a
  program in which a variable is bound is called its scope. the scope
  of the procedure parameters is the body of the function.

- other names are free variables.


- Internal definitions and block structure


Reconsidering this code, note the procedures that we have:

  sqrt, sqrt-iter, good-enough?, improve



Of these 4, only 1 of them is useful to the end user of this code: sqrt. sqrt depends on the rest internally, but the user need not care. Yet, the user can't make a function called good-enough? because it will interfere with the existing definition of good-enough?.

What we can do is nest the definitions of the internal functions inside of the definition of sqrt:


(define (sqrt-block-structure target)

  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
      (sqrt-iter (improve guess))))

  (define (good-enough? guess)
    (< (abs (- (square guess) target)) 0.001))

  (define (improve guess)
    (/ (+ (/ target guess) guess) 2))

  (sqrt-iter 1.0))



(sqrt-block-structure 16)







This is block structure. We can simplify this even further. If we were to remove x from the internal definitions, then it will still be bound by sqrt above, and it will still have its value. We can let x be a free variable.

