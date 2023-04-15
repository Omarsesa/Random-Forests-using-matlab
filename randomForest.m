function [forests] = randomForest(examples, attributes)

%takes in examples, attributes returns a forests- two values- 1) trees- pointer to a tree structure
%                                                             2) oob - out of box error for the specific tree
numberAttr = length(attributes);
numberEx = length(examples(:,1));
variables = ceil(sqrt(numberAttr));
randEx = floor((632/1000)*numberEx);  % Number of random examples
activeEx = numberEx - randEx; % Examples left
subAttr = zeros(variables);

%return the following data correctly
tree = MV_ID3(examples,attributes,ones(length(attributes),1) );
field1 = 'tree';
field2 = 'oob';
struct forests =(field1,tree,field2,-1);


% Making the forest
    for i=1:10
            [subEx, testSet, subAttr] = randomSampling(examples, attributes ,randEx);
            tree = MV_ID3(subEx, subAttr, ones(variables,1));
            forests(i).tree = tree; % Should return a pointer to the tree
            forests(i).oob = outOfBoxError(tree, testSet, attributes); % Calculate OOB for each tree
    end

end
