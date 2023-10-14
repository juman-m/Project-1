class Book{
String? title;
String? author;
String? category;
num? price;
int? copysNum;
// int? purchaseNum=0;
static int numBook =0;
int? id;

Book({required String this.title, required String this.author, required String this.category , required num this.price, required int this.copysNum}){
  numBook+=1;
  id=numBook;
}


String display(){
  return "Book ID: $id\nBook title: $title \nBook author: $author \nBook category: $category  \nRemaining copies: $copysNum\nPrice: $price SAR"; 
}

}