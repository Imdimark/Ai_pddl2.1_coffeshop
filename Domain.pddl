(define (domain Total_domain)

    (:requirements
        :durative-actions
        :equality
        :numeric-fluents
        :typing
    )

    (:types
         agent
         table
         drink
    )

    (:predicates
         
         (at-agent ?a - agent ?t - table)
         (not-occupied ?t - table)
         (at-drink ?d - drink ?t - table)
         (cold ?d - drink ?a - agent)
         (hot ?d - drink ?a - agent)
         (bar-counter ?t)    
         (free)
         (carrying ?d - drink)
         (not-consumed ?d - drink)
         (tray ?a - agent)
      
        
         
    )

    (:functions
        (distance ?t1 ?t2 - table)
        (agent-speed ?a - agent)
    	(on-counter)
    	(tot-cold)
    	(tot-hot)
    	(carry-agent ?a - agent)
    	(agent-capacity ?a - agent)
     	(ordered-cold ?t - table)
    	(ordered-hot ?t - table)
    	(consumed-drink ?t - table)
        (surf_m ?t - table)
        (biscuitable  ?t - table)
        (needed-biscuits ?t - table ?a - agent)
        (carry-biscuits ?a - agent  )
    )
        
    (:durative-action move
        :parameters (?t1 ?t2 - table ?a - agent)
        :duration (= ?duration (/(distance ?t1 ?t2)(agent-speed ?a)))
        :condition (and (at start(not-occupied ?t2))(at start(at-agent ?a ?t1))
        		 )
        :effect (and
            (at end(at-agent ?a ?t2))
            (at start(not (at-agent ?a ?t1)))
            (at start(not-occupied ?t1))
            (at start(not(not-occupied ?t2)))
        )
    )
    
    (:durative-action make_cold
        :parameters (?d - drink ?t - table ?a - agent)
        :duration (= ?duration 3)
        :condition (and (at start(>(tot-cold)0))
                        (over all(bar-counter ?t))
        		(over all(cold ?d ?a))
                        (at start(free)))
        :effect (and 
        	     (at end(at-drink ?d ?t))        	  
        	     (at end(free))
        	     (at start(not(free)))
        	     (at start(decrease(tot-cold)1))
        	     (at end(increase(on-counter)1))
        	     )
    )
  
    
   (:durative-action make_hot
        :parameters (?d - drink ?t - table ?a - agent)
        :duration (= ?duration 5)
        :condition (and   (at start(>(tot-hot)0))
                         (over all(bar-counter ?t))
        		 (over all(hot ?d ?a))
        		 (at start(free)))
        :effect (and 
        	(at end(at-drink ?d ?t))
        	(at end(free))
        	(at start(not(free)))
        	(at start(decrease(tot-hot)1))
        	(at end(increase(on-counter)1)))
    )
    

    
    (:action pick_tray
         :parameters (?a - agent ?t - table)
         :precondition (and (or(>(on-counter)2)(>(on-counter)1))
                       (<(carry-agent ?a)1)
                       (>(agent-capacity ?a)0)
                       (<(agent-capacity ?a)2)
                       (bar-counter ?t)
                       (at-agent ?a ?t)
                        )
                       
         :effect (and (tray ?a)
         	      (assign(agent-speed ?a)1)
                      (assign(agent-capacity ?a)3))
     )
     
     (:durative-action Biscuit
        :parameters (?t1 ?t2 - table ?a - agent)
        :duration (= ?duration (/(distance ?t1 ?t2)(agent-speed ?a)))
        :condition (and (at start(not-occupied ?t2))
                        (at start(at-agent ?a ?t1))
                        (at start (<(carry-agent ?a)1))
                        
                        (at start (bar-counter ?t1))
                        (at start (>(biscuitable ?t2 )0))
                        (at start (>(needed-biscuits ?t2 ?a)0))
        		 )
        :effect (and
            (at end(at-agent ?a ?t2))
            (at start(not (at-agent ?a ?t1)))
            (at start(not-occupied ?t1))
            (at start(not(not-occupied ?t2)))
            (at end (decrease (biscuitable ?t2 )1))
            (at end (decrease(needed-biscuits ?t2 ?a)1))
           
        )
    )
     (:action pick_biscuit
         :parameters (?a - agent ?t1 ?t2 - table)
         :precondition (and (<(carry-agent ?a)(agent-capacity ?a))
                            (bar-counter ?t1)
                            (at-agent ?a ?t1)
                            (>(biscuitable ?t2 )0)
                            (>(needed-biscuits ?t2 ?a)0)
                            )
                            
         :effect (and 
                     
                      (increase(carry-agent ?a )1)
                      (increase(carry-biscuits ?a )1)
                      )
     )
     
     (:action put_biscuit
         :parameters (?a - agent ?t - table)
         :precondition (and   (>(carry-biscuits ?a )0)
                              (>(needed-biscuits ?t ?a)0)
                              (>(carry-agent ?a)0)
                              (at-agent ?a ?t)          		     
         		   
                             )
                            
         :effect (and 
                      (decrease (biscuitable ?t )1)
                      (decrease(carry-agent ?a)1)
                      (decrease(carry-biscuits ?a)1)
                      (decrease(needed-biscuits ?t ?a)1)
                     )
     )
    
     (:action pick_drink_cold
         :parameters (?a - agent ?t - table ?d - drink)
         :precondition (and (<(carry-agent ?a)(agent-capacity ?a))
                            (at-drink ?d ?t)
                            (bar-counter ?t)
                            (at-agent ?a ?t)
                            (cold ?d ?a)
                            )
                            
         :effect (and (carrying ?d)
                      (not(at-drink ?d ?t))
                      (increase(carry-agent ?a)1)
                      (decrease(on-counter)1))
     )
     
     (:action pick_drink_hot
         :parameters (?a - agent ?t - table ?d - drink)
         :precondition (and (<(carry-agent ?a)(agent-capacity ?a))
                            (bar-counter ?t)
                            (at-agent ?a ?t)
                            (hot ?d ?a)
                            (at-drink ?d ?t)
                            )
                            
         :effect (and (carrying ?d)
                      (not(at-drink ?d ?t))
                      (increase(carry-agent ?a)1)
                      (decrease(on-counter)1))
     )
     


     
     (:action put_tray
         :parameters (?a - agent ?t - table)
         :precondition (and
                       (<(carry-agent ?a)1)
                       (at-agent ?a ?t)
                       (bar-counter ?t)
                       (tray ?a))
                       
         :effect (and (not(tray ?a))
         	      (assign(agent-speed ?a)2)
                      (assign(agent-capacity ?a)1))
     )
     
     (:durative-action put-consume-hot
        :parameters (?d - drink ?t - table ?a -agent)
        :duration (= ?duration 4)
        :condition (and
                    (at start (>(ordered-hot ?t)0))
                    (at start (>(carry-agent ?a)0))
                    (at start (at-agent ?a ?t))
                    (at start (hot ?d ?a))
                    (at start (carrying ?d ))
                    (at start(>(consumed-drink ?t )0))
                    (at start (not-consumed ?d))
        	  )
        :effect (and (at start(decrease(carry-agent ?a)1))(at start (decrease(ordered-hot ?t)1))(at start (not(carrying ?d)))(at end(not (not-consumed ?d)))(at end(decrease(consumed-drink ?t )1))
        ))

       (:durative-action put-consume-cold
        :parameters (?d - drink ?t - table ?a -agent)
        :duration (= ?duration 4)
        :condition (and
                    (at start (>(ordered-cold ?t)0))
                    (at start (>(carry-agent ?a)0))
                    (at start (at-agent ?a ?t))
                    (at start (cold ?d ?a))
                    (at start (carrying ?d ))
                    (at start(>(consumed-drink ?t )0))
                    (at start (not-consumed ?d))
        	  )
        :effect (and (at start (increase(biscuitable ?t )1))(at start(decrease(carry-agent ?a)1))(at start (decrease(ordered-cold ?t)1))(at start (not(carrying ?d)))(at end(not (not-consumed ?d)))(at end(decrease(consumed-drink ?t )1))
        ))
        
     (:durative-action cleaning
        :parameters (?a - agent ?t - table)
        :duration (= ?duration (*(surf_m ?t)2))
        :condition (and
                   (at start (<(needed-biscuits ?t ?a)1))
                   (at start (<(biscuitable ?t)1))
                   (at start(>(surf_m ?t)0))
                   (at start (<(consumed-drink ?t )1))
                   (over all(at-agent ?a ?t))
        	   (over all(<(carry-agent ?a)1))
        	   (over all(<(agent-capacity ?a)2))
        	   (over all(>(agent-capacity ?a)0))
        	  
        	  )
        :effect (and(at end (assign(surf_m ?t)0)))
    )
    
)
