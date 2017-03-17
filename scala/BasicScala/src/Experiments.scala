/**
  * Created by skull on 10/16/16.
  */

trait CustomTypeTrait {
  def getValue(): Int
}

class Experiments extends CustomTypeTrait {
  val x: Int = 10
  override def getValue(): Int = x
}

object CustomExperiments extends App {
  def staticMultiply[T <: CustomTypeTrait](inputVal : T) = inputVal.getValue() * 10
  val localVal = new Experiments()
  println(staticMultiply(localVal))
}
