clc; clear;
message = [0 1 0 1 0 0 1];
desiredEncodedMessage = [1 1 1 1 1 1 0 0 0 0 1];

fprintf('Original Message: %s\n',mat2str(message));

encodedMessage = hammingcode_encoder(message);

fprintf('Encoded Message: %s\n',mat2str(encodedMessage));
erroneousMessage = [1 0 0 0 1 0 1 1 0 0 0];
decodedMessage = hammingcode_decoder(erroneousMessage);
fprintf('Decoded Message: %s\n',mat2str(decodedMessage));
