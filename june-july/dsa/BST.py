class node:
    def __init__(self,val):
        self.val = val
        self.left=None 
        self.right=None
class BST:
    def __init__(self):
        self.root=None
    
    def insert(self, root , val):
        if root is None:
            return node(val)
        elif val< root.val:
           root.left = self.insert(root.left , val)
        else:
            root.right = self.insert(root.right , val)
        return root

    def inorder(self, root):
        if root:
            self.inorder(root.left)
            print(root.val, end=" ")
            self.inorder(root.right)

    def insert_val(self, val):
        self.root = self.insert(self.root, val)

    def print_tree(self):
        self.inorder(self.root)
        print()

# Create a BST object
bst = BST()

# Insert few elements
bst.insert_val(50)
bst.insert_val(30)
bst.insert_val(20)
bst.insert_val(40)
bst.insert_val(70)
bst.insert_val(60)
bst.insert_val(80)

# Print the tree
bst.print_tree()
