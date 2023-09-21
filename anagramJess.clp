/**
* Ethan Wong
* September 21, 2022
* Produces anamgrams based on a number of letters
*/

(deftemplate Letter (slot c) (slot p))

/**
* Starts the program by running the askForWord function
*/
(defrule asks "Runs the askForWord function"

=>
   (askForWord)
)

/**
* Creates anagrams of letters from patterns that take a letter "c" and finds other letters with a unique position "p"
*/
(defrule anagram "Enumerate groups of unique letters"
   (Letter (c ?c1) (p ?p1)) 
   (Letter (c ?c2) (p ?p2&~?p1))
   (Letter (c ?c3) (p ?p3&~?p1&~?p2))
   (Letter (c ?c4) (p ?p4&~?p1&~?p2&~?p3))
   (Letter (c ?c5) (p ?p5&~?p1&~?p2&~?p3&~?p4))
=>
   (printout t ?c1 ?c2 ?c3 ?c4 ?c5 " ")
)

/**
* Inserts a letter with a character from the alphabet and a position into the fact space
* @param ?letter the character being inserted
* @param ?position the spot the character is being inserted into
*/
(deffunction assertLetter(?letter ?position)

   (assert (Letter (c ?letter) (p ?position)))
   (return)
)

/**
* Inserts letters from a list into the fact space
* @param ?letterList the list of characters being added
*/
(deffunction assertList(?letterList)

   (for (bind ?i 1) (>= (length$ ?letterList) ?i) (++ ?i)
      (bind ?letter (lowcase (nth$ ?i ?letterList)))
      (bind ?position ?i)
      (assertLetter ?letter ?position)
   )

   (return)
)

/**
* Prompts the user for a 5 letter word and finds all possible anagrams
* @return annagram rule's output if word is acceptable; otherwise,
*         prints "Your word doesn't meet requirements!"
*/
(deffunction askForWord()

   (bind ?string (askline "Input a word of 5 letters and I'll calculate all possible anagrams: "))
   (if (isAnagrammable ?string) then (assertList (slice$ ?string)) ; if the st(ring's length =< 5, insert into fact space
    else (printout t "Your word didn't meet the requirements! Try again?" crlf) ; if greater than 5, tell user
   )

   (return)
)

/**
* Checks to see if a string is short enough to be anagrammed
* @param ?string the string being check
* @return true if the string is less than 11 characters; otherwise,
*         false
*/
(deffunction isAnagrammable(?string)
   (return (= (str-length ?string) 5)) ; return if the word is 5 characters or less
)

/**
* Turns a string into a list of its' individual characters
* @param ?string the string being sliced
* @return a list containing all characters in the string
*/
(deffunction slice$(?string)
     
   (bind ?listString (create$))
   ( for (bind ?i 1) (>= (str-length ?string) ?i) (++ ?i)
      
      (bind ?subS (sub-string ?i ?i ?string)) ; bind one character to string
      (bind ?listString (append$ ?listString ?subS)) ; add to list
   )
   (return ?listString)
)
