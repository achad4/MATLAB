function is_const = d_j(f, n)

    ket_0 = [1; 0];
    ket_1 = [0; 1];

    I = [1 0;0 1];

    Hadamard = [1 1; 1 -1]/2^.5;
    Hadamard_n = Hadamard;
    for i = 1 : n-1
        Hadamard_n = kron(Hadamard_n, Hadamard);
    end

    %initialize psi for top and bottom
    psi_0 = ket_0;
    for i = 1 : n-1
        psi_0 = kron(psi_0, ket_0);
    end
    psi_1 = ket_1;

    %first application of H gate
    psi_0 = Hadamard_n*psi_0;
    psi_1 = Hadamard*psi_1;

    %create unitary matrix for oracle
    U_f = zeros(2^(n+1), 2^(n+1));
    for i = 1 : 2^n
            temp = zeros(2^(n+1), 2^(n+1));
            fn  =  f(i);
            if fn == 0
                x = I;
            else
                x = [0 1; 1 0];
            end
            temp(2*i-1,2*i-1) = x(1,1);
            temp(2*i-1,2*i) = x(1,2);
            temp(2*i,2*i-1) = x(2,1);
            temp(2*i,2*i) = x(2,2);
            U_f = U_f + temp;
    end
    %disp(U_f);
    %apply oracle and Hadamard
    psi = U_f*kron(psi_0, psi_1);
    psi = kron(Hadamard_n, I)*psi;

    %Measure
    measurement_0 = zeros(2^n);
    measurement_0(1,1) = 1;
    measurement_0 = kron(measurement_0, I);
    prob = norm(measurement_0*psi)^2;
    is_const = 'CONSTANT';
    if(prob == 0)
        is_const = 'BALANCED';
    end
    disp(is_const);
end


