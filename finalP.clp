/**
* Ethan Wong
* Expert: Ric Foley
* December 12, 2022
* A program evaluating the best pitch for a pitcher to throw depending on the circumstances
* The variables in whcih the program will use to make its' decision are :
*  1. The pitches the pitcher can throw
*  2. The pitcher and the batter's handedness
*  3. The batter's tendency to hit in a particular location on the plate
*  4. The pitch count
*  5. The previous pitches
*  6. The runenrs on the bases (only applicable if the outcome chosen by the user is an in-play ball)
*/

(reset)(run)

; backward chaining facts
(do-backward-chaining fastball)
(do-backward-chaining slider)
(do-backward-chaining curveball)
(do-backward-chaining changeUp)
(do-backward-chaining pitchHand)
(do-backward-chaining pitchCount)
(do-backward-chaining batHand)
(do-backward-chaining batTendency)
(do-backward-chaining prevPitch)
(do-backward-chaining outcome)
(do-backward-chaining first)
(do-backward-chaining second)
(do-backward-chaining third)

/**
* Asks a question and returns the first letter of the user's answer (lowercased)
* @param ?question the question being asked
*/
(deffunction shortAsk(?question)
   (bind ?answer (ask ?question))
   (bind ?a (sub-string 1 1 (lowcase ?answer)))
   (return ?a)
)

/**
* Asks a question and returns the first three letters of the user's answer (lowercased)
* @param ?question the question being asked
*/
(deffunction longAsk(?question)
   (bind ?answer (ask ?question))
   (bind ?a (sub-string 1 3 (lowcase ?answer)))
   (return ?a)
)

/**
* Stops the running of the game
*/
(deffunction STOP()
   (halt)
)

/**
* All rules below and above the next block comment are all:
* Rules asking about information about different circumstances of the game.
* Whatever the rule is asking for is the name of the rule itself (ie pitcher rule is asking about the pitcher)
*/

(defrule pitcher "Starts the program, asking the user about the pitcher"
   (need-fastball ?)
=>
   (bind ?str "Welcome to my program! I will be helping you determine the best pitch you should throw
based on the circumstances you give me. Before anything, I would like to know more about 
the pitcher that I will be helping.")
   (printout t ?str crlf)
   (printout t "" crlf)

   (printout t "First, I need to know what kinds of pitches this pitcher can throw!" crlf)

   (printout t "For the following questions, simply type y if yes and n if no: " crlf)

   (bind ?q1 "Can they throw a 4seam fastball? ")
   (bind ?a1 (shortAsk ?q1))
   (while (not (or (= ?a1 "y") (= ?a1 "n")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a1 (shortAsk ?q1))
   )
   (assert (fastball ?a1))

   (bind ?q3 "Can they throw a curveball? ")
   (bind ?a3 (shortAsk ?q3))
   (while (not (or (= ?a3 "y") (= ?a3 "n")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a3 (shortAsk ?q3))
   )
   (assert (curveball ?a3))
   
   (bind ?q4 "Can they throw a slider? ")
   (bind ?a4 (shortAsk ?q4))
   (while (not (or (= ?a4 "y") (= ?a4"n")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a4 (shortAsk ?q4))
   )
   (assert (slider ?a4))

   (bind ?q5 "Can they throw a changeUp? ")
   (bind ?a5 (shortAsk ?q5))
   (while (not (or (= ?a5 "y") (= ?a5 "n")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a5 (shortAsk ?q5))
   )
   (assert (changeUp ?a5))

   (printout t "Great! Now that I know what pitches they can throw. (or can't)" crlf)

   (bind ?q8 "Next, what is the hand the pitcher throws with? Answer with either left or right. ")
   (bind ?a8 (shortAsk ?q8))
   (while (not (or (= ?a8 "l") (= ?a8 "r")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a8 (shortAsk ?q8))
   )
   (assert (pitchHand ?a8))

) ; (defrule pitcher "Starts the program, asking the user about the pitcher"

(defrule pCount "Asks the user for the pitch count of the current at bat"
   (need-pitchCount ?)
=>
   (bind ?q1 "What is the pitch count of the current at bat? Answer with a two digit number (ie one ball and no strikes will be 10")
   (bind ?a1 (shortAsk ?q1))
   (while (not (or (> ?a1 0) (< ?a1 32)))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a1 (shortAsk ?q1))
   )
   (assert (pitchCount ?a1))
)

(defrule batter "Asks the user about the batter the pither is up against"
   (need-batHand ?)
=>
   (printout t "Now, I will ask some questions to get to know the batter I'm up against. " crlf)
   (bind ?q1 "What is the batter's dominant hand? Answer with either left or right. ")
   (bind ?a1 (shortAsk ?q1))
   (while (not (or (= ?a1 "l") (= ?a1 "r")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a1 (shortAsk ?q1))
   )
   (assert (batHand ?a1))

   (bind ?q2 "What location does the batter have a tendency to swing at? Answer with high, middle, low, inside, or outside. ")
   (bind ?a2 (shortAsk ?q2))
   (while (not (or (= ?a2 "h") (= ?a2 "m") (= ?a2 "l") (= ?a2 "i") (= ?a2 "o")))
      (printout t "It seems your answer is invalid, please try again" crlf)
      (bind ?a2 (ask ?q2))
   )
   (assert (batTendency ?a2))
) ; (defrule batter "Asks the user about the batter the pither is up against"

(defrule prevPitch "Asks the user about the previous pitch thrown and its' outcome (if applicable)"
   (need-prevPitch ?)
=>
   (bind ?yOn "Were there previous pitches thrown before the pitch I'm evaluating? ")
   (bind ?yOnAnswer (shortAsk ?yOn))

   (while (not (or (= ?yOnAnswer "y") (= ?yOnAnswer "n")))
      (printout t "It seems your answer is invalid. Please try again.")
      (bind ?yOnAnswer (shortAsk ?yOn))
   )

   (assert (prevPitch ?yOnAnswer))
) ; (defrule prevPitch "Asks the user about the previous pitch thrown and its' outcome (if applicable)"

(defrule outcome "Asks the user about the kind of outcome desired from the pitch"
   (need-outcome ?)
=>
   (printout t "Now, I will ask about what you want to achieve with this pitch. " crlf)

   (bind ?q1 "Do you want this pitch to result in a groundout, popout, ball, or strike? Answer with either groundout, popout, ball, or strike. ")
   (bind ?a1 (shortAsk ?q1))
   (while (not (or (= ?a1 "g") (= ?a1 "p") (= ?a1 "b") (= ?a1 "s")))
      (printout t "It seems your answer is invalid. Please try again." crlf)
      (bind ?a1 (shortAsk ?q1))
   )
   (assert (outcome ?a1))
)

(defrule runnners "Asks the user about the runners on base"
   (need-first ?)
=>
   (printout t "Now, I will ask about the runners on the bases" crlf)

   (bind ?q1 "Is there a runner on first? Answer with either yes or no. ")
   (bind ?a1 (shortAsk ?q1))
   (while (not (or (= ?a1 "y") (= ?a1 "n")))
      (printout t "It seems your answer is invalid. Please try again." crlf)
      (bind ?a1 (shortAsk ?q1))
   )
   (if (= ?a1 "y") then (assert (first "y")))
   (if (= ?a1 "n") then (assert (first "n")))

   (bind ?q2 "Is there a runner on second? Answer with either yes or no. ")
   (bind ?a2 (shortAsk ?q2))
   (while (not (or (= ?a2 "y") (= ?a2 "n")))
      (printout t "It seems your answer is invalid. Please try again." crlf)
      (bind ?a2 (shortAsk ?q2))
   )
   (if (= ?a2 "y") then (assert (second "y")))
   (if (= ?a2 "n") then (assert (second "n")))

   (bind ?q3 "Is there a runner on third? Answer with either yes or no. ")
   (bind ?a3 (shortAsk ?q3))
   (while (not (or (= ?a3 "y") (= ?a3 "n")))
      (printout t "It seems your answer is invalid. Please try again." crlf)
      (bind ?a3 (shortAsk ?q3))
   )
   (if (= ?a3 "y") then (assert (third "y")))
   (if (= ?a3 "n") then (assert (third "n")))

) ; (defrule runnners "Asks the user about the runners on base"

/**
* All rules below are fired from the asserted facts in the rules above.
* Each rule's name indicates the situation and/or the pitch the program has evaluated to occur
**/

(defrule noPitches "Rule fired when the pitcher can't throw any pithces"
   (fastball "n")
   (curveball "n")
   (slider "n")
   (changeUp "n")
   (pitchHand "r")
=>
   (printout t "" crlf)
   (bind ?str "It seems you don't know how to throw any pithces! I'm afraid I can't help you. Please come back
when you at least know how to throw a fastball. Here is a link teaching you how to : https://www.baseballbible.net/how-to-throw-a-fastball/")
   (printout t ?str crlf)
   (STOP)
)

(defrule noPitches2 "Rule fired when the pitcher can't throw any pithces"
   (fastball "n")
   (curveball "n")
   (slider "n")
   (changeUp "n")
   (pitchHand "l")
=>
   (printout t "" crlf)
   (bind ?str "It seems you don't know how to throw any pithces! I'm afraid I can't help you. Please come back
when you at least know how to throw a fastball. Here is a link teaching you how to : https://www.baseballbible.net/how-to-throw-a-fastball/")
   (printout t ?str crlf)
   (STOP)
)

(defrule highSetUp "Rule determining if the pitcher should throw a high setup fastball"
   (fastball "y")
   (outcome "b")
   (batTendency "h")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a ball and our batter has a high tendency
   to hit balls above the strike zone, I would suggest throwing an eye level fastball. Since the batter may chase the 
   ball and swing at it, resulting in a swinging strike or a weakly hit ball. However, the pitch can be useful even if the
   batter chooses not to swing, as the high pitch will change the batter's line of sight and may cause them to misjudge lower pitches
   within the strike zone later in the count.")
   (printout t ?str crlf)
   (STOP)
)

(defrule fastballMiddle "Rule determining if the pitcher should throw a fastball down the middle"
   (fastball "y")
   (outcome "s")
   (prevPitch "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a strike and it's the first pitch of the at bat, I would suggest throwing a 4seam fastball
   right down the middle. Although it may seem easily predictable, many teams have a 'golden rule', stating that a batter must not swing 
   unless a strike has already occurred in the at bat. This rule exists to ensure that batters can see how a specific pitcher throws pitches 
   to get a better judgement on the timing and speed needed to hit the ball. Therefore, throwing a fastball down the middle as the first
   pitch of the at bat may be your best option to quickly get ahead in the account with the golden rule in place.")
   (printout t ?str crlf)
   (STOP)
)

(defrule fastballMiddle2 "Rule determining if the pitcher should throw a fastball down the middle"
   (fastball "y")
   (pitchHand "l")
   (outcome "s")
   (batHand "r")
   (batTendency "i")
   (prevPitch "y")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a strike and you and the batter are opposite handed with the batter having a 
tendency to hit balls inside the plate, I would suggest throwing a fastball down the middle. When a batter and pitcher are 
opposite handed, when the ball gets released, batters usually see the illusion that the ball has a natural curve towards them. 
Therefore, placing a pitch in the middle of the plate will make the batter eager to swing as they think that the ball is moving
towards them to the inside portion of the plate. Along with the fact that the batter likes to hit balls closer to them, the placing 
of the pitch being more away than they would think will cause them to be unable to hit the ball.")
   (printout t ?str crlf)
   (STOP)
   
)

(defrule fastballMiddle3 "Rule determining if the pitcher should throw a fastball down the middle"
   (fastball "y")
   (pitchHand "r")
   (outcome "s")
   (batHand "l")
   (batTendency "i")
   (prevPitch "y")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a strike and you and the batter are opposite handed with the batter having a 
tendency to hit balls inside the plate, I would suggest throwing a fastball down the middle. When a batter and pitcher are 
opposite handed, when the ball gets released, batters usually see the illusion that the ball has a natural curve towards them. 
Therefore, placing a pitch in the middle of the plate will make the batter eager to swing as they think that the ball is moving
towards them to the inside portion of the plate. Along with the fact that the batter likes to hit balls closer to them, the placing 
of the pitch being more away than they would think will cause them to be unable to hit the ball.")
   (printout t ?str crlf)
   (STOP)
   
)

(defrule fastballInside "Rule determining if the pitcher should throw a fastball inside"
   (fastball "y")
   (pitchHand "r")
   (outcome "b")
   (batHand "r")
   (batTendency "m")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a ball and both you and the batter are right handed with the batter having a tendency
to hit balls in the middle of the plate, I would suggest throwing an inside fastball outside the strike zone towards the batter. 
When batters and pitchers are the same handedness, when the ball gets released, batters usually see the illusion that the ball has 
a natural curve away from the them. Therefore, placing a pitch inside will make the batter eager to swing as they think the ball is 
moving towards the middle of the strike zone. Along with the fact that the batter likes to hit balls in the middle of the plate, the 
placing of the pitch being closer than they would anticipate will cause them to be unable to hit the ball.")
   (printout t ?str crlf)
   (STOP)
)

(defrule fastballInside2 "Rule determining if the pitcher should throw a fastball inside"
   (fastball "y")
   (pitchHand "l")
   (outcome "b")
   (batHand "l")
   (batTendency "m")
   
=>
   (printout t "" crlf)  
   (bind ?str "Since you would like to throw a ball and both you and the batter are right handed with the batter having a tendency
to hit balls in the middle of the plate, I would suggest throwing an inside fastball outside the strike zone towards the batter. 
When batters and pitchers are the same handedness, when the ball gets released, batters usually see the illusion that the ball has 
a natural curve away from the them. Therefore, placing a pitch inside will make the batter eager to swing as they think the ball is 
moving towards the middle of the strike zone. Along with the fact that the batter likes to hit balls in the middle of the plate, the 
placing of the pitch being closer than they would anticipate will cause them to be unable to hit the ball.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutPullFastballLowInside "Rule determining if the pitcher should throw a fastball low and inside"
   (fastball "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
   (first "n")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a same handed batter with a tendency to hit balls in the
middle of the plate, I would suggest throwing a fastball low and inside. Since the batter regularly hits balls in the middle of the 
plate, pitches coming inside will hit the bat sooner, while the low placement of the ball will cause the batter to get on top of the 
ball instead of making direct contact if he were to swing at a pitch right down the middle, pushing the ball to the ground")
   (printout t ?str crlf)
   (STOP)

)

(defrule groundoutPullFastballLowInside2 "Rule determining if the pitcher should throw a fastball low and inside"
   (fastball "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
   (first "n")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a same handed batter with a tendency to hit balls in the
middle of the plate, I would suggest throwing a fastball low and inside. Since the batter regularly hits balls in the middle of the 
plate, pitches coming inside will hit the bat sooner, while the low placement of the ball will cause the batter to get on top of the 
ball instead of making direct contact if he were to swing at a pitch right down the middle, pushing the ball to the ground")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideDoubleplay "Rule determining if the pitcher should throw a fastball to get a double play by the batter pulling the ball"
   (fastball "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
   (first "y")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a right handed batter with a tendency to hit balls in the middle of the plate
while there’s one runner on first base, I would suggest throwing a low inside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed inside the plate and closer to the batter will cause a swing that will hit a pitch 
down the middle to be hit earlier than intended, pulling the ball towards the shortstop side of the field. And since there’s a runner on first,
a groundball to that side of the field will result in an easy double play, getting both runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideDoubleplay2 "Rule determining if the pitcher should throw a fastball to get a double play by the batter pulling the ball"
   (fastball "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
   (first "y")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on right handed batter with a tendency to hit balls in the middle of the plate
while there’s one runner on first base, I would suggest throwing a low inside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed inside the plate and closer to the batter will cause a swing that will hit a pitch 
down the middle to be hit earlier than intended, pulling the ball towards the shortstop side of the field. And since there’s a runner on first,
a groundball to that side of the field will result in an easy double play, getting both runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideDoublePlay3 "Rule determining if the pitcher should throw a fastball to get a double play by the batter pulling the ball"
   (fastball "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
   (first "y")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a left handed batter with a tendency to hit balls in the middle of the plate
while there’s one runner on first base, I would suggest throwing a low outside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed outside the plate and away from the batter will cause a swing that will hit a pitch 
down the middle to be hit later than intended, pushing the ball towards the shortstop side of the field. And since there’s a runner on first,
a groundball to that side of the field will result in an easy double play, getting both runners out.")
   (printout t ?str crlf)
   (STOP)

)

(defrule groundoutShortsideDoublePlay4 "Rule determining if the pitcher should throw a fastball to get a double play by the batter pulling the ball"
   (fastball "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
   (first "y")
   (second "n")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a left handed batter with a tendency to hit balls in the middle of the plate
while there’s one runner on first base, I would suggest throwing a low outside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed outside the plate and away from the batter will cause a swing that will hit a pitch 
down the middle to be hit later than intended, pushing the ball towards the shortstop side of the field. And since there’s a runner on first,
a groundball to that side of the field will result in an easy double play, getting both runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideTriplePlay "Rule determining if the pitcher should throw a fastball to get a triple play"
   (fastball "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
   (first "y")
   (second "y")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a right handed batter with a tendency to hit balls in the middle of the plate
while there’s runners on first and second base, I would suggest throwing a low inside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed inside the plate and closer to the batter will cause a swing that will hit a pitch 
down the middle to be hit earlier than intended, pulling the ball towards the shortstop side of the field. And since there’s runners on first 
and second, a groundball to that side of the field will result in a possible triple play, getting all runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideTriplePlay2 "Rule determining if the pitcher should throw a fastball to get a triple play"
   (fastball "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
   (first "y")
   (second "y")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a right handed batter with a tendency to hit balls in the middle of the plate
while there’s runners on first and second base, I would suggest throwing a low inside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed inside the plate and closer to the batter will cause a swing that will hit a pitch 
down the middle to be hit earlier than intended, pulling the ball towards the shortstop side of the field. And since there’s runners on first 
and second, a groundball to that side of the field will result in a possible triple play, getting all runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideTriplePlay3 "Rule determining if the pitcher should throw a fastball to get a triple play"
   (fastball "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
   (first "y")
   (second "y")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a left handed batter with a tendency to hit balls in the middle of the plate
while there’s runners on first and second base, I would suggest throwing a low outside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed outside the plate and away from the batter will cause a swing that will hit a pitch 
down the middle to be hit later than intended, pushing the ball towards the shortstop side of the field. And since there’s a runner on first 
and second, a groundball to that side of the field will result in a possible triple play, getting all runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule groundoutShortsideTriplePlay4 "Rule determining if the pitcher should throw a fastball to get a triple play"
   (fastball "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
   (first "y")
   (second "y")
   (third "n")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a left handed batter with a tendency to hit balls in the middle of the plate
while there’s runners on first and second base, I would suggest throwing a low outside fastball. The low placement of the ball will cause the 
batter who likes to swing at balls in the middle of the plate to have their barrel make contact above the ball, pushing the ball down towards
the ground. Furthermore, the pitch being placed outside the plate and away from the batter will cause a swing that will hit a pitch 
down the middle to be hit later than intended, pushing the ball towards the shortstop side of the field. And since there’s a runner on first 
and second, a groundball to that side of the field will result in a possible triple play, getting all runners out.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderSwingingStrike "Rule determining if the pitcher should throw a slider strike"
   (slider "y")
   (pitchHand "r")
   (outcome "s")
   (batHand "r")
   (batTendency "i")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a strike on a batter with the same handedness (right) and a tendency to hit balls inside the plate, I would
suggest throwing a slider to the middle of the plate. The trajectory of the slider slants downward as it approaches the plate, meaning
that a batter with the same handedness will initially see the ball approaching the inside portion portion of the plate and will be unable
to react to the change in direction of the ball, causing them to swing at a ball they anticipate is inside when in reality the pitch
will be down and away from their bat.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderSwingingStrike2 "Rule determining if the pitcher should throw a slider strike"
   (slider "y")
   (pitchHand "l")
   (outcome "s")
   (batHand "l")
   (batTendency "i")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a strike on a batter with the same handedness (left) and a tendency to hit balls inside the plate, I would
suggest throwing a slider to the middle of the plate. The trajectory of the slider slants downward and away as it approaches the plate, meaning
that a batter with the same handedness will initially see the ball approaching the inside portion portion of the plate and will be unable
to react to the change in direction of the ball, causing them to swing at a ball they anticipate is inside when in reality the pitch
will be down and away from their bat.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderGroundout "Rule determining if the pither should throw a slider for a groundout"
   (slider "y")
   (pitchHand "r")
   (outcome "g")
   (batHand "r")
   (batTendency "m")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a batter with the same handedness (right) and a tendency to hit balls down the middle of the plate,
I would suggest throwing a slider towards the outside of the plate. Since the trajectory of a slider slants downward and away as it approaches 
the plate, batters would initially think that the pitch is near the middle, however as the slider follows its’ route the batter’s
Swing will make contact on top of the ball, hitting it to the ground.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderGroundout2 "Rule determining if the pither should throw a slider for a groundout"
   (slider "y")
   (pitchHand "l")
   (outcome "g")
   (batHand "l")
   (batTendency "m")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a groundout on a batter with the same handedness (right) and a tendency to hit balls down the middle of the plate,
I would suggest throwing a slider towards the outside of the plate. Since the trajectory of a slider slants downward and away as it approaches 
the plate, batters would initially think that the pitch is near the middle, however as the slider follows its’ route the batter’s
Swing will make contact on top of the ball, hitting it to the ground.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderLookingStrike "Rule determining if the pitcher should throw a slider for a strike"
   (slider "y")
   (pitchHand "r")
   (outcome "s")
   (batHand "r")
   (batTendency "m")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a strike on a batter with the same handedness (right) and a tendency to hit balls down the middle, I would suggest
Throwing a slider to the middle of the plate. Since the trajectory of a slider slants downward and away as it approaches the plate,
Batters would initially think that the pitch is inside, however as the slider follows its’ route the pitch will eventually reach the strike zone.
Furthermore you and the batter both being right handed exaggerates the release point of the slider to make the pitch seem even more close
To the batter than it actually is, further making the batter believe that the pitch isn’t in the strike zone.")
   (printout t ?str crlf)
   (STOP)
)

(defrule sliderLookingStrike2 "Rule determining if the pitcher should throw a slider for a strike"
   (slider "y")
   (pitchHand "l")
   (outcome "s")
   (batHand "l")
   (batTendency "m")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to get a strike on a batter with the same handedness (left) and a tendency to hit balls down the middle, I would suggest
Throwing a slider to the middle of the plate. Since the trajectory of a slider slants downward and away as it approaches the plate,
Batters would initially think that the pitch is inside, however as the slider follows its’ route the pitch will eventually reach the strike zone.
Furthermore you and the batter both being right handed exaggerates the release point of the slider to make the pitch seem even more close
To the batter than it actually is, further making the batter believe that the pitch isn’t in the strike zone.")
   (printout t ?str crlf)
   (STOP)
)

(defrule curveballSwingStrike "Rule determining if the pitcher should throw a curveball for a strike"
   (curveball "y")
   (pichHand "r")
   (outcome "s")
   (batHand "r")
   (batTendency "h")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a strike on a batter with the same handedness (right) with a tendency to hit balls above the strike zone, 
I would suggest throwing a curveball to the middle of the plate. Since the trajectory of a curveball starts high and eventually drops as it reaches the 
plate, batters would initially anticipate the pitch being above the strike zone, and will be unable to react to the change in level of the ball.")
   (printout t ?str crlf)
   (STOP)
)

(defrule curveballSwingStrike2 "Rule determining if the pitcher should throw a curveball for a strike"
   (curveball "y")
   (pichHand "l")
   (outcome "s")
   (batHand "l")
   (batTendency "h")
=>
   (printout t "" crlf)
   (bind ?str "Since you would like to throw a strike on a batter with the same handedness (left) with a tendency to hit balls above the strike zone, 
I would suggest throwing a curveball to the middle of the plate. Since the trajectory of a curveball starts high and eventually drops as it reaches the 
plate, batters would initially anticipate the pitch being above the strike zone, and will be unable to react to the change in level of the ball.")
  (printout t ?str crlf)
   (STOP)
)

(defrule nothing
   (fastball "y")
   (slider "y")
   (curveball "y")
   (changeUp "y")
=>
   (printout t "Looks like I'm not sure what pitch you should throw. Best bet is to just throw a fastball down the middle and hope for the best!" crlf)
   (STOP)
)


