int main(){
    int a = 0;
    for(int i = 10; i >= 0; i --){
        a++;
    }
    // a -= i; esta linea estaba en el codigo, pero como vemos no compila (el scope de i esta limitado al loop)
    return a;
}