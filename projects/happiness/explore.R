args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 1)
raw <- read.csv(args[1], check.names = FALSE, na.strings = c("", "NA"))
stopifnot(all(c("Country name", "Ladder score") %in% names(raw)))
print(colSums(is.na(raw)))
complete <- raw[complete.cases(raw), ]
cat(nrow(raw), "input rows;", nrow(complete), "complete rows\n")
scores <- complete[["Ladder score"]]
print(summary(scores))
pdf("happiness-scores.pdf", width = 8, height = 5)
hist(scores, breaks = seq(0, 10, by = 0.5), main = "Life evaluations across countries",
     xlab = "Ladder score (0-10)", ylab = "Countries", col = "#276468", border = "white")
dev.off()
