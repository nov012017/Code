# Create a vector filled with random normal values
u <- rnorm(30)
print("This loop calculates the square of the first 10 elements of vector u")

# Initialize `usq`
usq <- 0

for(i in 1:10) {
  # i-th element of `u` squared into `i`-th position of `usq`
  usq[i] <- u[i]*u[i]
  print(usq[i])
}

print(i)
