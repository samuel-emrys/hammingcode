function [ decodedMessage ] = hammingcode_decoder( encodedMessage )

    n = length(encodedMessage);
    k = floor(log2(n));

    %populate a matrix of parity indices
    for i = 0:k
        k_arr(i+1) = 2^i; 
    end

    decodedMessage = [];
    checkBits = [];
    
    %this constructs a checkbit array to compare with the parity bits
    for i = 1:length(k_arr)
        parityBits(i) = encodedMessage(k_arr(i)); 
        paritySummer = 0;
        %begin at the parity bit index + 1
        j = k_arr(i)+1;
        %start counter at 1 to ensure parity bit isn't included in
        %calculation
        counter = 1;
        
        while (true)
            if counter >= k_arr(i)
                % skip k bits if k bits have been checked
                j = j + k_arr(i);
                %reset counter
                counter = 0;
            end
            
            if (j > length(encodedMessage))
                break;
            end
            
            paritySummer = paritySummer + encodedMessage(j);
            counter = counter + 1;
            j = j + 1;
            
        end
        
        parityBit = mod(paritySummer,2);
        checkBits(i) = parityBit;
    end
    
    %check for errors
    errBits = zeros(1,length(checkBits));
    errorFlag = 0;
    erroneousBit = 0;
    
    for i = 1:length(checkBits)
        if (checkBits(i) ~= parityBits(i))
           % record bits in error
           errBits(i) = 1;
           % set flag to 1 to indicate there were errors
           errorFlag = 1;
        end
    end
    
    if errorFlag == 0
        fprintf('No errors found!\n'); 
    else
        errors = find(errBits==1);
        fprintf('Errors found in parity bits ');
        for i = 1:length(errors)
            fprintf('%d, ', errors(i))
        end
        fprintf('\n');
        %identify the bit in error
        erroneousBit = sum(k_arr(errors));
        fprintf('Bit %d is the erroneous bit\n', erroneousBit);
        
    end
    
    % Construct error correct decoded message
    for i = 1:length(encodedMessage)
       if (~isempty(k_arr)) && i == k_arr(1)
           k_arr(1) = [];
       elseif i == erroneousBit
           %flip the erroneous bit and append to decoded message
           decodedMessage = [decodedMessage, ~erroneousBit];
       else
           %append data bit to decoded message
           decodedMessage = [decodedMessage, encodedMessage(i)];
       end
    end
    
    fprintf('Check Bits: %s\n',mat2str(checkBits));
    fprintf('Parity Bits: %s\n',mat2str(parityBits));

end