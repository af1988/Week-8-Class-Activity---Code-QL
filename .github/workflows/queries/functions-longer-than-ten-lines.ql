/**
 * @description Find functions longer than ten lines
 * @kind problem
 * @id javascript/functions-longer-than-ten-lines.ql
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is longer than ten lines.
 */
predicate isLongerThanTenLines(Function f) {
  f.getNumLines() > 10
}

from Function f
where isLongerThanTenLines(f)
select f, "Found function longer than ten lines"

