SELECT *
FROM `projeto.dataset.catfacts`
WHERE EXTRACT(YEAR FROM updatedAt) = 2020
  AND EXTRACT(MONTH FROM updatedAt) = 8