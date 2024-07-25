fibonacci <- function(n) {
  # Check if the input is valid
  if (n <= 0) {
    stop("The number of terms must be a positive integer.")
  }
  
  # Initialize the first two terms of the Fibonacci sequence
  fib_seq <- numeric(n)
  fib_seq[1] <- 0
  if (n > 1) {
    fib_seq[2] <- 1
  }
  
  # Generate the Fibonacci sequence
  for (i in 3:n) {
    fib_seq[i] <- fib_seq[i - 1] + fib_seq[i - 2]
  }
  
  return(fib_seq)
}

# Example usage
print(fibonacci(10))  # Should return the first 10 terms of the Fibonacci sequence