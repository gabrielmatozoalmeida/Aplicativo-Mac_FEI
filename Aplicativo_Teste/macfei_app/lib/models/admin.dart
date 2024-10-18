import 'item.dart';

class Admin {
  List<Item> menu = [];

  void adicionarItem(Item item) {
    menu.add(item);
  }

  void removerItem(String itemName) {
    menu.removeWhere((item) => item.name == itemName);
  }

  void atualizarItem(String itemName, Item novoItem) {
    int index = menu.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      menu[index] = novoItem;
    }
  }

  List<Item> listarMenu() {
    return menu;
  }
}
