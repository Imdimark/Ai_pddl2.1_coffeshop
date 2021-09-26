(define(problem Problem1)
    (:domain Total_domain)

    (:objects
        ag1 ag2 - agent
        t0 t1 t2 t3 t4 - table
        d1 d2  - drink
    )
    
    (:init
        (bar-counter t0)
        (at-agent ag1 t0)
        (at-agent ag2 t1)
        (free)
        (not-occupied t2)
        (not-occupied t3)
        (not-occupied t4)
       
        (cold d1 ag1)
        (cold d2 ag1)
        (not-consumed d1)
        (not-consumed d2)
        (=(tot-cold)2)
        (=(tot-hot)0)
        (=(surf_m t0)0)
        (=(surf_m t1)0)
        (=(surf_m t2)1)
        (=(surf_m t3)2)
        (=(surf_m t4)1)
        (=(consumed-drink t0 )0)
        (=(consumed-drink t1 )0)
        (=(consumed-drink t2 )2)
        (=(consumed-drink t3 )0)
        (=(consumed-drink t4 )0)
        (=(ordered-cold t0)0)
        (=(ordered-hot t0)0)
        (=(ordered-cold t1)0)
        (=(ordered-hot t1)0)
        (=(ordered-cold t2)2)
        (=(ordered-hot t2)0)
        (=(ordered-cold t3)0)
        (=(ordered-hot t3)0)
        (=(ordered-cold t4)0)
        
        (=(biscuitable t0 )0)
        (=(needed-biscuits t0 ag1)0)
        (=(needed-biscuits t0 ag2)0)
        (=(biscuitable t1 )0)
        (=(needed-biscuits t1 ag1)0)
        (=(needed-biscuits t1 ag2)0)
        (=(biscuitable t2 )0)
        (=(needed-biscuits t2 ag1)2)
        (=(needed-biscuits t2 ag2)0)
        (=(biscuitable t3 )0)
        (=(needed-biscuits t3 ag1)0)
        (=(needed-biscuits t3 ag2)0)
        (=(biscuitable t4 )0)
        (=(needed-biscuits t4 ag1)0)
        (=(needed-biscuits t4 ag2)0)
        
        (=(ordered-hot t4)0)
        (=(distance t0 t1)2)
        (=(distance t0 t2)2)
        (=(distance t0 t3)3)
        (=(distance t0 t4)3)
        (=(distance t1 t0)2)
        (=(distance t1 t2)1)
        (=(distance t1 t3)1)
        (=(distance t1 t4)1)
        (=(distance t2 t0)2)
        (=(distance t2 t1)1)
        (=(distance t2 t3)1)
        (=(distance t2 t4)1)
        (=(distance t3 t0)3)
        (=(distance t3 t1)1)
        (=(distance t3 t2)1)
        (=(distance t3 t4)1)
        (=(distance t4 t0)3)
        (=(distance t4 t2)1)
        (=(distance t4 t3)1)
        (=(distance t4 t1)1)
        (=(on-counter)0)
        (=(agent-capacity ag1)1)
        (=(agent-speed ag1)2)
        (=(carry-agent ag1)0)
        (=(agent-capacity ag2)1)
        (=(agent-speed ag2)2)
        (=(carry-agent ag2)0)
    )
        
    (:goal(and
      		
			 (<(needed-biscuits t2 ag1)1) (<(consumed-drink t2 )1)(<(surf_m t2)1)(<(surf_m t3)1)(<(surf_m t4)1)
    ))

)

