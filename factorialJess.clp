(batch utilities_v3.clp)
/**
* Ethan Wong
* August 25, 2022
* Will calculate the factorial that the user inputs
*/

/**
* Calculates the factorial of an inputted number
* @param ?num the number of the factorial being calculated
* @return the factorial fo the number being inputted
*/
(deffunction fact (?num)
   (if (= ?num 0) then (return 1)
    else  (return (* ?num(fact(-- ?num)))))
) 

/**
* Prompts the user for a number then calculates the factorial of the number, continues
* for as long as the user wishes
* @return the factorial of the number being inputted
*/
(deffunction factorial()

   (bind ?play (askline "Would you like to calculate the factorial of a number? (say yes) "))
   
   (while (= ?play "yes")
      (bind ?factNum (askline "Input a number to calculate its factorial "))
      
      (if (isFactorializable ?factNum) then 
         (bind ?answer (long (float (fact ?factNum)))) ; must cast to float first b/c can't cast long to long
         (printout t "Your factorial is: ")
         (printout t ?answer crlf) 
       else ((printout t "Please enter a valid number! ") 
            ) 
      ) 
      
      (bind ?play (askline "Would you like to play again?"))
    ) ; while (= ?play "yes")

   return "Goodbye!"
)

/**
* Validates that a number is possible to be factorialized (if that's a word)
* @param num the number being checked
* @return true if the number can be factorialzied; otherwise,
*         false
*/
(deffunction isFactorializable(?num)

   (bind ?a (> ?num 0))
   (bind ?b (numberp ?num))
   (bind ?c and(?a ?b))
   
   (bind ?numConc (integer ?num))
   (bind ?d (= ?num ?numConc))
   return (and ?c ?d)
)
         