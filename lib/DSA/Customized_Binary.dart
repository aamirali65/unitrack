class BinarySearch {
  static int search<T>(List<T> list, int Function (T element) comparator,){
   int low = 0;
   int high = list.length - 1;


   while(low <= high){
     int mid = (low + high) ~/ 2;

     int result = comparator(list[mid]);


     if(result == 0){
       return mid;
     }else if(result < 0 ){        //in generics we assume 0 as a target value
       low = mid + 1;
     } else{
       high = mid - 1;
     }
   }
    return -1;
  }
}