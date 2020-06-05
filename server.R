

shinyServer(function(input, output) {

    dt<-reactive(
        dati %>% 
            mutate_at(vars(starts_with("r")),list(as.integer)) %>% 
        filter(mp==input$mp) %>% 
            discard(~all(is.na(.x))) %>% 
            mutate(s = rowSums(select(., starts_with("r")))) %>%
            mutate(k=n()) %>% 
            mutate(p=s/ncol(select(dati, starts_with("r"))))
    )

     
    repliche<-reactive(ncol(select(dati, starts_with("r"))))
    P<-reactive(mean(dt()$p))
    
    output$t<-renderTable(dt() %>% 
                              select(-mp,-s, -k)
                          )

    
    
    # dt() %>% 
        # round(select(-mp, -s, -k),0))
    
    
    s2_r<-reactive(sum(dt()$p*(1-dt()$p))/dt()$k)
        
    s2_L<-reactive((sum((dt()$p-mean(dt()$p)^2))/(dt()$k-1)))
    
    s2_R<-reactive(s2_r()+s2_L())
    
    sd_r<-reactive(sqrt(s2_L()))
    sd_R<-reactive(sqrt(s2_R()))
    
    
    output$r<-renderText(sd_R())
    
    output$tt<-renderTable(
    t<-round(tibble("P"=P(), "sr"=s2_r(),
                     "sL"=s2_L(),"sR"=s2_R(),"sd_r"=sd_r(),"sd_R"=sd_R(), "r"=2*sd_r(),
                  "R"=2*sd_R()),2) %>%slice(1)
   )
    
    
    
        # kable() %>% 
        # kable_styling()
    
    

})
