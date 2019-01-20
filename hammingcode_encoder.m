function [ encodedMessage ] = hammingcode_encoder( binaryMessage )

    n = length(binaryMessage);

    % find highest binary multiplier
    i=0;
    while (true)
       if 2^(i) > n+(i)
           break;
       else
           i = i + 1;
       end
    end
    %highest binary power to identify largest index for parity bit
    k = i; 

    %create array of indices to inject parity bits
    for i = 0:k-1
       k_arr(i+1) = 2^i; 
    end

    encodedStrLen = n + length(k_arr);
    encodedMessage = 2*ones(1,encodedStrLen);

    for i = encodedStrLen:-1:1

        if (i == k_arr(end))
            paritySummer = 0;
            counter = 1;
            % start at first bit after parity bit
            j = i+1;
            while (true)
                % check to see if k bits have been checked
                if counter >= k_arr(end)
                    % skip k bits if k bits have been checked
                    j = j + k_arr(end);
                    %reset counter
                    counter = 0;
                end
                %check if at end of message
                if (j > length(encodedMessage))
                    break;
                end
                %cumulatively add the checked bits
                paritySummer = paritySummer + encodedMessage(j);
                counter = counter + 1;
                j = j + 1;
            end
            %take mod 2 of sum of checked bits
            parityBit = mod(paritySummer,2);
            encodedMessage(i) = parityBit;
            k_arr(end) = [];
        else
            %place message bit in new encoded message
            encodedMessage(i) = binaryMessage(end);
            binaryMessage(end) = [];
        end

    end
end
