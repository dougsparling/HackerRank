
object Solution {

    case class Task(deadline: Int, remaining: Int) {
        def howLate(now: Int) = now - deadline + remaining
    }

    def main(args: Array[String]) {
        def solve(deadlines: Seq[Int], minutes: Seq[Int]): Int {
            
        }

        Console.readLine // discard count
        val tasks = io.Source.stdin.getLines.map(line => Task(line.split(" ")(0), line.split(" ")(1)))

        1 to deadlines.size foreach { i =>
            println(solve(tasks.slice(0, i)))
        }
    }
}