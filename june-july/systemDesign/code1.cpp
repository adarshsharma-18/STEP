#include <iostream>
using namespace std;

int main()
{
    int num = 100;
    cout<<"num = "<<num<<endl;                          //will be assigned 
    cout<<"Address of num = "<<(&num)<<endl;
    
    // int* const ptr;
    int* const ptr = &num;

    cout<<"ptr = "<<ptr<<endl;
    cout<<"Address of ptr = "<<(&ptr)<<endl;
    
    cout<<"Ptr is pointing to "<<(ptr)<<endl;
    cout<<"Accesing num through ptr"<<endl;
    cout<<"Num = "<<(*ptr)<<endl;

    return 0;
}

