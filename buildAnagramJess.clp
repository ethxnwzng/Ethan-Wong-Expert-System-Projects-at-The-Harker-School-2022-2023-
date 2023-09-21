/**
* Ethan Wong
* September 23, 2022
* Produces all possible anagrams from a given word
*/

(deftemplate Letter (slot c) (slot p))
(defglobal ?*MAXLENGTH* = 11)
(defglobal ?*MINLENGTH* = 0)

/**
* Starts the program by running the askForWord function
*/
(defrule asks "Runs the askForWord function"

=>
   (askForWord)

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
* Inserts letters from a given list into the fact space
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
* Prompts the user for a word with >0 and <11 characters then finds all possible anagrams
* @return anagram rule's output if word is acceptable; otherwise,
*         prints "Your word doesn't meet requirements! Try again?"
*/
(deffunction askForWord()

   (bind ?string (askline "Input a word less than 11 characters and I'll calculate all possible anagrams: "))
   (if (isAnagrammable ?string) then (buildAnagram ?string) (assertList (slice$ ?string))
    else (printout t "Your word didn't meet the requirements! Try again?" crlf) ()
   )

   (return)
)

/**
* Checks to see if a given string is a correct length to be anagrammed
* @param ?string the string being checked
* @return true if the string is less than 11 characters and greater than 0; otherwise,
*         false
*/
(deffunction isAnagrammable(?string)

   (bind ?length (str-length ?string))
   (return (and (> ?length ?*MINLENGTH*) (> ?*MAXLENGTH* ?length))) 

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

/**
* Creates a string that will be entered as code, being a rule that will calculate all anagrams for a given word
* Sample output of string passed through (build <>) function (changes based on number of chraracters):
*
* (defrule anagram 
*    (Letter (c ?c1) (p ?p1)) 
*    (Letter (c ?c2) (p ?p2&~?p1))
*    (Letter (c ?c3) (p ?p3&~?p1&~?p2))
*    (Letter (c ?c4) (p ?p4&~?p1&~?p2&~?p3))
*    (Letter (c ?c5) (p ?p5&~?p1&~?p2&~?p3&~?p4))
*  =>
*     (printout t ?c1 ?c2 ?c3 ?c4 ?c5 " ")
* )
*
* @param ?string the word being anagrammed
*/
(deffunction buildAnagram(?string)

   (bind ?ruleString "(defrule anagram ") ; string being built
   (for (bind ?i 1) (>= (str-length ?string) ?i) (++ ?i)
      (bind ?addString (str-cat "(Letter (c ?c" ?i ") (p ?p")) ; same for every assertion line
      (for (bind ?j ?i) (>= ?j 1) (-- ?j)
         (if (= ?j 1) then (bind ?addString2 (str-cat ?j "))")) ; if at last element, close assertions
          else (bind ?addString2 (str-cat ?j "&~?p")) ; else continue to compare this Letter's position with previous
         )
         (bind ?addString (str-cat ?addString ?addString2))
      )
      (bind ?ruleString (str-cat ?ruleString ?addString)) 
   )

   (bind ?printString "=> (printout t ")
   (for (bind ?i 1) (>= (str-length ?string) ?i) (++ ?i)
      (bind ?addString (str-cat "?c" ?i " ")) ; add as many characters needed to be printed per anagram
      (bind ?printString (str-cat ?printString ?addString))
   )

   (bind ?ruleString (str-cat ?ruleString ?printString "(space)" "))")) ; combine RHS and LHS of rule

   (build ?ruleString) ; reads the ?ruleString as if it were inputted into command line

)

/**
* Prints a space out, used in the string being built in buildAnagram(?string) to space out each anagram
* @return a space in text
*/
(deffunction space()

   (return " ")

)
