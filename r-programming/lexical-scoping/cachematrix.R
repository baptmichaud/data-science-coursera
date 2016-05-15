## The following functions permit to create a matrix that cache its inverse 
# in order to enhance the performance as matrix inversion is a costly computation

# makeCacheMatrix creates a special "matrix" object that 
# can cache the matrix and his inverse.
makeCacheMatrix <- function(x = matrix()) {
        i <- NULL
        
        # Set function that cache the matrix into "x" var 
        #     and reset the inverse var "i"
        set <- function(y) {
                x <<- y
                i <<- NULL
        }
        
        # Get function that return the matrix
        get <- function() x
        
        # Set function that cache the inverse into "i" var
        setinverse <- function(inverse) i <<- inverse
        
        # Get function that return the cached inversed matrix
        getinverse <- function() i
        
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}

# cacheSolve computes the inverse of the special "matrix" created by makeCacheMatrix
# If the inverse has already been calculated (and the matrix has not changed)
# then the cacheSolve  retrieve the inverse of this matrix from the cache.
# It uses the solve function to compute the inverse
# arg "x" is a CachedMatrix
# arg "..." allow to set others arguments for solve
cacheSolve <- function(x, ...) {
        
        # get the inversed matrix
        i <- x$getinverse()
        
        # check if the inverse is already computed
        # and return cached data if yes
        if(!is.null(i)) {
                message("getting cached data")
                return(i)
        }
        
        # get back the matrix content
        data <- x$get()
        
        # inverse the matrix and cache it
        i <- solve(data, ...)
        x$setinverse(i)
        
        # return i
        i
}
