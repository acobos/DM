x <- c(25, 50, 100, 150, 200)
f <- c(10, 25, 50, 30, 20)

dose <- numeric()

for (i in 1:5) {
  dose <- c(dose, rep(x[i], times = f[i]))
}

data.frame(pid = 1:length(dose),
           dose = mosaic::shuffle(paste(dose, "mg"))) %>%
  openxlsx::write.xlsx("doses.xlsx")
