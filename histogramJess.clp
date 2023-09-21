/**
* Ethan Wong
* September 13, 2022
* A program that produces an alphabetic histogram for a given text
*/

/**
* Turns a string into a list of its' individual characters
* @param ?string the string being sliced
* @return the list of letters in the string
*/
(deffunction slice$(?string)

   (bind ?string (lowcase ?string))       
   (bind ?listString (create$))
   ( for (bind ?i 1) (>= (str-length ?string) ?i) (++ ?i)
      
      (bind ?subS (sub-string ?i ?i ?string))
      (bind ?listString (append$ ?listString ?subS))
   )

   (return ?listString) 

)

/**
* Converts a list containing strings to a list containing the ASCII representation of them
* @param ?listString the list being altered
* @return a new list with ASCII representations of the string in each index
*/
(deffunction listStringtoListASCII(?listString)

   ( for (bind ?i 1) (>= (length$ ?listString) ?i) (++ ?i)

      (bind ?iString (nth$ ?i ?listString))
      (bind ?stringASCII (asc ?iString))
      (bind ?listString (replace$ ?listString ?i ?i ?stringASCII))

   )

   (return ?listString)

)

/**
* Prompts the user for text and produces an alphabetic histogram from the given text
*/
(deffunction histo()
   
   (bind ?userString (askline "Input some text and I'll give you an alphabetic histogram representation : "))
   
   (bind ?listString (slice$ ?userString))
   (bind ?listASCII (listStringtoListASCII ?listString))

   (bind ?alphabetList (create$ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))

   ( for (bind ?i 1) (>= (length$ ?listASCII) ?i) (++ ?i)

      (bind ?ascIndex (- (nth$ ?i ?listASCII) 96))
      (if (and (>= ?ascIndex 1) (<= ?ascIndex 26)) then (bind ?alphabetList (replace$ ?alphabetList ?ascIndex ?ascIndex (+ (nth$ ?ascIndex ?alphabetList) 1)))
       else ()
      )
   )

   (printout t " " crlf)

   ( for (bind ?i 1) (>= (length$ ?alphabetList) ?i) (++ ?i)

      (printout t (asciiToChar (+ ?i 96)) " :")

      ( for (bind ?j 1) (>= (nth$ ?i ?alphabetList) ?j) (++ ?j)
         (printout t " |")
      )

      (printout t " ")
      (printout t (nth$ ?i ?alphabetList) crlf)
   )

   (return "Run this method to play again!")

)
