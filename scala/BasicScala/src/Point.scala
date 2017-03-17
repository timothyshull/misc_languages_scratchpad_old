/**
  * Created by skull on 10/16/16.
  */

trait Similarity {
  def isSimilar(x: Any): Boolean

  def isNotSimilar(x: Any): Boolean = !isSimilar(x)
}

class Point(var xc: Int, var yc: Int) extends Similarity {
  var x: Int = xc
  var y: Int = yc

  def isSimilar(obj: Any) = obj.isInstanceOf[Point] && obj.asInstanceOf[Point].x == x

  def move(dx: Int, dy: Int): Unit = {
    x = x + dx
    y = y + dy
  }

  override def toString: String = "(" + x + ", " + y + ")"
}

object TraitsTest extends App {
  val p1 = new Point(2, 3)
  val p2 = new Point(2, 4)
  val p3 = new Point(3, 3)
  println(p1.isNotSimilar(p2))
  println(p1.isNotSimilar(p3))
  println(p1.isNotSimilar(2))
}
