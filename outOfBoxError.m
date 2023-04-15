function [oob] = outOfBoxError(tree, testSet, subAttr)

%         Takes in the tree data structure, testSet (last column is classification)
%                         subAttr- the list of attributes for this tree
%                               the testSet and subAttr contains only values selected for classification by this tree.
actual = testSet(:, size(testSet,2) ); %the verified/ actual classifcation values
correct = 0; %number of testcases correctly guessed
%     this variable is to be correctly returned
oob = -1;  %oob is a number between 0 and 1, inclusive on both ends

for i = 1:size(testSet,1)
    prediction = ClassifyByTree(tree, subAttr, testSet(i, :) );
        if( prediction == actual(i) )
            correct = correct + 1;
    end
end

oob = 1 - (correct / size(testSet,1));
end
