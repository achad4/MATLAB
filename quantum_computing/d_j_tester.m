function d_j_tester(n)
    disp('Test with balanced function:')    
    d_j(@bal, n);
    disp('Test with constant function 1:')    
    d_j(@const_0, n);
    disp('Test with constant function 2:')    
    d_j(@const_1, n);
    
    disp('Modified Test with balanced function:')    
    d_j_mod(@bal_mod, n);
    disp('Modified Test with constant function 1:')    
    d_j_mod(@const_0, n);
    disp('Modified Test with constant function 2:')    
    d_j_mod(@const_1, n);

    %test functions
    function y = const_0(i)
        y = 0;
    end

    function y = const_1(i)
        y = 1;
    end

    function y = bal(i)
        y = mod(i,2); 
    end

    function [ ret ] = bal_mod( i )
        ret = mod(i,4);
        if(ret ~= 0)
            ret = 1;
        end
    end
end