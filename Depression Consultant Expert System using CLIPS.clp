
(defrule initial "Getting User Deatils"
(not (Selected_Option ?))
=> 
(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%% Welcome To %%%%%%%%%%%%%%%%%%%%%%%%%%" crlf) 
(printout t crlf "               Depression Consultant Expert System             " crlf) 
(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
			
(printout t crlf "# This expert system is built to assist you preform self-Consultant of depression")
(printout t crlf "# Please answer the questions truthfully to obtain a correct Consultant" )
(printout t crlf "# Instructions:Choose the best answer for how you felt over the past week" crlf "# [Press 1 for Yes], [Press 2 for No]" )
(printout t crlf "# You will be asked to identify your name and answer 15 questions respectively."crlf"# At the end, you will get your result along with some relevant tips." crlf crlf crlf 
    "Please Enter Your Name: ")
			
(assert (User_Name (readline)))
(assert (Main_Menu On)))

(defrule Menu "Main Menu Of the Expert System"
(not (Selected_Option ?))
(Main_Menu On)
?retract_MM_On <- (Main_Menu On)
=>
(retract ?retract_MM_On)
(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"  crlf)
(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%% Main Menu %%%%%%%%%%%%%%%%%%%%%%%%%%%"  crlf) 
(printout t crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"  crlf crlf crlf
                  "Choose one of the problem areas from the list bellow" crlf crlf
 " 1:- Complete Depression CheckUp. " crlf crlf
 " 2:- Get information about Depression." crlf crlf
 " 3:- Exit" crlf crlf crlf
 " Enter Your Choice No: " )
(assert (Selected_Option (read))))

;; _______________________________________________________________________________________
;; ___________________________________ Category 1 Physical Issues ________________________________
;; _______________________________________________________________________________________

 (defrule Physical
 (User_Name ?name)
 (Selected_Option 1) 
 ?retract_Ch1 <- (Selected_Option 1)
 =>
(retract ?retract_Ch1)
(printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t  crlf "%%%%%%%%%%%%%%% Physical Issues - Verification %%%%%%%%%%%%%%%%" crlf)
(printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf)


 (printout t crlf  " Do you feel a lack of energy? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (lack_energy (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf   " Do you feel you have more problems with memory than most? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (memory (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf   " Do you often feel helpless? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (helpless (read)))

 (assert (Physical_Symptoms_Matched 0))
 (assert (stop_Loop1 yes))
 )
 



;;___________________________Physical issues Analysis____________________
(defrule Physical_Depression_Diagnose "Analyzing user answers"
(lack_energy ?lkg)
(memory ?mem)
(helpless ?hpss)
(stop_Loop1 yes)
?loop1 <- (stop_Loop1 yes)
(Physical_Symptoms_Matched ?psm)
?retract_psm <- (Physical_Symptoms_Matched ?psm)
=>

(bind ?s1 ?psm)
(if (eq ?lkg 1)
then (bind ?s1 (+ ?s1 6.66))
else (bind ?s1 (+ ?s1 0)))

(if (eq ?mem 1)
then (bind ?s1 (+ ?s1 6.66))
else (bind ?s1 (+ ?s1 0)))

(if (eq ?hpss 1)
then (bind ?s1 (+ ?s1 6.66))
else (bind ?s1 (+ ?s1 0)))


(if (<= ?s1 6.66)
 then (printout t crlf crlf"# Diagnose: you seems normal in terms of Physical Issues" crlf
 "# Note: There is still possibility of having Depression" crlf))


(retract ?retract_psm)
(retract ?loop1)
(assert (Physical_Symptoms_Matched ?s1))


(assert(Next_Category2 on)))


;; _____________________________________________________________________________
;; _________________________  Category 2 self_loathing _____________________________
;; _____________________________________________________________________________

;;_______________________Verification self_loathing _______________________

(defrule self_loathing
(User_Name ?name)
(Next_Category2 on)
?retract_Ch2 <- (Next_Category2 on)
 =>

 (printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
 (printout t  crlf "%%%%%%%%% Problems In self_loathing - Verification %%%%%%%%%%%%" crlf)
(printout t  crlf  "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf)



 (printout t crlf  " Do you feel that your situation is hopeless? (1-Yes | 2-No) " crlf  
 " Your answer: " )
  (assert (hopeless (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you feel pretty worthless the way you are now? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (worthless (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you think it is awful to be alive now?  (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (alive (read)))
 (assert (self_loathing_Symptoms_Matched 0))
 (assert (stop_Loop2 yes))


)




;;___________________________self_loathing Analysis____________________  
 (defrule self_loathing_Depression_Diagnose "Analyzing user responses"
(hopeless ?hoplees)
(worthless ?worlees)
(alive ?live)
(stop_Loop2 yes)
?loop2 <- (stop_Loop2 yes)
(self_loathing_Symptoms_Matched ?llsm)
?retract_llsm <- (self_loathing_Symptoms_Matched ?llsm)
=>

(bind ?s2 ?llsm)
(if (eq ?hoplees 1)
then (bind ?s2 (+ ?s2 6.66))
else (bind ?s2 (+ ?s2 0)))

(if (eq ?worlees 1)
then (bind ?s2 (+ ?s2 6.66))
else (bind ?s2 (+ ?s2 0)))

(if (eq ?live 1)
then (bind ?s2 (+ ?s2 6.66))
else (bind ?s2 (+ ?s2 0)))

(if (<= ?s2 6.66)
 then (printout t crlf crlf "# Diagnose: you seems normal in terms of self_loathing" crlf
 "# Note: There is still possibility of having Depression" crlf))


(retract ?retract_llsm)
(retract ?loop2)
(assert (self_loathing_Symptoms_Matched ?s2))
(assert(Next_Category3 on)))
 

(defrule self_dissatisfaction
(User_Name ?name)
(Next_Category3 on)
?retract_Ch2 <- (Next_Category3 on)
 =>
 (printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
 (printout t  crlf "%%%%%%%%% Problems In self-dissatisfaction - Verification %%%%%" crlf)
(printout t  crlf  "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf)

 (printout t crlf  " Are you basically unsatisfied with your life? (1-Yes | 2-No) " crlf  
 " Your answer: " )
  (assert (life_dissatisfaction (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you think that most people are better off than you are? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (self_deprecation (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you feel that your life is empty?  (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (self_failure (read)))
 (assert (self_dissatisfaction_Symptoms_Matched 0))
 (assert (stop_Loop3 yes)))



;;___________________________self-dissatisfaction Analysis____________________
 (defrule self_dissatisfaction_Depression_Diagnose "Analyzing user responses"
(life_dissatisfaction ?lifdiss)
(self_deprecation ?slfdeprec)
(self_failure ?slfflure)
(stop_Loop3 yes)
?loop3 <- (stop_Loop3 yes)
(self_dissatisfaction_Symptoms_Matched ?slfdisssm)
?retract_slfdisssm <- (self_dissatisfaction_Symptoms_Matched ?slfdisssm)
=>

(bind ?s3 ?slfdisssm)
(if (eq ?lifdiss 1)
then (bind ?s3 (+ ?s3 6.66))
else (bind ?s3 (+ ?s3 0)))

(if (eq ?slfdeprec 1)
then (bind ?s3 (+ ?s3 6.66))
else (bind ?s3 (+ ?s3 0)))

(if (eq ?slfflure 1)
then (bind ?s3 (+ ?s3 6.66))
else (bind ?s3 (+ ?s3 0)))

(if (<= ?s3 6.66)
 then (printout t crlf crlf"# Diagnose: you seems normal in terms of self-dissatisfaction " crlf
 "# Note: There is still possibility of having Depression" crlf))

(retract ?retract_slfdisssm)
(retract ?loop3)
(assert (self_dissatisfaction_Symptoms_Matched ?s3))
(assert(Next_Category4 on)))
 


;; _____________________________________________________________________________
;; _______________________  Category 4 displease issues ________________________
;; _____________________________________________________________________________

;;_______________________Verification displease issues_______________________
(defrule displease
 (User_Name ?name)
(Next_Category4 on)
?retract_Ch2 <- (Next_Category4 on)
 =>

 (printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
 (printout t  crlf "%%%%%%%%%%%%%% Problems In displease - Verification %%%%%%%%%%%" crlf)
(printout t  crlf  "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf crlf)

 (printout t crlf  " Are you in bad spirits most of the time?  (1-Yes | 2-No) " crlf  
 " Your answer: " )
  (assert (bad_spirits (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you feel sad most of the time? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (sadness (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Are you afraid that something bad is going to happen to you? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (obsessive (read)))
 (assert (displease_Symptoms_Matched 0))
 (assert (stop_Loop4 yes)))


;;_____________________________displease Analysis____________________
(defrule displease_Depression_Diagnose "Analyzing user responses"
(bad_spirits ?bspir)
(sadness ?sad)
(obsessive ?obses)
(stop_Loop4 yes)
?loop4 <- (stop_Loop4 yes)
(displease_Symptoms_Matched ?dpsm)
?retract_dpsm <- (displease_Symptoms_Matched ?dpsm)
=>

(bind ?s4 ?dpsm)
(if (eq ?bspir 1)
then (bind ?s4 (+ ?s4 6.66))
else (bind ?s4 (+ ?s4 0)))

(if (eq ?sad 1)
then (bind ?s4 (+ ?s4 6.66))
else (bind ?s4 (+ ?s4 0)))

(if (eq ?obses 1)
then (bind ?s4 (+ ?s4 6.66))
else (bind ?s4 (+ ?s4 0)))

(if (<= ?s4 6.66)
 then (printout t crlf crlf"# Diagnose: you seems normal in terms of displease " crlf
 "# Note: There is still possibility of having Depression" crlf))

(retract ?retract_dpsm)
(retract ?loop4)
(assert (displease_Symptoms_Matched ?s4))
(assert(Next_Category5 on)))
 

;; _____________________________________________________________________________
;; _______________________  Category 5 inactivity issues ________________________
;; _____________________________________________________________________________

;;_______________________Verification inactivity issues_______________________

(defrule inactivity
(User_Name ?name)
(Next_Category5 on)
?retract_Ch2 <- (Next_Category5 on)
 =>

 (printout t  crlf "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf)
 (printout t  crlf "@@@@@@@@@@@@@@ Problems In inactivity - Verification @@@@@@@@@@@@" crlf)
(printout t  crlf  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf crlf)

 (printout t crlf  " Have you dropped many of your activities and interests? (1-Yes | 2-No) " crlf  
 " Your answer: " )
  (assert (drop_interest (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you prefer to stay at home, rather than going out and doing new things? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (solitary (read)))
  (printout t  crlf "_________________________________________________________________" crlf crlf)
 (printout t crlf  " Do you often get bored? (1-Yes | 2-No) " crlf  
 " Your answer: " )
 (assert (bored (read)))

 (assert (inactivity_Symptoms_Matched 0))
 (assert (stop_Loop5 yes)))
 
;;___________________________inactivity Analysis____________________ 
 (defrule inactivity_Depression_Diagnose "Analyzing user responses"
(drop_interest ?drpint)
(solitary ?sly)
(bored ?bod)
(stop_Loop5 yes)
?loop5 <- (stop_Loop5 yes)
(inactivity_Symptoms_Matched ?inactsm)
?retract_inactsm <- (inactivity_Symptoms_Matched ?inactsm)
=>

(bind ?s5 ?inactsm)
(if (eq ?drpint 1)
then (bind ?s5 (+ ?s5 6.66))
else (bind ?s5 (+ ?s5 0)))

(if (eq ?sly 1)
then (bind ?s5 (+ ?s5 6.66))
else (bind ?s5 (+ ?s5 0)))

(if (eq ?bod 1)
then (bind ?s5 (+ ?s5 6.66))
else (bind ?s5 (+ ?s5 0)))

(if (<= ?s5 6.66)
 then (printout t crlf crlf "# Diagnose: you seems normal in terms of inactivity " crlf))

(retract ?retract_inactsm)
(retract ?loop5)
(assert (inactivity_Symptoms_Matched ?s5))
(assert (Depression_Symptoms_Analysis on)))


;;_______________________________________________________________________________________
;;________________________Depression Symptoms Analysis _________________________
;;_______________________________________________________________________________________

(defrule Depression_Symptoms_Analysis_Report
 (Depression_Symptoms_Analysis on)
 ?retractDSA <- (Depression_Symptoms_Analysis on)
 (User_Name ?name)
 (Physical_Symptoms_Matched ?SM1)
 (self_loathing_Symptoms_Matched ?SM2)
 (self_dissatisfaction_Symptoms_Matched ?SM3)
 (displease_Symptoms_Matched ?SM4)
 (inactivity_Symptoms_Matched ?SM5)
 =>
 (retract ?retractDSA)
(bind ?Scale 0)
(bind ?Scale (+ ?Scale ?SM1))
(bind ?Scale (+ ?Scale ?SM2))
(bind ?Scale (+ ?Scale ?SM3))
(bind ?Scale (+ ?Scale ?SM4))
(bind ?Scale (+ ?Scale ?SM5))
(printout t  crlf "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t "           Depression Consultant Expert System Report" crlf) 
(printout t "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t crlf "# Patient Name : " ?name crlf)
(printout t "# Diagnosed Scale : " ?Scale " %"crlf crlf crlf)
(if (>= ?Scale 80) 
then	
(printout t "# Diagnose: You seem to be experiencing from severe depressive symptoms typically associated with severe depressive disorders." crlf crlf "# Depression Scale " ?Scale " % (80% to 99.99%, Severe Depression)" crlf crlf 
"# Suggestion: You would most likely benefit from the immediate contact of any Psychiatrist, Psychologist, or"crlf "professional mental health specialist for further diagnosis, evaluation and treatment."crlf" Also you should have immediate initiation of pharmacotherapy and expedited " crlf crlf)

else (if (>= ?Scale 60) 
        then (printout t "# Diagnose: You seem to be experiencing some moderate depressive symptoms, many of which are commonly found amongst the general population, but border on the possibility of a depressive episode." crlf "Depression Scale " ?Scale  " % (60% to 79%, Moderate Depression)" crlf crlf
"# Suggestion: It is unclear whether or not you suffer these problems severely enough to need to seek"crlf"further diagnosis and treatment by contact of any Psychiatrist, Psychologist, or professional mental health specialist where "crlf"it may give a treatment plan ranging form counseling, follow-up, and/or pharmacotherapy." crlf crlf)
        else (if (>= ?Scale 40) 
            then (printout t "You seem to be experiencing some very mild depressed symptoms, the majority of which are common in the general population. " crlf crlf "# Depression Scale " ?Scale  " % (40% to 59%, Mild Depression)" crlf crlf
"# Suggestion: It is unclear whether or not you suffer these problems severely enough to need to seek"crlf"further diagnosis and treatment by contact of any Psychiatrist, Psychologist, or professional mental health specialist."crlf"Also, you may require only watchful waiting and repeated this checkup at followup" crlf crlf)))
            else (if (< ?Scale 40) 
                    then (printout t "# Diagnose: Your scale falls within the range of 0% to 39% and is in the Normal range." crlf "# Depression Scale " ?Scale  " % (0% to 39%, Normal Range)" crlf 
"# Suggestion: you do not seem to be experiencing any depressive symptoms at this time, but you may need to seek "crlf"further diagnosis and treatment by contact of any psychiatrist, psychologist, or"crlf"professional mental health specialist if this changes." crlf crlf))  
    )
   
(assert(repeat Off))
(assert(Selected_Option 0)))




;;_______________________________________________________________
;;_____________________ Start Again _______________________
;;_______________________________________________________________
(defrule Repeat_Diagnose
(repeat Off)
?name <-  (User_Name ?)
?retract_Op <- (Selected_Option 0)
?retract_Repeat <- (repeat Off)
=>
(retract ?name)
(retract ?retract_Op)
(printout t crlf "Do you want to Re-Diagnose Depression : (1- Yes | 2- No)" crlf)
(bind ?Repeat (read))
(if (eq ?Repeat 1) 
then (reset)(run)
else (assert(Selected_Option 3))))
 


;: _____________________________________________________________________________________
;; _______________________________ information about Depression _________________
;; _____________________________________________________________________________________
(defrule Depression_Information
(Selected_Option 2)
?retract_SelOp <- (Selected_Option 2)
=>
(retract ?retract_SelOp)
(printout t crlf"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t "%%%%%%%%%%%%%%%%%%%%%%%%% What is depression %%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" crlf)
(printout t "Depression is a widespread and dangerous medical disease that has a 
negative impact on how you feel, think, and act. It is sometimes referred to as 
major depressive disorder. It is, however, curable. Depression creates emotions 
of melancholy or a loss of interest in previously appreciated activities.
This can also lead to a variety of medical and mental issues, as well as a reduction
in a person's capacity to perform at work. When we are unhappy,
grumpy, or down from time to time, some people experience these sensations 
profoundly for weeks, months, or even years. Depression is more than simply 
a bad mood. it is a serious illness that impacts both your physical and mental 
health. Depression is uncommon and affects both boys and girls at roughly the 
same rate before puberty  (for more information visit www.nimh.nih.gov/health/statistics/major-depression )." crlf crlf)

(printout t "Do want to continue completing depression checkup (press 1 for yes)" crlf)
(assert(Selected_Option (read)))
(assert(repeat Off)))


