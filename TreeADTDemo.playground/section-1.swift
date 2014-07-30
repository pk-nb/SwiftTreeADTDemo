// Functional-Style Trees (ADTs!)
// http://en.wikipedia.org/wiki/Algebraic_data_type

// In Racket (plai-typed)
//http://www.eecs.northwestern.edu/~robby/courses/321-2013-winter/plai-typed/

//(define-type Tree
//  [leaf (val : number)]
//  [node (val : number)
//    (left : Tree)
//    (right : Tree)])


//; Sum
//(define (sum [t : Tree]) : number
//  (type-case Tree t
//    [leaf (val) val]
//    [node (val left right) (+ val (+ (sum left) (sum right))) ]))


import Cocoa

protocol TreeLike {}
enum Tree:TreeLike {
  case Leaf(Int)
  case Node(Int, TreeLike, TreeLike)
}

func sum(t: Tree) -> Int {
  switch t {
  case .Leaf(let value):
    return value
  case .Node(let value, let left, let right):
    return value + sum(left as Tree) + sum(right as Tree)
  }
}

func stringifyTree(t: Tree, _ level: Int = 0) -> String {
  switch t {
  case .Leaf(let value):
    return String(value).indent(level) + "\n"
  case .Node(let value, let left, let right):
    var string = ""
    string += stringifyTree(left as Tree, level + 1)
    string += String(value).indent(level) + "\n"
    string += stringifyTree(right as Tree, level + 1)
    return string
  }
}

extension String {
  func indent(level: Int, _ indents: String = "") -> String {
    switch level {
    case 0:
      return indents + self
    default:
      return "\t" + indent(level - 1)
    }
  }
}

// Test out the functions
let myTree = Tree.Node(4, Tree.Node(5, Tree.Leaf(1), Tree.Leaf(2)), Tree.Leaf(3))
println(stringifyTree(myTree))
println("Sum of myTree: \(sum(myTree))")

println("---")

let myTree2 = Tree.Node(22,
  Tree.Node(55,
    Tree.Leaf(11),
    Tree.Node(44,
      Tree.Leaf(77),
      Tree.Leaf(99))),
  Tree.Leaf(33))

println(stringifyTree(myTree2))
println("Sum of myTree2: \(sum(myTree2))")
