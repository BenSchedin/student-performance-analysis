accuracyDiag <- function(table)
{
    matrix <- as.matrix(table)
    diagSum <- sum(diag(matrix))
    sumOfColSums <- sum(colSums(matrix))

    accuracy <- round(diagSum / sumOfColSums, 4) * 100

    return(accuracy)
}