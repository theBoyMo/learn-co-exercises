function Rectangle2(sides, width, height) {
  this.sides = sides
  this.width = width
  this.height = height
  this.area = function () {
    return this.width * this.height
  }
  this.perimeter = function () {
    return (this.width + this.height) * 2
  }
}

// Using constructor based inheritance
function Square(sides, length) {
  Rectangle2.call(this, sides, length, length)
}

let rectangle = new Rectangle2(4,4,2)
let square = new Square(4,4)
square.area() //=> 16
square.perimeter() //=> 16

// But our square is NOT inheriting from Rectangle, it copied the Rectangle at the time of instantiation.
Rectangle2.prototype.angles = 90
// all objects created from the Rectangle prototype will have access to the property
rectangle.angles //=> 90, prototype is Rectangle.prototype
square.angles //=> undefined, prototype is the constructor function(Square.prototype)

// Prototypal Inheritance

// 1. one common pattern is to combine function constructors with the object's prototype
function Shape(sides, x, y) {
  this.sides = sides
  this.x = x
  this.y = y
}

function Rectangle(x, y, width, height) {
  // call the superclass constructor
  Shape.call(this, 4, x, y)
  this.width = width
  this.height = height
}

// Rectangle can inherit from Shape by using Object.create() to set it's prototype to an instance of shape(otherwise it's prototype will be the constructor function)
Rectangle.prototype = Object.create(Shape.prototype)
// set Rectangle constructor to the proper function, otherwise it will be the Shape constructor
Rectangle.prototype.constructor = Rectangle

// extend the rectangle's behaviour(after setting Rectangle to the proper prototype)
Rectangle.prototype.area = function () {
  return this.width * this.height
}

Rectangle.prototype.perimeter = function () {
  return (this.width + this.height) * 2
}

rectangle instanceof Shape
//=> true
rectangle instanceof Rectangle
//=> true

// if we extend the behaviour of Shape
Shape.prototype.move = function (x, y) {
  this.x = x
  this.y = y
}

Shape.prototype.position = function () {
  return `${this.x}, ${this.y}`
}

// rectangle also inherits the behaviours(after the fact)
rectangle.position()
//=> "1, 1"
rectangle.move(2,3)
rectangle.position()
//=> "2, 3"
