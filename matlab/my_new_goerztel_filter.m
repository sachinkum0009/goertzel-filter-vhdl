% new goertzel algorithm
function magnitude = my_new_goerztel_filter(signal, targetFrequency, sampleRate)
    N = length(signal);
    k = round((N * targetFrequency) / sampleRate);
    w = (2 * pi * k) / N;
    
    cosine = cos(w);
    sine = sin(w);
    fprintf("%.20f\n",cosine);
    fprintf("%.20f\n",sine);
    %disp(cosine);
    %disp(sine);
    
    coeff = 2 * cosine;
    fprintf("%.20f\n",coeff);
    % disp(['coeff', coeff]);
    Q1 = 0;
    Q2 = 0;
    
    for n = 1:N
        Q0 = coeff * Q1 - Q2 + signal(n);
        Q2 = Q1;
        Q1 = Q0;
        realPart = Q1 - Q2 * cosine;
        imagPart = Q2 * sine;
    
        magnitude = sqrt(realPart^2 + imagPart^2);
    end
    
    
end
