class Queue_node<t>{
  t data;
  Queue_node<t>? next;

  Queue_node(this.data);
}

class cutom_queue<t>{
  Queue_node<t>? front ;
  Queue_node<t>? rear ;

  int size = 0;

  void enqueue(t data){
    Queue_node<t> newnode = Queue_node(data);

    if(rear == null){
      front = rear = newnode;
    }else{
      rear!.next = newnode;
      newnode.next = null;
      rear = newnode;
    }
    size++;
  }

  t? dequeue(){
    if(front == null){
      return null;
    }else{
      t temp = front!.data;
      front = front!.next;
      size--;
      return temp!;
    }

  }

  t? peek() {
    return front?.data;
  }

  void printQueue() {
    Queue_node<t>? current = front;
    while (current != null) {
      print(current.data);
      current = current.next;
    }
  }

  void clear() {
    front= null;
    rear = null;
    size = 0;
  }
  List<t> tolist(){
    List<t> list = [];
    Queue_node<t>? current = front;
    while(current != null){
      list.add(current.data);
      current = current.next;
    }
    return list;
  }
}





