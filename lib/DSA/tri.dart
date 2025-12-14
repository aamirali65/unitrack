class TrieNode {
  Map<String, TrieNode> children = {};
  List<Map<String, String>> students = [];
  bool isEnd = false;
}

class Trie {
  final TrieNode root = TrieNode();

  void insert(String name, Map<String, String> student) {
    TrieNode node = root;
    for (var char in name.toLowerCase().split('')) {
      node.children.putIfAbsent(char, () => TrieNode());
      node = node.children[char]!;
      node.students.add(student);
    }
    node.isEnd = true;
  }

  List<Map<String, String>> search(String prefix) {
    TrieNode node = root;
    for (var char in prefix.toLowerCase().split('')) {
      if (!node.children.containsKey(char)) {
        return [];
      }
      node = node.children[char]!;
    }
    return node.students;
  }
}
