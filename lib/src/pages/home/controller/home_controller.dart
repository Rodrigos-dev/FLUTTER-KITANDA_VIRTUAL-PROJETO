import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = []; 

  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  bool get isLastPage {//
    if (currentCategory!.items.length < itemsPerPage) return true;

    return currentCategory!.pagination * itemsPerPage > allProducts.length;
  }

  RxString searchTitle = ''.obs; 

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit(){
    super.onInit();

    debounce(searchTitle, (_) =>
      filterByTitle(),
      //update(),
      //print(searchTitle);
    
      time: const Duration(milliseconds: 600),
    );

    //if(currentCategory!.items.isNotEmpty) return;

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    getAllProducts();    
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult = await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data); //assignAll sobrescreve o array tira os itens que tem e coloca os novos
      
        //print('Todas as categorias: $allCategories');
        if(allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      }, 
      
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true
        );
      }
    );

  }


  Future<void> getAllProducts({bool canLoad = true}) async {
    
    if(canLoad){
      setLoading(true);      
    }
    

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,      
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage
    };

    if(searchTitle.value.isNotEmpty){
      body['title'] = searchTitle.value;

      if(currentCategory!.id == ''){
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false);

    result.when(
      success: (data) {
        print('$canLoad, oooo');
        //print('$data, controller teste all products');         
               
          currentCategory!.items.addAll(data);        
      }, 
      
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true
        );
      }
    );


  }


  void loadMoreProducts(){//
    currentCategory!.pagination++;

    getAllProducts(canLoad: false);
  }


  void filterByTitle() {
    //1 - apagar todos os produtos das categorias
    for(var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if(searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    }else {
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id =='');
    
      if(c == null) {
        //2 - criar uma nova coategoria com todos os produtos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);     
      }else {
        c.items.clear();
        c.pagination = 0;
      }   
    }

    currentCategory = allCategories.first;

    update();

    getAllProducts();
  }

  
}