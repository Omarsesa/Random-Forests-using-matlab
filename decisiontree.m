
function[] = decisiontree()
clc;
clear;

fprintf('Loading Data \n');
%==========================================================================%
formatSpec = '%f%f%f%f%C';
ex = readtable('irisdata.txt','Delimiter',',',...
    'Format',formatSpec);
ex = table2cell(ex);

%========converting text results in data set to numbers ====================%

for i=1:150
    n=char(ex{i,5});
    if(strcmp('Iris-setosa',n))
        ex{i,5} = 1;
    elseif(strcmp('Iris-virginica',n))
        ex{i,5} = 3;
    else
       ex{i,5} = 2;
    end        
end    

ex = cell2mat(ex);

%================= setting up attributes vector ==========================%
attributes = {'sepal length','sepal width','petal length','petal width'};
numAttributes = 4;
%===========================================================================%


fprintf('Load Complete, Press enter to continue \n');
pause;
clc
%===========================================================================%


%=============================Decision Tree=================================%
fprintf('Decision Trees \n');

tree = MV_ID3(ex,attributes,ones(length(attributes),1));

predictions = zeros(150,1);
correct = 0;

for i = 1:150
    predictions(i) = ClassifyByTree(tree,attributes,ex(i,:));
    if(predictions(i) == ex(i,5) )
        correct = correct+1;
    end
end

accuracy = correct / size(ex,1);

fprintf('Accuracy on Tree: %f \n',accuracy);

%===========================================================================%
fprintf('Program paused. Press enter to continue.\n');
pause;
clc
%============================================================================%
[forests] = randomForest(ex,attributes);

classifications=zeros(150,2);

%testing out the data in the example set
for i = 1:150
    instance = ex(i,:);
    percentages = zeros(3,1);
    count = zeros(3,1);
    for j = 1:10
        tree = forests(j).tree;
        error = forests(j).oob;
        prediction = ClassifyByTree(tree,attributes,instance);
        percentages(prediction) = percentages(prediction) + (1-error);
        count(prediction) = count(prediction) + 1;
    end
    for j = 1:3
        if(count(j)>0)
            percentages(j) = percentages(j) / count(j);
        end
    end

    [classifications(i,1), classifications(i,2) ] = max(percentages);
end

correct =0;

%=================== Printing out the results of the forest================%
fprintf('Confidence \t \t Classification \n')
for i= 1:150
    if(classifications(i,2) == ex(i,5))
        correct = correct + 1;
    end
    if(classifications(i,2) == 1)
        fprintf('%f         \t     Iris-setosa \n',classifications(i,1));
    elseif (classifications(i,2) == 2)
        fprintf('%f         \t     Iris-versicolor \n',classifications(i,1));
    else
        fprintf('%f         \t     Iris-virginica \n',classifications(i,1));
    end
end

accuracy = correct / size(ex,1);

fprintf('Accuracy on Forest: %f \n',accuracy);

end
