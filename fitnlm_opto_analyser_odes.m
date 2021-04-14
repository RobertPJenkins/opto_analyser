function output = fitnlm_opto_analyser_odes(pars,constants,time_nlinfit)
    ss_end=constants(1);
    release_end=constants(2);    
    time_span=time_nlinfit(1:length(time_nlinfit)/3);
    k_off_unlit=pars(1);
    k_on_unlit=pars(2);
    k_off_lit=pars(3);
    k_on_lit=pars(4);
    k_imp=pars(5);
    k_exp=pars(6);
    m0=pars(7);
    c0=k_off_unlit*m0/k_on_unlit;
    n0=k_imp*c0/k_exp;
    function dz = OptoODE(t,z)
        dz = zeros(3,1);
        if(t<=ss_end)
            K_off=k_off_unlit;
            K_on=k_on_unlit;
        elseif(t>=ss_end)&&(t<=release_end)
            K_off=k_off_lit;
            K_on=k_on_lit;
        else
            K_off=k_off_unlit;
            K_on=k_on_unlit;
        end;
        dz(1) = abs(K_on)*z(2)-abs(K_off)*z(1);
        dz(2) = -abs(K_on)*z(2)+abs(K_off)*z(1)+abs(k_exp)*z(3)-abs(k_imp)*z(2);
        dz(3) = -abs(k_exp)*z(3)+abs(k_imp)*z(2);
    end;
    z0=[m0 c0 n0]';
    options = odeset('RelTol',1e-10,'AbsTol',[1e-10,1e-10 1e-10]);
    [T,Z] = ode15s(@OptoODE,time_span,z0);
    output = [Z(:,1);Z(:,2);Z(:,3)];
end

  
  


