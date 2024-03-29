
Some more examples.

Linear Recursion:

(define (factorial n)
  (if (= n 1)
      1
    (* n (factorial (- n 1)))))


;; Note that I am going to collapse primitive expressions if I can, but in this case I can't
;; because every primitive multiplication has a compound procedure call as an operand.
(factorial 6)

(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
(* 720)



Linear iterative process:

while counter <= max-count
  product <- product * counter
  counter <- counter + 1


(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
    (fact-iter (* product counter) (+ counter 1) max-count)))

(define (factorial n)
  (fact-iter 1 1 n))


;; In this case, I can immediately reduce primitive expressions
;; because they don't have compound procedures as operands.
(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720

The first method, called linear recursion, forces the computer to
remember more (proportional to n). The second method is called linear
iterative because the computer doesn't have to remember as much.

Technically, even though the 2nd method if recurisve, since it doesn't
have to remember anything about its current procedure call before
passing values to the next procedure call, we can call it tail-recursive.

We distinguish between the syntax of a procedure referring to itself ("the procodure is recursive")
and the fact that a process needs to maintain a chain of deferred computations ("the process
is recursive").

The latter is computational expensive the first is not necessarily so.

The implementation of scheme used by this book automatically detects
does tail-recursion when possible, but languages like C (and most
modern languages we use) do not automatically do tail recursion.

If you write a linearly iterative function that is theoretically
tail-recursive, you will still pay the computational penalty (your program
will run slower, or possibly blow up the stack).

Exercise 1.9.  Each of the following two procedures defines a method for adding two positive integers in terms of the procedures inc, which increments its argument by 1, and dec, which decrements its argument by 1.

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

Using the substitution model, illustrate the process generated by each procedure in evaluating (+ 4 5). Are these processes iterative or recursive?

(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))

(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

...

recursive process (chain of deferred commands can't complete without waiting on function calls)


(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9

linear iterative process / tail-recursive procedure. process state is stored in only the arguments forwarded to next procedure call.


Exercise 1.10.  The following procedure computes a mathematical function called Ackermann's function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

What are the values of the following expressions?

(A 1 10)

(A 0 (A 1 9)))

(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))

... (predicting 6 more *2, which is 2^4 * 2*6 == 2 ^10 == 1024)

(A 0 (A 0 (A 0 (A 0 (A 0 32)))))
(A 0 (A 0 (A 0 (A 0 64))))
(A 0 (A 0 (A 0 128)))
(A 0 (A 0 256))
(A 0 512)
1024


(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 8))
(A 1 16)

.... (predicting 2^16)....

(A 0 (A 1 15))
(A 0 (A 0 (A 1 14)))
...

there will be 15 expressions with (A 0 ?) when we have (A 1 1) as the final right hand side expression. (A 1 1) is 2.
2^1 * 2 ^ 15 will be 2^16.

65536



(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1)))
(A 2 (A 2 2))

(from above, we know (A 2 2))

(A 2 4)
(A 1 (A 1 4))

(from above, we know 1 4)

(A 1 16)

which we just computed above, 65536.

interesting.

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))

f n => 2n
g n => 2^n
h n =>
   2 ^ h(n-1) if n > 1
   2 if n == 1

;; this one took me a long time; 30-40 minutes. once I did (A 2 5) as an example,
;; the pattern finally emerged. but looking at
;; (A 2 1), (A 2 2), (A 2 3), (A 2 4) was not enough to help me see the pattern.
;; I think I was also insisting on finding a cleaner solution that was not
;; recursively defined, due to the problem's wording of "give concise
;; mathmetical definitions for the functions..."
;; one time I took this class where we had to crack a cipher that depended
;; on a crappy random number generator. only the assignment was deceptively
;; worded.

(A 2 5)
(A 1 (2 4))
(A 1 65536)
(expt 2 65536) ;; a very large number with about 5000 digits 



1.2.2

"In general, the number of steps required by a tree-recursive process will be proportional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree."

True of depth-first-search.

Golden ratio:

phi ^ 2 == phi + 1



Section 1.2.2 implicit exercise on  Tree Recursion

Counting change

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))


(count-change 292)



;;
;; Top-level function that computes all 0-condition leafs for all
;; coins. A 0-condition occurs when the use of a non-penny coin to
;; make change exactly completes the sum adding up to that exact
;; change.
;;
(define (count-0-conditions-all-coins amount)
  (+ (count-0-conditions amount 5)
     (count-0-conditions amount 4)
     (count-0-conditions amount 3)
     (count-0-conditions amount 2)))

;;
;; Tries to compute a-k subtrees starting with 3 major coinsets
;;   {50, 25, 10, 5}, {25, 10, 5}, {10, 5}
;;
;; Every subset leads to its own a-k trees, and each of those
;; subtrees has its own 0-leafs. This adds them all up.
;;
(define (count-0-conditions amount coin-to-yield-0-condition)
  (+ (count-0-conditions-iter amount coin-to-yield-0-condition 5)
     (count-0-conditions-iter amount coin-to-yield-0-condition 4)
     (count-0-conditions-iter amount coin-to-yield-0-condition 3)
     (if (= 0 (modulo amount (first-denomination coin-to-yield-0-condition)))
         1
       0))
  )

;;
;; takes first step of an a-k subtree ST1 where k is denomination of
;; largest coin in set of n coins.  then removes that coin to form
;; another subtree ST2, and predicts whether coin-to-yield-0-condition
;; will be a final a-k operation in ST2. if so adds 1, and iterates
;; to the next ((a-k)-k) subtree that the amount may still support.
;; 
(define (count-0-conditions-iter cur-amount coin-to-yield-0-condition largest-coin)

  (cond ((= 1 coin-to-yield-0-condition) 0)
        ((>= coin-to-yield-0-condition largest-coin) 0)
        ((> (- cur-amount (first-denomination largest-coin)) 0)

         ;; (if (= 0 (modulo (- cur-amount (first-denomination largest-coin)) (first-denomination coin-to-yield-0-condition)))
         ;;     (pp (+ (* 1000 cur-amount) (first-denomination coin-to-yield-0-condition))))

         (if (= 0 (modulo (- cur-amount (first-denomination largest-coin)) (first-denomination coin-to-yield-0-condition)))

             (+ 1 
                (count-0-conditions-iter (- cur-amount (first-denomination largest-coin)) coin-to-yield-0-condition largest-coin))
                (count-0-conditions-iter (- cur-amount (first-denomination largest-coin)) coin-to-yield-0-condition (- largest-coin 1)))

           (+ (count-0-conditions-iter (- cur-amount (first-denomination largest-coin)) coin-to-yield-0-condition largest-coin))))

        ;; too much taken away from amount. may try a smaller coin.
        ((count-0-conditions-iter cur-amount coin-to-yield-0-condition (- largest-coin 1)))))


;;
;; Linearly goes up from 0 to change amount, adding only non-penny 0-condition leaves to
;; running to total.
;;
(define (cc-iter amount cur-amount cur-count)
  (cond ((= cur-amount amount) cur-count)
        ((cc-iter amount (+ cur-amount 1) (+ cur-count (count-0-conditions-all-coins (+ cur-amount 1)))))))



(define (count-change-2 amt)
  (cc-iter amt 1 1))

(count-change 64)
(count-change-2 64)
(count-change 65)
(count-change-2 65)


(count-0-conditions-all-coins 65)


(count-0-conditions 65 3)
(count-0-conditions 65 2)

(count-0-conditions-iter 65 2 5)
(count-0-conditions-iter 65 2 4)
(count-0-conditions-iter 65 2 3)

(count-0-conditions-iter 60 3)


(count-change 90)
(count-change-2 292)
        

;; given 40 cents, calls where adding a nickle reduces remaining amount to 0
(count-0-conditions-iter 40 2 3) ;; 3
(count-0-conditions-iter 40 2 4) ;; 2

(count-0-conditions-iter 65 2 5) ;; 2

(count-0-conditions-all-coins 15)

(count-0-conditions-all-coins 32)

(count-0-conditions-all-coins 10)

  
(cc-iter 10 9 2)
(cc-iter 10 10 4)


;;
;; return number of combinations less than max for this focuscolumn
;; and coin combination
;;
(define (attempt max f q d n p focuscolumn)
  (define value (+ (* 50 f)
                   (* 25 q)
                   (* 10 d)
                   (* 5 n)
                   p))

  (cond ((> value max) 0)
        ((= value max) 1)
        ((cond ((= 1 focuscolumn)
                (attempt max f q d n (+ p 1) focuscolumn))
               ((+ (attempt max f q d n p (- focuscolumn 1))
                   (cond ((= focuscolumn 2) (attempt max f q d (+ n 1) p focuscolumn))
                         ((= focuscolumn 3) (attempt max f q (+ d 1) n p focuscolumn))
                         ((= focuscolumn 4) (attempt max f (+ q 1) d n p focuscolumn))
                         ((= focuscolumn 5) (attempt max (+ f 1) q d n p focuscolumn)))
                   ))))))

;;
;; return number of combinations less than max for this focuscolumn
;; and coin combination
;;
(define (attempt2 max value focuscolumn)
  (cond ((> value max) 0)
        ((= value max) 1)
        ((cond ((= 1 focuscolumn)
                (attempt max (+ value 1) focuscolumn))
               ((+ (attempt max value (- focuscolumn 1))
                   (cond ((attempt max (+ value (first-denomination focuscolumn)))))))))))



Exercise 1.11


(define (f n)
  (cond ((< n 3) n)
        ((+ (f (- n 1))
            (* 2 (f (- n 2)))
            (* 3 (f (- n 3)))))))

(define (f2 n)
  (cond ((< n 3) n)
        ((f-iter n 2 0 1 2))))

(define (f-iter requested-n cur-n a b c)
  (cond ((= cur-n requested-n) c)
        ((f-iter requested-n (+ cur-n 1) b c (+ c (* 2 b) (* 3 a))))))


;; higher than 22, like 25, gets really really bad...several seconds
(f 22)
(f2 22)


Exercise 1.12

1
1  1
1  2  1
1  3  3  1
1  4  6  4  1
1  5 10 10  5  1
1  6 15 20 15  6  1


;; assumes first column was 0, and first row was 0.
;; assumes only legal triangle positions will be called for,
;; to avoid a (or (< row 0) (> col row)) condition.

(define (pascal row col)
  (cond ((or (= col 0) (= col row)) 1)
        ((+ (pascal (- row 1) (- col 1))
            (pascal (- row 1) col)))))

(pascal 5 0) ;; 1
(pascal 5 1) ;; 5
(pascal 5 2) ;; 10
(pascal 5 3) ;; 10
(pascal 5 4) ;; 5
(pascal 5 5) ;; 1

(pascal 5 5) ;; 1
