/**
* Ethan Wong
* October 4, 2022
* Plays 20 questions trying to guess an animal
*/

; global variable counting the number of questions asked, will stop game at 20
(defglobal ?*count* = 0)

; backward chaining facts
(do-backward-chaining land)
(do-backward-chaining mammal)
(do-backward-chaining carnivore)
(do-backward-chaining ocean)
(do-backward-chaining fly)
(do-backward-chaining reptile)
(do-backward-chaining cephalopod)
(do-backward-chaining marsupial)
(do-backward-chaining insect)
(do-backward-chaining herbivore)
(do-backward-chaining omnivore)
(do-backward-chaining fur)
(do-backward-chaining patterns)
(do-backward-chaining colorful)
(do-backward-chaining scales)
(do-backward-chaining domestic)
(do-backward-chaining bigger)
(do-backward-chaining horns)
(do-backward-chaining farm)
(do-backward-chaining fourLegs)
(do-backward-chaining tentacles)
(do-backward-chaining ink)
(do-backward-chaining food)
(do-backward-chaining climb)
(do-backward-chaining claws)
(do-backward-chaining tail)
(do-backward-chaining nocturnal)
(do-backward-chaining hoots)
(do-backward-chaining neck)
(do-backward-chaining bird)
(do-backward-chaining honey)
(do-backward-chaining stings)
(do-backward-chaining loud)
(do-backward-chaining light)
(do-backward-chaining shell)
(do-backward-chaining landAndWater)
(do-backward-chaining freshWater)
(do-backward-chaining saltWater)
(do-backward-chaining uShaped)
(do-backward-chaining vShaped)
(do-backward-chaining cetacean)
(do-backward-chaining tusks)
(do-backward-chaining feathers)
(do-backward-chaining wings)

/**********************************
* ALL THE RULES BELOW BUT ABOVE THE NEXT BLOCK COMMENT FOLLOW
* "Rule to see if it('s) (x characteristic)" COMMENT,
* AND ARE RULES ASKING USERS IF ANIMAL HAS A CERTAIN TRAIT 
*
* EX)
* FOR THE RULE livesOnLand THE CORRESPONDING COMMENT WILL BE:
* "Rule to see if it lives on land"
***********************************/

/**
* All need rules follow this structure:
* LHS - 1.need-fact 2.exclusionary conditions (if needed)
* RHS - 1.add to question counter 2.bind question being asked 3.ask question and assert response
*/

(defrule livesOnLand "Asks if it lives on land"
   (need-land) 
   (not (ocean))
   (not (landAndWater))
=>
   (++ ?*count*)
   (bind ?q "live specifically on land")
   (if (askDoesIt ?q) then (assert (land)))
)

(defrule isAMammal "Asks if it's a mammal"
   (need-mammal)
   (not (bird))
   (not (insect))
   (not (reptile))
=>
   (++ ?*count*)
   (bind ?q "a mammal")
   (if (askIsIt ?q) then (assert (mammal)))
)

(defrule isACarnivore "Asks if it's a carnivore"
   (need-carnivore)
   (not (herbivore))
   (not (omnivore))
=>
   (++ ?*count*)
   (bind ?q "a carnivore")
   (if (askIsIt ?q) then (assert (carnivore)))
)

(defrule livesInOcean "Asks if it lives in the ocean"
   (need-ocean)
   (not (land))
   (not (landAndWater))
=>
   (++ ?*count*)
   (bind ?q "live specifically in the ocean")
   (if (askDoesIt ?q) then (assert (ocean)))
)

(defrule livesOnBoth "Asks if it lives both on land and water"
   (need-landAndWater)
=>
   (++ ?*count*)
   (printout t "Think of an animal. I'll play 20 questions trying to guess it" crlf)
   (printout t "Input y if answer is yes, n if the answer is no, u if unknown. Flying animals live on land." crlf)
   (bind ?q "live on both land and water")
   (if (askDoesIt ?q) then (assert (landAndWater)))
)

(defrule flies "Asks if it flies if it lives on land"
   (need-fly)
=>
   (++ ?*count*)
   (bind ?q "fly")
   (if (askDoesIt ?q) then (assert (fly)))
)

(defrule isReptile "Asks if it's a reptile"
   (need-reptile)
=>
   (++ ?*count*)
   (bind ?q "a reptile")
   (if (askIsIt ?q) then (assert (reptile)))
)

(defrule isACephalopod "Asks to see if it's a cephalopod"
   (need-cephalopod)
   (not (cetacean))
=>
   (++ ?*count*)
   (bind ?q "a cephalopod")
   (if (askIsIt ?q) then (assert (cephalopod)))
)

(defrule marsupials "Asks if it's a marsupial"
   (need-marsupial)
=>
   (++ ?*count*)
   (bind ?q "a marsupial")
   (if (askIsIt ?q) then (assert (marsupial)))
)

(defrule isInsect "Asks if it's an insect"
   (need-insect)
=>
   (++ ?*count*)
   (bind ?q "an insect")
   (if (askIsIt ?q) then (assert (insect)))
)

(defrule isACetacean "Asks if it's a cetacea"
   (need-cetacean)
=>
   (++ ?*count*)
   (bind ?q "a cetacean")
   (if (askIsIt ?q) then (assert (cetacean)))
)

(defrule isHerbivore "Asks if it's a herbivore"
   (need-herbivore)
   (not (omnivore))
   (not (carnivore))
=>
   (++ ?*count*)
   (bind ?q "a herbivore")
   (if (askIsIt ?q) then (assert (herbivore)))
)

(defrule isOmnivore "Asks if it's an omnivore"
   (need-omnivore)
   (not (carnivore))
   (not (herbivore))
=>
   (++ ?*count*)
   (bind ?q "an omnivore")
   (if (askIsIt ?q) then (assert (omnivore)))
)

(defrule haveFur "Asks if it has fur"
   (need-fur)
=>
   (++ ?*count*)
   (bind ?q1 "has fur")
   (if (askDoesIt ?q1) then (assert (fur)))
)

(defrule havePatterns "Asks if it's body has patterns"
   (need-patterns)
=>
   (++ ?*count*)
   (bind ?q "have patterns on its' body")
   (if (askDoesIt ?q) then (assert (patterns)))
)

(defrule differentColor "Asks if it has different colors on its' body"
   (need-colorful)
=>
   (++ ?*count*)
   (bind ?q "colorful (more than two colors)")
   (if (askIsIt ?q) then (assert (colorful)))
)

(defrule haveScales "Asks if it has scales"
   (need-scales)
=>
   (++ ?*count*)
   (bind ?q "has scales")
   (if (askDoesIt ?q) then (assert (scales)))
)

(defrule showUpDomestically "Asks if it shows up domestically"
   (need-domestic)
=>
   (++ ?*count*)
   (bind ?q "commonly show up domestically (pets)")
   (if (askDoesIt ?q) then (assert (domestic)))
)

(defrule biggerThanHumans "Asks if it's bigger than huamns"
   (need-bigger)
=>
   (++ ?*count*)
   (bind ?q "bigger than humans")
   (if (askIsIt ?q) then (assert (bigger)))
)

(defrule horns "Asks if it has horns"
   (need-horns)
=>
   (++ ?*count*)
   (bind ?q "have horns")
   (if (askDoesIt ?q) then (assert (horns)))
)

(defrule tusks "Asks if it has tusks"
   (need-tusks)
=>
   (++ ?*count*)
   (bind ?q "have tusks")
   (if (askDoesIt ?q) then (assert (tusks)))
)

(defrule farm "Asks if they're used to help farm"
   (need-farm)
=>
   (++ ?*count*)
   (bind ?q "help on farms")
   (if (askDoesIt ?q) then (assert (farm)))
)

(defrule fourLegs "Asks if it has four legs"
   (need-fourLegs)
=>
   (++ ?*count*)
   (bind ?q "have four legs")
   (if (askDoesIt ?q) then (assert (fourLegs)))
)

(defrule tentacles "Asks if it has tentacles"
   (need-tentacles)
=>
   (++ ?*count*)
   (bind ?q "have tentacles")
   (if (askDoesIt ?q) then (assert (tentacles)))
)

(defrule sprayInk "Asks if it sprays ink"
   (need-ink)
=>
   (++ ?*count*)
   (bind ?q "spray ink")
   (if (askDoesIt ?q) then (assert (ink)))
)

(defrule humansEat "Asks if it's humans eat them regularly"
   (need-food)
=>
   (++ ?*count*)
   (bind ?q "eaten by humans regularly")
   (if (askIsIt ?q) then (assert (food)))
)

(defrule climb "Asks if it can climb"
   (need-climb)
=>
   (++ ?*count*)
   (bind ?q "climb")
   (if (askDoesIt ?q) then (assert (climb)))
)

(defrule claws "Asks if it has claws" 
   (need-claws)
=>
   (++ ?*count*)
   (bind ?q "have claws")
   (if (askDoesIt ?q) then (assert (claws)))
)

(defrule tail "Asks if it has a tail"
   (need-tail)
=>
   (++ ?*count*)
   (bind ?q "have a tail")
   (if (askDoesIt ?q) then (assert (tail)))
)

(defrule nocturnal "Asks if it's nocturnal"
   (need-nocturnal)
=>
   (++ ?*count*)
   (bind ?q "nocturnal")
   (if (askIsIt ?q) then (assert (nocturnal)))
)

(defrule hoots "Asks if it hoots"
   (need-hoots)
=>
   (++ ?*count*)
   (bind ?q "hoot")
   (if (askDoesIt ?q) then (assert (hoots)))
)

(defrule turnNeck "Asks if it can turn its' neck"
   (need-neck)
=>
   (++ ?*count*)
   (bind ?q "turn its' neck more then 180 degrees")
   (if (askDoesIt ?q) then (assert (neck)))
)

(defrule bird "Asks if it is a bird"
   (need-bird)
   (not (mammal))
   (not (insect))
=>
   (++ ?*count*)
   (bind ?q "a bird")
   (if (askIsIt ?q) then (assert (bird)))
)

(defrule honey "Asks if it makes honey"
   (need-honey)
=>
   (++ ?*count*)
   (bind ?q "make honey")
   (if (askDoesIt ?q) then (assert (honey)))
)

(defrule stings "Asks if it stings"
   (need-stings)
=>
   (++ ?*count*)
   (bind ?q "sting")
   (if (askDoesIt ?q) then (assert (stings)))
)

(defrule loud "Asks if they're loud"
   (need-loud)
=>
   (++ ?*count*)
   (bind ?q "make a lot of noise")
   (if (askDoesIt ?q) then (assert (loud)))
)

(defrule light "Asks if it lights up"
   (need-light)
=>
   (++ ?*count*)
   (bind ?q "emit light")
   (if (askDoesIt ?q) then (assert (light)))
)

(defrule shell "Asks if it has a shell"
   (need-shell)
=>
   (++ ?*count*)
   (bind ?q "have a shell")
   (if (askDoesIt ?q) then (assert (shell)))
)

(defrule freshWater "Asks if it lives in fresh water"
   (need-freshWater)
   (or (ocean) (landAndWater))
=>
   (++ ?*count*)
   (bind ?q "live in fresh water")
   (if (askDoesIt ?q) then (assert (freshWater)))
)

(defrule saltWater "Asks if it lives in salt water"
   (need-saltWater)
   (or (ocean) (landAndWater))
=>
   (++ ?*count*)
   (bind ?q "lives in salt water")
   (if (askDoesIt ?q) then (assert (saltWater)))
)

(defrule uShapedSnout "Asks if it has a U-shaped snout"
   (need-uShaped)
=>
   (++ ?*count*)
   (bind ?q "have a U-shaped snout")
   (if (askDoesIt ?q) then (assert (uShaped)))
)

(defrule vShapedSnout "Asks if it has a V-shaped snout"
   (need-vShaped)
=>
   (++ ?*count*)
   (bind ?q "have a V-shaped snout")
   (if (askDoesIt ?q) then (assert (vShaped)))
)

(defrule feathers "Asks if it has feathers"
   (need-feathers)
=>
   (++ ?*count*)
   (bind ?q "have feathers")
   (if (askDoesIt ?q) then (assert (feathers)))
)

(defrule wings "Asks if it has wings"
   (need-wings)
=>
   (++ ?*count*)
   (bind ?q "have wings")
   (if (askDoesIt ?q) then (assert (wings)))
)

/**********************************
* ALL THE FOLLOWING RULES (NOT METHODS) FOLLOW 
* "Rule to see if it's (x animal)" COMMENT,
* AND ARE RULES ASKING USERS IF THE PROGRAM'S GUESS IS CORRECT
*
* EX)
* FOR THE RULE isASquid THE CORRESPONDING COMMENT WILL BE:
* "Rule to see if it's a squid"
***********************************/

/**
* All guess rules follow this structure:
* LHS - 1.pattern of facts being the attributes the animal has (or doesn't have)
* RHS - 1.bind question 2.asks question and if correct, prints "I win!" 3.ends the game
*/

(defrule isASquid "Asks if it's a squid"
   (ocean) 
   (saltWater)
   (cephalopod)
   (carnivore) 
   (not (shell))
   (tentacles) 
   (ink) 
   (food) 
=>
   (bind ?q "a squid")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isANautilus "Asks if it's a nautilus"
   (ocean) 
   (saltWater)
   (cephalopod)
   (carnivore) 
   (shell)
   (tentacles)
=>
   (bind ?q "a nautilus")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isARhino "Asks if it's a rhino"
   (land) 
   (mammal) 
   (herbivore) 
   (fourLegs) 
   (bigger) 
   (horns) 
   (tail)
   (not (fur))
=>
   (bind ?q "a rhino")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAnOwl "Asks if it's an owl"
   (land)
   (bird)
   (wings)
   (fly)
   (bird)
   (carnivore)
   (nocturnal)
   (hoots)
   (neck)
=>
   (bind ?q "an owl")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAChicken "Asks if it's a chicken"
   (land)
   (bird)
   (wings)
   (fly)
   (omnivore)
   (feathers)
   (claws)
   (food)
   (loud)
=>
   (bind ?q "a chicken")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isATurkey "Asks if it's a turkey"
   (land)
   (bird)
   (wings)
   (fly)
   (omnivore)
   (feathers)
   (claws)
   (food)
   (not (loud))
=>
   (bind ?q "a turkey")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAFirefly "Asks if it's a firefly"
   (land)
   (insect)
   (omnivore)
   (fly)
   (not (stings))
   (not (loud))
   (light)
=>
   (bind ?q "a firefly")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isACricket "Asks if it's a cricket"
   (land)
   (insect)
   (omnivore)
   (fly)
   (stings)
   (loud)
   (not (light))
=>
   (bind ?q "a cricket")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAGazelle "Asks if it's a gazelle"
   (land) 
   (mammal) 
   (herbivore)
   (fourLegs) 
   (bigger) 
   (horns) 
   (tail)
   (fur)
=>
   (bind ?q "a gazelle")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isABee "Asks if it's a bee"
   (land)
   (insect)
   (herbivore)
   (fly)
   (stings)
   (farm)
   (patterns)
   (honey)
=>
   (bind ?q "a bee")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAnAlligator "Asks if it's an alligator"
   (landAndWater)
   (freshWater)
   (reptile)
   (carnivore)
   (scales)
   (bigger)
   (fourLegs)
   (claws)
   (uShaped)
=>
   (bind ?q "an alligator")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isACrocodile "Asks if it's a crcodile"
   (landAndWater)
   (saltWater)
   (reptile)
   (carnivore)
   (scales)
   (bigger)
   (fourLegs)
   (claws)
   (vShaped)
=>
   (bind ?q "a crocodile")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isAWhale "Asks if it's a whale"
   (ocean)
   (mammal)
   (carnivore)
   (cetacean)
   (tail)
   (bigger)
   (not (tusks))
=>
   (bind ?q "a whale")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

(defrule isANarwhal "Asks if it's a narwhal"
   (ocean)
   (mammal)
   (carnivore)
   (cetacean)
   (tail)
   (bigger)
   (tusks)
=>
   (bind ?q "a narwhal")
   (if (askIsIt ?q) then (printout t "I win!" crlf))
   (STOP)
)

; End of rules, start of functions

/**
* Asks a question starting with "Does it"
* @param ?question the question being asked
* @return true if the user says yes; otherwise,
*         false
*/
(deffunction askDoesIt(?question)
   (bind ?q FALSE)
   (bind ?question (str-cat "Does it " ?question "? "))
   (bind ?answer (ask ?question))
   (bind ?a (sub-string 1 1 (lowcase ?answer)))
   (if (= ?a "y") then (bind ?q TRUE))
   (return ?q)
)

/**
* Asks a question starting with "Is it"
* @param ?question the question being asked
* @return true if the user says yes; otherwise,
*         false
*/
(deffunction askIsIt(?question)
   (bind ?q FALSE)
   (bind ?question (str-cat "Is it " ?question "? "))
   (bind ?answer (ask ?question))
   (bind ?a (sub-string 1 1 (lowcase ?answer)))
   (if (= ?a "y") then (bind ?q TRUE))
   (return ?q)
)

/**
* Stops the running of the game
*/
(deffunction STOP()
   (halt)
)
