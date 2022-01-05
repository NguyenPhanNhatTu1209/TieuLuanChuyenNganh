import 'package:freshfood/src/repository/book_repository.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  List<dynamic> listBook = [];
  int pageNum = 1;

  getBooks() {
    if (pageNum != -1) {
      BookRepository().getBooks(pageNum).then((value) {
        if (value.length > 0) {
          listBook.addAll(value);
          pageNum++;
          update();
        } else {
          pageNum = -1;
          update();
        }
      });
    }
  }
}
