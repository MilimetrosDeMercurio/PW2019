/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.cpp
 * Author: 00148816
 *
 * Created on September 27, 2019, 3:50 PM
 */

#include<stdio.h>
#include<stdlib.h>

struct node{
    int key;
    struct node *left, *right;
};
// A utility function to create a new BST node
struct node *newNode(int item){
    struct node *temp = (struct node *)malloc(sizeof(struct node));
    temp->key = item;
    temp->left = temp->right = NULL;
    return temp;
}
// A utility function to do inorder traversal of BST
void inorder(struct node *root){
if (root != NULL){
    inorder(root->left);
    printf("%d \n", root->key);
    inorder(root->right);
    }
}

void preorder(struct node *root){
    if(root!=NULL){
        printf("%d \n", root->key);
        preorder(root->left);
        preorder(root->right);
    }
}
void postorder(struct node *root){
    if(root!=NULL){
        postorder(root->right);
        postorder(root->left);
        printf("%d \n", root->key);
    }
}

/* A utility function to insert a new node with given key in BST */
struct node* insert(struct node* node, int key)
{
    /* If the tree is empty, return a new node */
    if (node == NULL) return newNode(key);
    /* Otherwise, recur down the tree */
    if (key < node->key)
    node->left = insert(node->left, key);
    else if (key > node->key)
    node->right = insert(node->right, key);
    /* return the (unchanged) node pointer */
    return node;
}

struct node* min(struct node* node){
    while(node->left){
        node= node->left;
    }
    return node;
}

struct node* max(struct node* node){
    while(node->right){
        node= node->right;
    }
    return node;
}

struct node* deleteN(struct node* node,int key){
    if(node->key ==key){
        if(node->right==node->left){
            free(node);
            return NULL;
        }
        if(node->right != NULL && node->left==NULL){
            struct node* temp=node->right;
            free(node);
        }
        if(node->right == NULL && node->left!=NULL){
            struct node* temp=node->left;
            free(node);
        }
        if(node->right != NULL && node->left!=NULL){
            struct node* temp = min(node->right);
            //struct node* temp = max(node->left);
            node->key = temp->key;
            node->right = deleteN(node->right,node->key);
            //node->left = deleteN(node->left,node->key);
            return node;
            
        }
    }
    if(node==NULL){
        return node;
    }
    if(key < node->key){
        node->left = deleteN(node->left,key);
    }
    else if(key > node->key){
        node->right = deleteN(node->right,key);
    }
    return node;
    
} 

// Driver Program to test above functions
int main()
{
    /* Let us create following BST
    50
    / \
    30 70
    / \ / \
    20 40 60 80 */
    struct node *root = NULL;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 20);
    insert(root, 40);
    insert(root, 70);
    insert(root, 60);
    insert(root, 80);
    //deleteN(root, 40);
    // print inoder traversal of the BST
    printf("In Order: \n");
    inorder(root);
    printf("Pre Order: \n");
    preorder(root);
    printf("Post Order: \n");
    postorder(root);
    return 0;
}


