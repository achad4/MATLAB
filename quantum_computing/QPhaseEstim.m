function [ state ] = QPhaseEstim(U, u, n, epsilon)
% quantum phase estimation algorithm

    state0 = [1; 0];

    precision = 2^(-n);
    m = size(U);
    m = m(1);
    
    U2 = U^2;
    H = [1 1; 1 -1]/2^.5;
    
    t = n + ceil(log2(2+1/(2*epsilon)));
    %e = 2^(t-n)-1
    temp = U*u;
    
    index = 1;
    while(u(index) == 0)
        index = index+1;
    end
    lambda = temp(index)/u(index);
    
    disp(index);
    
    %topReg = zeros(t);
    % beginning %
    for i = 1:t
        topReg{i} = state0;
    end
    % H %
    for i = 1:t
        topReg{i} = (H*topReg{i});
    end
    % ctrl-U %
    for i = 1:t
        topReg{i} = ([1 0; 0 lambda^(2^(i-1))] * topReg{i});
        
    end
    for i = 1:t
        disp(topReg{i});
    end
    %%%%%before tensoring
%     for i = 1:t
%         topReg{i}
%     end
       
    
    %%% swap outputs
    
    %topReg{1}   
    %topReg{t}   
    
    for i = 1:floor(t/2)
        temp = topReg{i};
        topReg{i} = topReg{t-i+1};
        topReg{t-i+1} = temp;
    end
        
    %topReg{1}   
    %topReg{t}  
    
    
    %%% tensor the top  reg  together
    topRegister = topReg{1};
    for i = 2:t
        topRegister = kron(topRegister, topReg{i});
    end
    for i = 1:t
        disp(topReg{i});
    end   
    
    %%% Inverse QFT %%%
    N = 2^t;
    F = zeros(N,N);
    omega = exp(2*pi*1i/N);
    for i = 1:N
        for j = 1:N
            F(i,j) = omega^((i-1)*(j-1));
        end
    end
    F = F/sqrt(N);
    invF = F';
    
    topRegister;
    probabilities = invF*topRegister;
    
    
    %%%  take biggest for answer
    max = 0;
    maxCoord = 0;
    for i = 1:N
        temp = norm(probabilities(i));
        if(temp > max)
            max = temp;
            maxCoord = i;
        end
    end
    maxCoord;
    maxState = maxCoord - 1;
    
%     maxState = dec2bin(maxState)
%     res = 0;
%     for j = 1:t
%         j
%         res = res + ((2^(-j))*maxState(j))
%     end
%     res
%     eValue = exp(2*pi*1i*res);
    state = dec2bin(maxState, t);
    
    
    
    function [ ret ] = R(k)
       ret = zeros(4);
       ret(1,1) = 1;
       ret(2,2) = exp(2*pi*1i/2^k);
    end
        
end