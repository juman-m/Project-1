import 'package:library_project/book.dart';
import 'package:library_project/data.dart';
import 'dart:io';

int purchaseNum = 0;
num totalPurchaseAmount = 0;
void main(List<String> arguments) {
  int userSelection = 0;
  bool isInputsTrue = false;
  bool quit = false;

//convert the list of maps to list of object
  List library = [];
  for (var element in bookData) {
    Book book = Book(
        title: element["title"],
        author: element["author"],
        category: element["category"],
        price: element["prices"],
        copysNum: element["copysNum"]);
    library.add(book);
  }

  while (!quit) {
    //loop to exit the program
    print(
        "Welcome to the library system! How can I help you this time :) \n1: Search For Book \n2: Add New Book \n3: Delete a Book \n4: Purchase a Book \n5: Edit a Book \n6: Reporting \n7: Display books by Categories\n8: Quit");
    while (!isInputsTrue) {
      // check the user inputs
      try {
        userSelection = int.parse(stdin.readLineSync()!);
        if (userSelection >= 9 || userSelection <= 0) {
          print("Please try again, enter numbers from 1 to 8 ");
        } else {
          isInputsTrue = true;
        }
      } catch (error) {
        print("Please try again, enter numbers from 1 to 8 ");
      }
    }
    isInputsTrue = false;

    switch (userSelection) {
      case 1:
        queryBooks(library);
        break;

      case 2:
        library = addNewBook(library);
        break;

      case 3:
        library = deleteBook(library);
        break;
      case 4:
        library = purchaseBook(library);
        break;

      case 5:
        library = editBook(library);
        break;

      case 6:
        report();
        break;

      case 7:
        displayCategories(library);
        break;

      case 8:
        print("Have a nice day :)");
        quit = true;
        break;
    }
  }
}

queryBooks(List library) {
  int searchSelection = 0;
  bool isInputsTrue = false;
  List<Book> userQuery = [];

// user input
  print(
      "Would you like to search by .... \n1:Book Title \n2:Book Author \n3:Book Category");

  while (!isInputsTrue) {
    try {
      searchSelection = int.parse(stdin.readLineSync()!);
      if (searchSelection >= 4 || searchSelection <= 0) {
        print("Please try again, enter numbers from 1 to 3 ");
      } else {
        isInputsTrue = true;
      }
    } catch (error) {
      print("Please try again, enter numbers from 1 to 3 ");
    }
  }
//search cases
  switch (searchSelection) {
    case 1:
      print("Sure, what's the book title?");
      String? userTitle = stdin.readLineSync();
      userTitle = userTitle?.toLowerCase(); //to be not case sensitive

      for (var book in library) {
        // add the book fulfills the condition
        if (userTitle!.compareTo(book.title.toLowerCase()) == 0) {
          userQuery.add(book);
        }
      }
      if (userQuery.isEmpty) {
        // the title not found
        print("Book not found\n----------------");
      } else {
        // title found
        print("Here is the search resut");
        print("----------------");
        for (var element in userQuery) {
          print(element.display());
          print("----------------");
        }
      }
      break;

    case 2:
      print("Sure, what's the book author?");
      String? userAuthor = stdin.readLineSync();

      for (var book in library) {
        // add the book fulfills the condition
        if (userAuthor!.toLowerCase().compareTo(book.author.toLowerCase()) ==
            0) {
          userQuery.add(book);
        }
      }
      if (userQuery.isEmpty) {
        // the author not found
        print("Book not found\n----------------");
      } else {
        // author found
        print("Here is the search resut");
        print("----------------");
        for (var element in userQuery) {
          print(element.display());
          print("----------------");
        }
      }
      break;

    case 3:
      print("Sure, what's the book category?");
      String? userCategory = stdin.readLineSync();

      for (var book in library) {
        // add the book fulfills the condition
        if (userCategory!
                .toLowerCase()
                .compareTo(book.category.toLowerCase()) ==
            0) {
          userQuery.add(book);
        }
      }
      if (userQuery.isEmpty) {
        // the category not found
        print("Book not found\n----------------");
      } else {
        // category found
        print("Here is the search resut");
        print("----------------");
        for (var book in userQuery) {
          print(book.display());
          print("----------------");
        }
      }
      break;
  }
}

List addNewBook(List library) {
  print("Sure, what's the book title?");
  String? userTitle = stdin.readLineSync(); //user input
  Book newBook =
      Book(title: "", author: "", category: "", price: 0, copysNum: 0);
  bool titleFound = false;
  bool isInputsTrue = false;

  for (var book in library) {
    // if the book already exist
    if (userTitle!.compareTo(book.title) == 0) {
      book.copysNum++;
      titleFound = true;
      print("The book has been added successfully\n----------------");
      print(book.display());
      print("----------------");
    }
  }
  if (!titleFound) {
    // if it new book
    newBook.title = userTitle;
    print("What's the book author?");
    newBook.author = stdin.readLineSync();
    print("What's the book category:");
    newBook.category = stdin.readLineSync();
    print("What's the book price:");

    while (!isInputsTrue) {
      // chech the price
      try {
        newBook.price = double.parse(stdin.readLineSync()!);
        if (newBook.price! < 0) {
          // check if it negative num
          print("Please try again,enter a valid price");
        } else {
          isInputsTrue = true;
        }
      } catch (error) {
        print("Please try again, enter numbers only");
      }
    }
    isInputsTrue = false;
    print("How many copies available:");
    while (!isInputsTrue) {
      // chech the copys num
      try {
        newBook.copysNum = int.parse(stdin.readLineSync()!);
        if (newBook.copysNum! <= 0) {
          // check if it negative num
          print("Please try again,enter a valid number of copies");
        } else {
          isInputsTrue = true;
        }
      } catch (error) {
        print("Please try again, enter numbers only");
      }
    }
  }
  if (newBook.title != "") {
    //add the book
    library.add(newBook);
    print("The book has been added successfully\n----------------");
    print(newBook.display());
    print("----------------");
  }
  return library;
}

List deleteBook(List library) {
  bool isInputsTrue = false;
  int userID = 0;
  List<Book> updatedLibrary = [];
  bool idFound = false;

  print("Sure, what's the book ID you want to delete?");

  while (!isInputsTrue) {
    // check the inputs
    try {
      userID = int.parse(stdin.readLineSync()!);
      for (var book in library) {
        if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
          isInputsTrue = true;
        }
      }
      if (!isInputsTrue) {
        print("ID not found, Please try again");
      }
    } catch (error) {
      print("ID not found, Please try again");
    }
  }
  for (var book in library) {
    if (userID.compareTo(book.id) == 0 && book.copysNum == 0) {
      //there is no remaining copies
      print("ID not found ");
    }
    if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
      //sold the book
      book.copysNum--;
      idFound = true;
      print("The book has been deleted successfully\n----------------");
      print(book.display());
      print("----------------");
    }
    if (book.copysNum != 0) {
      // add the books to the list
      updatedLibrary.add(book);
    }
  }

  if (!idFound) {
    print("Book is not found");
  }
  return updatedLibrary;
}

List purchaseBook(List library) {
  int userSelection = 0;
  bool isInputsTrue = false;
  List<Book> updatedLibrary = [];
  List<Book> soldBooks = [];
  num totalCost = 0;
  int userID = 0;
  bool checkout = false;

  while (!checkout) {
    // loop to continue shopping
    isInputsTrue = false;
    print("Sure, what's the book ID you want to buy?");
    while (!isInputsTrue) {
      // check the inputs
      try {
        userID = int.parse(stdin.readLineSync()!);
        for (var book in library) {
          if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
            isInputsTrue = true;
          }
        }
        if (!isInputsTrue) {
          print("ID not found, Please try again");
        }
      } catch (error) {
        print("ID not found, Please try again");
      }
    }
    for (var book in library) {
      if (userID.compareTo(book.id) == 0 && book.copysNum == 0) {
        //there is no remaining copies
        print("ID not found ");
      }
      if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
        //sold the book
        book.copysNum--;
        soldBooks.add(book);
      }
    }

    isInputsTrue = false; // reuse the Variable
    print("Do you want...\n1: Continue shopping \n2: Checkout");

    while (!isInputsTrue) {
      // check the inputs
      try {
        userSelection = int.parse(stdin.readLineSync()!);
        if (userSelection >= 3 || userSelection <= 0) {
          print("Please try again, enter 1 or 2 ");
        } else {
          isInputsTrue = true;
        }
      } catch (error) {
        print("Please try again, enter 1 or 2 ");
      }
    }

    isInputsTrue = false;

    if (userSelection == 2) {
      //print the invoice
      print("----------------");
      print("THE INVOICE");
      print("----------------");
      for (var book in soldBooks) {
        print(book.display());
        print("***************");
        totalCost += book.price as num;
        purchaseNum += 1;
        totalPurchaseAmount += book.price as num;
      }
      print("The total Cost is $totalCost SAR");
      print("----------------");
      checkout = true;
      break;
    }
  }

  for (var element in library) {
    // check num of copies and add the book to the list
    if (element.copysNum != 0) {
      updatedLibrary.add(element);
    }
  }
  return updatedLibrary;
}

List editBook(List library) {
  bool isInputsTrue = false;
  int userID = 0;
  Book newBook =
      Book(title: "", author: "", category: "", price: 0, copysNum: 0);

  print("What's the book ID you want to edit?");
  while (!isInputsTrue) {
    try {
      userID = int.parse(stdin.readLineSync()!);
      for (var book in library) {
        if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
          isInputsTrue = true;
        }
      }
      if (!isInputsTrue) {
        print("ID not found, Please try again");
      }
    } catch (error) {
      print("ID not found, Please try again");
    }
  }

  print("What's the book title?");
  newBook.title = stdin.readLineSync();
  print("What's the book author?");
  newBook.author = stdin.readLineSync();
  print("What's the book category?");
  newBook.category = stdin.readLineSync();
  print("What's the book prices?");

  isInputsTrue = false;
  while (!isInputsTrue) {
    // chech the price
    try {
      newBook.price = double.parse(stdin.readLineSync()!);
      if (newBook.price! < 0) {
        // check if it negative num
        print("Please try again,enter a valid price");
      } else {
        isInputsTrue = true;
      }
    } catch (error) {
      print("Please try again, enter numbers only");
    }
  }
  isInputsTrue = false;
  print("How many copies available:");
  while (!isInputsTrue) {
    // chech the copies num
    try {
      newBook.copysNum = int.parse(stdin.readLineSync()!);
      if (newBook.copysNum! <= 0) {
        // check if it negative num
        print("Please try again,enter a valid number of copies");
      } else {
        isInputsTrue = true;
      }
    } catch (error) {
      print("Please try again, enter numbers only");
    }
  }

  for (var book in library) {
    //edit the book valus
    if (userID.compareTo(book.id) == 0 && book.copysNum > 0) {
      book.title = newBook.title;
      book.author = newBook.author;
      book.category = newBook.category;
      book.price = newBook.price;
      book.copysNum = newBook.copysNum;
      print("The book has been modified successfully\n----------------");
      print(book.display());
      print("----------------");
    }
  }
  return library;
}

report() {
  print("----------------");
  print("REPORT:");
  print(
      "\nThe total number of purchased books: $purchaseNum \n\nThe total purchase amount: $totalPurchaseAmount");
  print("----------------");
}

displayCategories(List library) {
  Set<String> categories = {};
  List<Book> booksInCategory = [];

  for (var book in library) {
    categories.add(book.category!);
  }

  print("List of Book Categories:");
  for (var category in categories) {
    print(category);
  }
  print("----------------");
  print("Enter the desired category");
  String? userInput = stdin.readLineSync();

  for (var book in library) {
    if (book.category!.toLowerCase().compareTo(userInput!.toLowerCase()) == 0) {
      booksInCategory.add(book);
    }
  }

  if (booksInCategory.isEmpty) {
    print("No books found in the selected category.");
  } else {
    print("Books in the selected category:");
    for (var book in booksInCategory) {
      print(book.display());
      print("----------------");
    }
  }
}
