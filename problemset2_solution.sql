WITH rankedSalaries As (
  SELECT
    DISTINCT e.departmentid,
    e.salary,
    dense_rank() OVER (
      PArtition BY e.departmentid
      ORDER BY
        e.salary DESC
    ) as rank
  FROM
    employee e
  ORDER BY
    e.departmentid,
    e.salary DESC
)
SELECT
  d.name as Department,
  e.name as Employee,
  e.salary as Salary
FROM
  employee e
  INNER JOIN department d ON e.departmentid = d.id
  INNER JOIN rankedSalaries r ON e.departmentid = r.departmentid
  AND e.salary = r.salary
WHERE
  r.rank <= 3
ORDER BY
  d.name,
  e.salary desc,
  e.name;