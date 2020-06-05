

shinyServer(function(input, output) {

    dt<-reactive(
        dati %>% 
        filter(mp==input$mp) %>% 
            discard(~all(is.na(.x))) %>% 
            mutate(s = rowSums(select(., starts_with("r")))) %>%
            mutate(k=n()) %>% 
            mutate(pi=s/ncol(select(dati, starts_with("r"))))
    )

     
    repliche<-reactive(ncol(select(dati, starts_with("r"))))
    P<-reactive(mean(dt()$pi))
    
    output$t<-renderTable(dt())
    
    
    s2_r<-reactive(sum(dt()$pi*(1-dt()$pi))/dt()$k)
        
    s2_L<-reactive((sum((dt()$pi-mean(dt()$pi)^2))/(dt()$k-1)))
    
    s2_R<-reactive(s2_r()+s2_L())
    
    sd_r<-reactive(sqrt(s2_L()))
    sd_R<-reactive(sqrt(s2_R()))
    
    
    output$r<-renderText(sd_R())
    
    output$tt<-renderTable(
    t<-round(tibble("P"=P(), s2_r(),
                     s2_L(),s2_R(),sd_r(),sd_R(), "r"=2*sd_r(),
                  "R"=2*sd_R()),2) %>%slice(1)
   )
    
    
    
        # kable() %>% 
        # kable_styling()
    
    

})
