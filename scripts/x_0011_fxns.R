#functions

#2d kernel density estimation

get_density <- function(x, y, ...) {
  dens <- MASS::kde2d(x, y, ...)
  ix <- findInterval(x, dens$x)
  iy <- findInterval(y, dens$y)
  ii <- cbind(ix, iy)
  return(dens$z[ii])
}

set.seed(1)
dat <- data.frame(
  x = c(
    rnorm(1e4, mean = 0, sd = 0.1),
    rnorm(1e3, mean = 0, sd = 0.1)
  ),
  y = c(
    rnorm(1e4, mean = 0, sd = 0.1),
    rnorm(1e3, mean = 0.1, sd = 0.2)
  )
)

#convenience fxn for printing
conde <- function(obj) {
  obj <- obj %>% as.data.frame() %>% rownames_to_column()
  return(obj)
}
#make every character column in a datafram a factor column

character_to_factor_df <- function(data)  {
  for (i in 1:ncol(data)) { # For every column...
    if (typeof(data[[i]]) == 'character') { # if the column type is character...
      data[[i]] <- as.factor(data[[i]]) # Convert it to factor. 
    }
  }
  data
}

