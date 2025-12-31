class Hash_List_Node<k,v>{
  k key ;
  v value;
  Hash_List_Node<k,v>? next;

  Hash_List_Node(this.key, this.value);
}

class Hash_Map<k,v>{
  int default_size = 16;
  late List<Hash_List_Node<k,v>?> Bukets ;

  Hash_Map(){
    Bukets = List<Hash_List_Node<k,v>?>.filled(default_size,null);
  }


  //Hash function
int getindex(k key){
    int hashcode = key.hashCode;
    int index = hashcode % Bukets.length;
    return index;                         // return buket index
}


// insert or update
void put(k key, v value){
  int index = getindex(key);
  Hash_List_Node<k,v>? temp = Bukets[index];   // buket[index] is a head node

  while(temp != null){
    if(temp.key == key){
      temp.value = value;
      return;
    }
    temp = temp.next;
  }
  Hash_List_Node<k,v> newnode = Hash_List_Node(key, value);
  newnode.next = Bukets[index];
  Bukets[index]  = newnode;

}

// take key and return value

v? get(k key) {
  int index = getindex(key);
  Hash_List_Node<k, v>? temp = Bukets[index];
  while (temp != null) {
    if (temp.key == key) {
      return temp.value;
    }
    temp = temp.next;
  }
  return null;
}

//remove key
void remove(k key){
    int index = getindex(key);
    Hash_List_Node<k,v>? head = Bukets[index];
    Hash_List_Node<k,v>? prev = null;
    while(head != null){
      if(head.key == key){
        if(prev == null){             // if head is the first node
          Bukets[index] = head.next;   // then update head to next node
        }else{
          prev.next = head.next;
        }
        return;
      }
      prev = head;
      head = head.next;
    }
}

// search

v? containsKey(k key){
    if(get(key) != null){
      return get(key);
    }else{
      return null;
    }
}

// print
void printmap(){
    for(int i = 0; i <Bukets.length; i++){
      Hash_List_Node<k, v>? temp = Bukets[i];
      if(temp != null) {
        print("Buket $i:");
        while (temp != null) {
          print("${temp.key} : ${temp.value}");
          temp = temp.next;
        }
      }
    }
}

  void forEach(Null Function(k key, v value) param0) {}





}