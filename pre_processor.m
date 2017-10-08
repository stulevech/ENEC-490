function [ streamlined ] = pre_processor( data, rows, columns )
    
[rows,columns] = size(data);
streamlined = zeros(rows*columns,1);

for i = 1:rows
    streamlined((i-1)*columns+1:(i-1)*columns+columns) = data(i,:);        
end

%for i = 2:(length(streamlined))-1
%   if streamlined(i) == 0
%        streamlined(i) = (streamlined(i+1) + streamlined(i-1))./2;
%   elseif streamlined(i) >= 5*std(data)
%        streamlined(i) = (streamlined(i+1) + streamlined(i-1))./2;
%   while streamlined(i) == 0
%            j = i + 1;
%            k = i - 1;
%            streamlined(i) = (streamlined(j+1) + streamlined(k - 1))./2;
%            j = j + 1;
%            k = k -1;
%   end 
%        end 
%   end 
%end 

for i = 1: length(streamlined)
    if streamlined(i) < 1
        if streamlined(i+1) < 1
            streamlined(i) = mean([streamlined(i-1) streamlined(i+2)]);
        else
            streamlined(i) = mean([streamlined(i-1) streamlined(i+1)]);
        end 
    elseif streamlined(i) > 180000
        streamlined(i) = mean([streamlined(i-1) streamlined(i+1)]);
        %i'm not even sure if this is accomplishing anything
    elseif streamlined(i) >= 5*std(streamlined) + mean(streamlined)        
        streamlined(i) = mean([streamlined(i-1) streamlined(i+1)]);
        %this last bit is a bit of a crude approach
    %elseif streamlined(i) >= 1.5*mean(streamlined);
    %   streamlined(i) = mean([streamlined(i-1) streamlined(i+1)]);
        
    end
end 
        
        
        
            
   
    %end 
%end 

%while streamlined(i) == 0 || streamlined(i) >= 5*std(data)
%    streamlined(i) = (streamlined(i+1) + streamlined(i-1))./2;
%end 

