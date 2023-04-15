function [] = PrintTree(tree, parent, bound)
% Prints the tree structure (preorder traversal)

% Print current node
 if (tree.value == 1);
     fprintf('parent: setosa\n' );
     return
elseif (tree.value == 3);
    fprintf('parent: virginica\n' );
    return
elseif (tree.value == 2);
    fprintf('parent: versicolor\n' );
    return    
else
    % Current node an attribute splitter
    fprintf('parent: %s\tattribute: %s\tChild:%s\tChild:%s\tBoundary:%s \n', ...
        parent, tree.value, tree.left.value, tree.right.value, bound);
end

% Recur the left subtree
PrintTree(tree.left, tree.value, tree.bound);

% Recur the right subtree
PrintTree(tree.right, tree.value, tree.bound);

end