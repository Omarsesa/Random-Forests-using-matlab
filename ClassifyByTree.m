function classifications = ClassifyByTree(tree, attributes, instance)
    
    
    if( sum(strcmp(tree.value,attributes)) >0)
        index = find(ismember(attributes, tree.value) == 1);  % Finds the attribute that is being used to split
        if (instance(1, index) <= tree.bound ); % attribute is true for this instance
        % Recur down the right side
        classifications = ClassifyByTree(tree.right, attributes, instance); 
        else
        % Recur down the left side
        classifications = ClassifyByTree(tree.left, attributes, instance);
        end
    else
        classifications = tree.value;
        return
    end    
end
