load pop_stream_sla

pcomps_raw2(hp66_pp_a.mean,norm_ssh_a.mean,[-1e-4 1e-4],-1,.1,1,['PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/pp_a_sla
pcomps_raw2(hp66_pp_c.mean,norm_ssh_c.mean,[-1e-4 1e-4],-1,.1,1,['PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/pp_c_sla